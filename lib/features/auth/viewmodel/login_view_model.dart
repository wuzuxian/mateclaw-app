import 'dart:io';

import 'package:flutter/foundation.dart';

import '../../../core/debug/debug_log.dart';
import '../../../core/network/api_client.dart';
import '../data/auth_repository.dart';
import 'auth_session.dart';

class LoginViewModel extends ChangeNotifier {
  LoginViewModel({
    required AuthRepository authRepository,
    required AuthSession authSession,
  }) : _authRepository = authRepository,
       _authSession = authSession;

  final AuthRepository _authRepository;
  final AuthSession _authSession;

  bool _isLoading = false;
  LoginError? _error;

  bool get isLoading => _isLoading;

  LoginError? get error => _error;

  Future<bool> login({
    required String username,
    required String password,
  }) async {
    if (_isLoading) {
      return false;
    }

    final normalizedUsername = username.trim();
    if (normalizedUsername.isEmpty) {
      _setError(LoginError.emptyUsername);
      return false;
    }
    if (password.isEmpty) {
      _setError(LoginError.emptyPassword);
      return false;
    }

    _isLoading = true;
    _error = null;
    notifyListeners();
    debugLog(
      'LoginViewModel.login start',
      data: {'username': normalizedUsername},
    );

    try {
      final session = await _authRepository.login(
        username: normalizedUsername,
        password: password,
      );
      await _authSession.update(session);
      debugLog(
        'LoginViewModel.login success',
        data: {'userId': session.user.id, 'username': session.user.username},
      );
      _isLoading = false;
      notifyListeners();
      return true;
    } on ApiException catch (error) {
      debugLog(
        'LoginViewModel.login api error',
        data: {
          'type': error.type.name,
          'statusCode': error.statusCode,
          'apiCode': error.apiCode,
          'message': error.message,
        },
      );
      _isLoading = false;
      _error = _mapApiException(error);
      notifyListeners();
      return false;
    } catch (_) {
      debugLog('LoginViewModel.login unknown error');
      _isLoading = false;
      _error = LoginError.unknown;
      notifyListeners();
      return false;
    }
  }

  void clearError() {
    if (_error == null) {
      return;
    }

    _error = null;
    notifyListeners();
  }

  void _setError(LoginError error) {
    _error = error;
    notifyListeners();
  }

  LoginError _mapApiException(ApiException error) {
    if (error.type == ApiExceptionType.network) {
      return LoginError.network;
    }
    if (error.type == ApiExceptionType.invalidResponse) {
      return LoginError.invalidResponse;
    }

    final status = error.statusCode ?? error.apiCode;
    return switch (status) {
      HttpStatus.unauthorized => LoginError.invalidCredentials,
      HttpStatus.tooManyRequests => LoginError.rateLimited,
      _ => LoginError.server,
    };
  }
}

enum LoginError {
  emptyUsername,
  emptyPassword,
  invalidCredentials,
  rateLimited,
  network,
  server,
  invalidResponse,
  unknown,
}
