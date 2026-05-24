import 'package:flutter_test/flutter_test.dart';
import 'package:mateclaw_app/core/network/api_client.dart';
import 'package:mateclaw_app/features/auth/data/auth_repository.dart';

void main() {
  test('parses nested user from login payload', () {
    final session = authSessionStateFromLoginData({
      'token': 'access-token',
      'user': {
        'id': 42,
        'username': 'admin',
        'nickname': '管理员',
        'role': 'admin',
      },
      'workspace': {'id': 7, 'name': 'Default'},
    });

    expect(session.token, 'access-token');
    expect(session.user.id, 42);
    expect(session.user.username, 'admin');
    expect(session.user.nickname, '管理员');
    expect(session.user.role, 'admin');
  });

  test('rejects login payload without a valid user id', () {
    expect(
      () => authSessionStateFromLoginData({
        'token': 'access-token',
        'user': {'username': 'admin'},
      }),
      throwsA(isA<ApiException>()),
    );
  });
}
