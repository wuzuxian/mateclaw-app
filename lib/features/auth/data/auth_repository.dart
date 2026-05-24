import '../../../core/network/api_client.dart';
import 'auth_models.dart';

class AuthRepository {
  const AuthRepository({required ApiClient apiClient}) : _apiClient = apiClient;

  final ApiClient _apiClient;

  Future<AuthSessionState> login({
    required String username,
    required String password,
  }) async {
    final response = await _apiClient.postJson(
      '/api/mobile/user/login',
      body: {'username': username, 'password': password},
      requiresAuthorization: false,
    );

    final data = response.data;
    if (data is! Map<String, Object?>) {
      throw const ApiException(type: ApiExceptionType.invalidResponse);
    }

    final token = data['token'] as String? ?? '';
    if (token.isEmpty) {
      throw const ApiException(type: ApiExceptionType.invalidResponse);
    }

    return AuthSessionState(token: token, user: AuthUser.fromJson(data));
  }
}
