import 'package:flutter/foundation.dart';

import '../../../core/debug/debug_log.dart';
import '../../../core/network/api_client.dart';
import '../data/home_models.dart';
import '../data/home_repository.dart';

class HomeViewModel extends ChangeNotifier {
  HomeViewModel({required HomeRepository repository})
    : _repository = repository;

  final HomeRepository _repository;

  HomeDashboardData? _data;
  bool _isLoading = false;
  bool _hasLoaded = false;
  HomeLoadError? _error;

  HomeDashboardData? get data => _data;

  bool get isLoading => _isLoading;

  bool get hasData => _data != null;

  HomeLoadError? get error => _error;

  Future<void> load() async {
    if (_hasLoaded) {
      debugLog('HomeViewModel.load skipped');
      return;
    }
    _hasLoaded = true;

    _isLoading = true;
    notifyListeners();
    debugLog('HomeViewModel.load start');

    HomeDashboardData? cachedData;
    try {
      cachedData = await _repository.readCachedHome();
      debugLog(
        'HomeViewModel.load cache result',
        data: {
          'hasCachedData': cachedData != null,
          'workspaceId': cachedData?.workspaceId,
        },
      );
    } catch (_) {
      debugLog('HomeViewModel.load cache read failed');
      cachedData = null;
    }
    if (cachedData != null) {
      _data = cachedData;
      notifyListeners();
    }

    final canReachBackend = await _repository.canReachBackend();
    debugLog(
      'HomeViewModel.load backend reachability',
      data: {'canReachBackend': canReachBackend},
    );
    if (!canReachBackend) {
      _error = cachedData == null ? HomeLoadError.network : null;
      _isLoading = false;
      notifyListeners();
      return;
    }

    await refresh();
  }

  Future<void> refresh() async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    debugLog('HomeViewModel.refresh start');

    final canReachBackend = await _repository.canReachBackend();
    debugLog(
      'HomeViewModel.refresh backend reachability',
      data: {'canReachBackend': canReachBackend},
    );
    if (!canReachBackend) {
      if (_data == null) {
        try {
          _data = await _repository.readCachedHome();
          debugLog(
            'HomeViewModel.refresh cache fallback',
            data: {'hasCachedData': _data != null},
          );
        } catch (_) {}
      }
      if (_data == null) {
        _error = HomeLoadError.network;
      }
      _isLoading = false;
      notifyListeners();
      return;
    }

    try {
      _data = await _repository.refreshHome();
      debugLog(
        'HomeViewModel.refresh success',
        data: {
          'workspaceId': _data?.workspaceId,
          'isFromCache': _data?.isFromCache,
        },
      );
    } on ApiException catch (error) {
      final loadError = HomeLoadError.fromApiException(error);
      debugLog(
        'HomeViewModel.refresh api error',
        data: {
          'type': error.type.name,
          'statusCode': error.statusCode,
          'apiCode': error.apiCode,
          'mappedError': loadError.name,
        },
      );
      if (_data == null || loadError != HomeLoadError.invalidResponse) {
        _error = loadError;
      }
    } catch (_) {
      debugLog('HomeViewModel.refresh unknown error');
      _error = HomeLoadError.unknown;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}

enum HomeLoadError {
  network,
  unauthorized,
  forbidden,
  server,
  invalidResponse,
  unknown;

  static HomeLoadError fromApiException(ApiException exception) {
    if (exception.statusCode == 401 || exception.apiCode == 401) {
      return HomeLoadError.unauthorized;
    }
    if (exception.statusCode == 403 || exception.apiCode == 403) {
      return HomeLoadError.forbidden;
    }

    return switch (exception.type) {
      ApiExceptionType.network => HomeLoadError.network,
      ApiExceptionType.invalidResponse => HomeLoadError.invalidResponse,
      ApiExceptionType.server => HomeLoadError.server,
    };
  }
}
