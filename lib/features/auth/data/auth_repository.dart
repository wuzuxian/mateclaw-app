import 'dart:convert';

import '../../../core/debug/debug_log.dart';
import '../../../core/network/api_client.dart';
import 'auth_models.dart';

class AuthRepository {
  const AuthRepository({required ApiClient apiClient}) : _apiClient = apiClient;

  final ApiClient _apiClient;

  Future<AuthSessionState> login({
    required String username,
    required String password,
  }) async {
    debugLog('AuthRepository.login request', data: {'username': username});
    final response = await _apiClient.postJson(
      '/api/mobile/user/login',
      body: {'username': username, 'password': password},
      requiresAuthorization: false,
    );

    final data = _mapValue(response.data);
    if (data == null) {
      throw const ApiException(type: ApiExceptionType.invalidResponse);
    }

    final session = authSessionStateFromLoginData(data);
    final userData = _mapValue(data['user']) ?? data;
    final user = session.user;
    final token = session.token;
    debugLog(
      'AuthRepository.login response',
      data: {
        'keys': data.keys.toList(),
        'userKeys': userData.keys.toList(),
        'tokenLength': token.length,
        'parsedUserId': user.id,
        'parsedUsername': user.username,
      },
    );

    return session;
  }

  Future<void> logout() async {
    await _apiClient.postJson(
      '/api/mobile/user/logout',
      body: const <String, Object?>{},
    );
  }
}

AuthSessionState authSessionStateFromLoginData(Map<String, Object?> data) {
  final token = data['token'] as String? ?? '';
  if (token.isEmpty) {
    throw const ApiException(type: ApiExceptionType.invalidResponse);
  }

  final userData = _mapValue(data['user']) ?? data;
  final user = AuthUser.fromJson(userData);
  if (user.id <= 0) {
    throw const ApiException(type: ApiExceptionType.invalidResponse);
  }

  return AuthSessionState(token: token, user: user);
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
