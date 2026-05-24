import 'dart:io';

import 'package:flutter/foundation.dart';

import '../../../core/debug/debug_log.dart';
import '../../../core/network/api_client.dart';
import '../data/auth_repository.dart';
import 'auth_session.dart';

class RegisterViewModel extends ChangeNotifier {
  RegisterViewModel({
    required AuthRepository authRepository,
    required AuthSession authSession,
  }) : _authRepository = authRepository,
       _authSession = authSession;

  final AuthRepository _authRepository;
  final AuthSession _authSession;

  bool _isLoading = false;
  RegisterError? _error;

  bool get isLoading => _isLoading;

  RegisterError? get error => _error;

  Future<bool> register({
    required String username,
    required String password,
    required String nickname,
    required String workspaceName,
  }) async {
    if (_isLoading) {
      return false;
    }

    final normalizedUsername = username.trim();
    final normalizedNickname = nickname.trim();
    final normalizedWorkspaceName = workspaceName.trim();
    if (normalizedUsername.isEmpty) {
      _setError(RegisterError.emptyUsername);
      return false;
    }
    if (password.isEmpty) {
      _setError(RegisterError.emptyPassword);
      return false;
    }

    _isLoading = true;
    _error = null;
    notifyListeners();
    debugLog(
      'RegisterViewModel.register start',
      data: {'username': normalizedUsername},
    );

    try {
      final session = await _authRepository.register(
        username: normalizedUsername,
        password: password,
        nickname: normalizedNickname.isEmpty ? null : normalizedNickname,
        workspaceName: normalizedWorkspaceName.isEmpty
            ? null
            : normalizedWorkspaceName,
      );
      await _authSession.update(session);
      debugLog(
        'RegisterViewModel.register success',
        data: {'userId': session.user.id, 'username': session.user.username},
      );
      _isLoading = false;
      notifyListeners();
      return true;
    } on ApiException catch (error) {
      debugLog(
        'RegisterViewModel.register api error',
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
      debugLog('RegisterViewModel.register unknown error');
      _isLoading = false;
      _error = RegisterError.unknown;
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

  void _setError(RegisterError error) {
    _error = error;
    notifyListeners();
  }

  RegisterError _mapApiException(ApiException error) {
    if (error.type == ApiExceptionType.network) {
      return RegisterError.network;
    }
    if (error.type == ApiExceptionType.invalidResponse) {
      return RegisterError.invalidResponse;
    }

    final status = error.statusCode ?? error.apiCode;
    return switch (status) {
      HttpStatus.conflict => RegisterError.usernameTaken,
      HttpStatus.badRequest => RegisterError.invalidInput,
      HttpStatus.tooManyRequests => RegisterError.rateLimited,
      _ => RegisterError.server,
    };
  }
}

enum RegisterError {
  emptyUsername,
  emptyPassword,
  usernameTaken,
  invalidInput,
  rateLimited,
  network,
  server,
  invalidResponse,
  unknown,
}
