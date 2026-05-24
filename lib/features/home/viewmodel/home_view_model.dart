import 'package:flutter/foundation.dart';

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
      return;
    }
    _hasLoaded = true;

    _isLoading = true;
    notifyListeners();

    HomeDashboardData? cachedData;
    try {
      cachedData = await _repository.readCachedHome();
    } catch (_) {
      cachedData = null;
    }
    if (cachedData != null) {
      _data = cachedData;
      notifyListeners();
    }

    await refresh();
  }

  Future<void> refresh() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _data = await _repository.refreshHome();
    } on ApiException catch (error) {
      _error = HomeLoadError.fromApiException(error);
    } catch (_) {
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
