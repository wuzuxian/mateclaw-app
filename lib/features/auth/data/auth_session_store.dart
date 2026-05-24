import 'package:sqflite/sqflite.dart';

import '../../../core/storage/app_database.dart';
import 'auth_models.dart';

abstract class AuthSessionStore {
  Future<AuthSessionState?> read();

  Future<void> save(AuthSessionState state);

  Future<void> clear();

  Future<void> close();
}

class SqfliteAuthSessionStore implements AuthSessionStore {
  static const _sessionTable = 'auth_session';
  static const _sessionId = 1;

  @override
  Future<AuthSessionState?> read() async {
    final rows = await (await _openDatabase()).query(
      _sessionTable,
      where: 'id = ?',
      whereArgs: [_sessionId],
      limit: 1,
    );
    if (rows.isEmpty) {
      return null;
    }

    final row = rows.first;
    final token = row['token'] as String? ?? '';
    if (token.isEmpty) {
      return null;
    }

    return AuthSessionState(
      token: token,
      user: AuthUser(
        id: row['user_id'] as int? ?? 0,
        username: row['username'] as String? ?? '',
        nickname: row['nickname'] as String? ?? '',
        role: row['role'] as String? ?? '',
      ),
    );
  }

  @override
  Future<void> save(AuthSessionState state) async {
    await (await _openDatabase()).insert(_sessionTable, {
      'id': _sessionId,
      'token': state.token,
      'user_id': state.user.id,
      'username': state.user.username,
      'nickname': state.user.nickname,
      'role': state.user.role,
      'updated_at': DateTime.now().millisecondsSinceEpoch,
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  @override
  Future<void> clear() async {
    await (await _openDatabase()).delete(
      _sessionTable,
      where: 'id = ?',
      whereArgs: [_sessionId],
    );
  }

  @override
  Future<void> close() async {
    await AppDatabase.close();
  }

  Future<Database> _openDatabase() async {
    return AppDatabase.open();
  }
}
