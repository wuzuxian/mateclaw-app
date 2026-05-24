import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mateclaw_app/app.dart';
import 'package:mateclaw_app/features/auth/data/auth_models.dart';
import 'package:mateclaw_app/features/auth/data/auth_session_store.dart';
import 'package:mateclaw_app/features/auth/viewmodel/auth_session.dart';

void main() {
  testWidgets('shows login page', (tester) async {
    await tester.pumpWidget(
      MateclawApp(authSessionStore: _InMemoryAuthSessionStore()),
    );
    await tester.pumpAndSettle();

    expect(find.byType(MateclawApp), findsOneWidget);
    expect(find.text('Mate'), findsOneWidget);
    expect(find.text('Claw'), findsOneWidget);
    expect(find.byType(TextField), findsNWidgets(2));
    expect(find.byType(FilledButton), findsOneWidget);
  });

  test('restores persisted auth session', () async {
    final session = AuthSession(
      store: _InMemoryAuthSessionStore(
        initialState: const AuthSessionState(
          token: 'token',
          user: AuthUser(
            id: 1,
            username: 'admin',
            nickname: '管理员',
            role: 'admin',
          ),
        ),
      ),
    );

    await session.restore();

    expect(session.isInitialized, isTrue);
    expect(session.isAuthenticated, isTrue);
    expect(session.token, 'token');
    expect(session.user?.username, 'admin');
  });
}

class _InMemoryAuthSessionStore implements AuthSessionStore {
  _InMemoryAuthSessionStore({AuthSessionState? initialState})
    : _state = initialState;

  AuthSessionState? _state;

  @override
  Future<AuthSessionState?> read() async => _state;

  @override
  Future<void> save(AuthSessionState state) async {
    _state = state;
  }

  @override
  Future<void> clear() async {
    _state = null;
  }

  @override
  Future<void> close() async {}
}
