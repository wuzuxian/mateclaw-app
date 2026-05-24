import 'dart:convert';

import '../../../core/debug/debug_log.dart';
import '../../../core/network/api_client.dart';
import 'home_cache_store.dart';
import 'home_models.dart';

class HomeRepository {
  const HomeRepository({
    required ApiClient apiClient,
    required HomeCacheStore cacheStore,
    required int? Function() userIdProvider,
  }) : _apiClient = apiClient,
       _cacheStore = cacheStore,
       _userIdProvider = userIdProvider;

  final ApiClient _apiClient;
  final HomeCacheStore _cacheStore;
  final int? Function() _userIdProvider;

  Future<HomeDashboardData?> readCachedHome() async {
    debugLog('HomeRepository.readCachedHome start');
    final userId = _currentUserId('readCachedHome');
    final workspaceId = await _cacheStore.readDefaultWorkspaceId(userId);
    if (workspaceId == null) {
      debugLog(
        'HomeRepository.readCachedHome no workspace',
        data: {'userId': userId},
      );
      return null;
    }

    final snapshot = await _cacheStore.readHomeSnapshot(
      userId: userId,
      workspaceId: workspaceId,
    );
    if (snapshot == null) {
      debugLog(
        'HomeRepository.readCachedHome no snapshot',
        data: {'userId': userId, 'workspaceId': workspaceId},
      );
      return null;
    }

    debugLog(
      'HomeRepository.readCachedHome hit',
      data: {'userId': userId, 'workspaceId': workspaceId},
    );
    return HomeDashboardData(
      workspaceId: workspaceId,
      profile: await _cacheStore.readProfile(userId),
      workspaces: await _cacheStore.readWorkspaces(userId),
      snapshot: snapshot,
      isFromCache: true,
    );
  }

  Future<HomeDashboardData> refreshHome({int recentRunLimit = 5}) async {
    debugLog(
      'HomeRepository.refreshHome start',
      data: {'recentRunLimit': recentRunLimit},
    );
    final userId = _currentUserId('refreshHome');
    final profile = await _fetchAndCacheProfile();
    final workspaceBundle = await _fetchAndCacheWorkspaces();
    final workspaceId = workspaceBundle.defaultWorkspaceId;
    debugLog(
      'HomeRepository.refreshHome workspace ready',
      data: {
        'userId': userId,
        'workspaceId': workspaceId,
        'profileLoaded': profile != null,
        'workspaceCount': workspaceBundle.workspaces.length,
      },
    );

    final response = await _apiClient.getJson(
      '/api/v1/mobile/home',
      queryParameters: {'recentRunLimit': recentRunLimit},
      headers: {'X-Workspace-Id': workspaceId.toString()},
    );

    final data = _payloadMap(response.data);
    if (data == null) {
      throw const ApiException(type: ApiExceptionType.invalidResponse);
    }

    debugLog(
      'HomeRepository.refreshHome response received',
      data: {'userId': userId, 'workspaceId': workspaceId},
    );
    await _cacheStore.saveHomeSnapshot(
      userId: userId,
      workspaceId: workspaceId,
      payload: data,
    );
    debugLog(
      'HomeRepository.refreshHome cached snapshot',
      data: {'userId': userId, 'workspaceId': workspaceId},
    );

    return HomeDashboardData(
      workspaceId: workspaceId,
      profile: profile ?? await _cacheStore.readProfile(userId),
      workspaces: workspaceBundle.workspaces,
      snapshot: HomeSnapshot.fromJson(data),
      isFromCache: false,
    );
  }

  Future<void> clearCachedHome() {
    debugLog('HomeRepository.clearCachedHome');
    return _cacheStore.clear();
  }

  Future<bool> canReachBackend() {
    return _apiClient.canReachBackend();
  }

  Future<HomeUserProfile?> _fetchAndCacheProfile() async {
    try {
      debugLog('HomeRepository.fetchProfile start');
      final response = await _apiClient.getJson('/api/mobile/user/profile');
      final data = _payloadMap(response.data);
      if (data == null) {
        debugLog('HomeRepository.fetchProfile invalid response');
        return null;
      }

      final profile = HomeUserProfile.fromJson(
        _mapValue(_pick(data, ['user'])) ?? data,
      );
      final userId = _currentUserId('saveProfile');
      await _cacheStore.saveProfile(userId, profile);
      debugLog(
        'HomeRepository.fetchProfile cached',
        data: {'userId': userId, 'profileId': profile.id},
      );
      return profile;
    } on ApiException {
      debugLog('HomeRepository.fetchProfile api error');
      return null;
    }
  }

  Future<_WorkspaceBundle> _fetchAndCacheWorkspaces() async {
    try {
      debugLog('HomeRepository.fetchWorkspaces start');
      final response = await _apiClient.getJson('/api/mobile/user/workspaces');
      final data = _payloadMap(response.data);
      if (data == null) {
        debugLog('HomeRepository.fetchWorkspaces invalid response');
        throw const ApiException(type: ApiExceptionType.invalidResponse);
      }

      final defaultWorkspaceId = _intValue(
        _pick(data, ['defaultWorkspaceId', 'default_workspace_id']),
      );
      final workspacesValue = _pick(data, [
        'workspaces',
        'workspaceList',
        'workspace_list',
      ]);
      final workspaces =
          [
                workspacesValue,
                _mapValue(workspacesValue)?['items'],
                _mapValue(workspacesValue)?['list'],
                _mapValue(workspacesValue)?['records'],
              ]
              .map(_listValue)
              .firstWhere((value) => value != null, orElse: () => null)
              ?.map(_mapValue)
              .whereType<Map<String, Object?>>()
              .map(HomeWorkspace.fromJson)
              .toList(growable: false) ??
          const <HomeWorkspace>[];
      if (defaultWorkspaceId == 0 || workspaces.isEmpty) {
        throw const ApiException(type: ApiExceptionType.invalidResponse);
      }

      final userId = _currentUserId('saveWorkspaces');
      await _cacheStore.saveWorkspaces(
        userId: userId,
        defaultWorkspaceId: defaultWorkspaceId,
        workspaces: workspaces,
      );
      debugLog(
        'HomeRepository.fetchWorkspaces cached',
        data: {
          'userId': userId,
          'defaultWorkspaceId': defaultWorkspaceId,
          'workspaceCount': workspaces.length,
        },
      );

      return _WorkspaceBundle(
        defaultWorkspaceId: defaultWorkspaceId,
        workspaces: workspaces,
      );
    } on ApiException {
      final userId = _currentUserId('fetchWorkspacesFallback');
      final cachedWorkspaceId = await _cacheStore.readDefaultWorkspaceId(
        userId,
      );
      final cachedWorkspaces = await _cacheStore.readWorkspaces(userId);
      if (cachedWorkspaceId == null || cachedWorkspaces.isEmpty) {
        debugLog(
          'HomeRepository.fetchWorkspaces cache fallback failed',
          data: {
            'userId': userId,
            'hasWorkspaceId': cachedWorkspaceId != null,
            'workspaceCount': cachedWorkspaces.length,
          },
        );
        rethrow;
      }

      debugLog(
        'HomeRepository.fetchWorkspaces cache fallback hit',
        data: {
          'userId': userId,
          'defaultWorkspaceId': cachedWorkspaceId,
          'workspaceCount': cachedWorkspaces.length,
        },
      );
      return _WorkspaceBundle(
        defaultWorkspaceId: cachedWorkspaceId,
        workspaces: cachedWorkspaces,
      );
    }
  }

  int _currentUserId(String source) {
    final userId = _userIdProvider.call();
    if (userId == null || userId <= 0) {
      debugLog(
        'HomeRepository.$source userId unavailable',
        data: {'userId': userId},
      );
      throw const ApiException(type: ApiExceptionType.invalidResponse);
    }
    debugLog(
      'HomeRepository.$source userId resolved',
      data: {'userId': userId},
    );
    return userId;
  }
}

class _WorkspaceBundle {
  const _WorkspaceBundle({
    required this.defaultWorkspaceId,
    required this.workspaces,
  });

  final int defaultWorkspaceId;
  final List<HomeWorkspace> workspaces;
}

int _intValue(Object? value) {
  return switch (value) {
    final int value => value,
    final String value => int.tryParse(value) ?? 0,
    _ => 0,
  };
}

Map<String, Object?>? _mapValue(Object? value) {
  if (value is Map<String, Object?>) {
    return value;
  }
  if (value is Map) {
    return value.map((key, value) => MapEntry(key.toString(), value));
  }
  if (value is String && value.isNotEmpty) {
    try {
      final decoded = jsonDecode(value);
      if (decoded is Map) {
        return decoded.map((key, value) => MapEntry(key.toString(), value));
      }
    } on FormatException {
      return null;
    }
  }
  return null;
}

Map<String, Object?>? _payloadMap(Object? value) {
  final map = _mapValue(value);
  if (map == null) {
    return null;
  }

  final nested = _mapValue(_pick(map, ['data', 'result', 'payload']));
  return nested ?? map;
}

List<Object?>? _listValue(Object? value) {
  if (value is List<Object?>) {
    return value;
  }
  if (value is List) {
    return value.cast<Object?>();
  }
  if (value is String && value.isNotEmpty) {
    try {
      final decoded = jsonDecode(value);
      if (decoded is List) {
        return decoded.cast<Object?>();
      }
    } on FormatException {
      return null;
    }
  }
  return null;
}

Object? _pick(Map<String, Object?> json, List<String> keys) {
  for (final key in keys) {
    if (json.containsKey(key)) {
      return json[key];
    }
  }
  return null;
}
