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
    final userId = _currentUserId();
    final workspaceId = await _cacheStore.readDefaultWorkspaceId(userId);
    if (workspaceId == null) {
      return null;
    }

    final snapshot = await _cacheStore.readHomeSnapshot(
      userId: userId,
      workspaceId: workspaceId,
    );
    if (snapshot == null) {
      return null;
    }

    return HomeDashboardData(
      workspaceId: workspaceId,
      profile: await _cacheStore.readProfile(userId),
      workspaces: await _cacheStore.readWorkspaces(userId),
      snapshot: snapshot,
      isFromCache: true,
    );
  }

  Future<HomeDashboardData> refreshHome({int recentRunLimit = 5}) async {
    final userId = _currentUserId();
    final profile = await _fetchAndCacheProfile();
    final workspaceBundle = await _fetchAndCacheWorkspaces();
    final workspaceId = workspaceBundle.defaultWorkspaceId;

    final response = await _apiClient.getJson(
      '/api/v1/mobile/home',
      queryParameters: {'recentRunLimit': recentRunLimit},
      headers: {'X-Workspace-Id': workspaceId.toString()},
    );

    final data = response.data;
    if (data is! Map<String, Object?>) {
      throw const ApiException(type: ApiExceptionType.invalidResponse);
    }

    await _cacheStore.saveHomeSnapshot(
      userId: userId,
      workspaceId: workspaceId,
      payload: data,
    );

    return HomeDashboardData(
      workspaceId: workspaceId,
      profile: profile ?? await _cacheStore.readProfile(userId),
      workspaces: workspaceBundle.workspaces,
      snapshot: HomeSnapshot.fromJson(data),
      isFromCache: false,
    );
  }

  Future<HomeUserProfile?> _fetchAndCacheProfile() async {
    try {
      final response = await _apiClient.getJson('/api/mobile/user/profile');
      final data = response.data;
      if (data is! Map<String, Object?>) {
        return null;
      }

      final profile = HomeUserProfile.fromJson(data);
      await _cacheStore.saveProfile(_currentUserId(), profile);
      return profile;
    } on ApiException {
      return null;
    }
  }

  Future<_WorkspaceBundle> _fetchAndCacheWorkspaces() async {
    try {
      final response = await _apiClient.getJson('/api/mobile/user/workspaces');
      final data = response.data;
      if (data is! Map<String, Object?>) {
        throw const ApiException(type: ApiExceptionType.invalidResponse);
      }

      final defaultWorkspaceId = _intValue(data['defaultWorkspaceId']);
      final workspaces = switch (data['workspaces']) {
        final List<Object?> value =>
          value
              .whereType<Map<String, Object?>>()
              .map(HomeWorkspace.fromJson)
              .toList(growable: false),
        _ => const <HomeWorkspace>[],
      };
      if (defaultWorkspaceId == 0 || workspaces.isEmpty) {
        throw const ApiException(type: ApiExceptionType.invalidResponse);
      }

      await _cacheStore.saveWorkspaces(
        userId: _currentUserId(),
        defaultWorkspaceId: defaultWorkspaceId,
        workspaces: workspaces,
      );

      return _WorkspaceBundle(
        defaultWorkspaceId: defaultWorkspaceId,
        workspaces: workspaces,
      );
    } on ApiException {
      final userId = _currentUserId();
      final cachedWorkspaceId = await _cacheStore.readDefaultWorkspaceId(
        userId,
      );
      final cachedWorkspaces = await _cacheStore.readWorkspaces(userId);
      if (cachedWorkspaceId == null || cachedWorkspaces.isEmpty) {
        rethrow;
      }

      return _WorkspaceBundle(
        defaultWorkspaceId: cachedWorkspaceId,
        workspaces: cachedWorkspaces,
      );
    }
  }

  int _currentUserId() {
    final userId = _userIdProvider.call();
    if (userId == null || userId <= 0) {
      throw const ApiException(type: ApiExceptionType.invalidResponse);
    }
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
