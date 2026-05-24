import 'package:sqflite/sqflite.dart';

import '../../../core/debug/debug_log.dart';
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
    debugLog('AuthSessionStore.read start');
    final rows = await (await _openDatabase()).query(
      _sessionTable,
      where: 'id = ?',
      whereArgs: [_sessionId],
      limit: 1,
    );
    if (rows.isEmpty) {
      debugLog('AuthSessionStore.read empty');
      return null;
    }

    final row = rows.first;
    final token = row['token'] as String? ?? '';
    if (token.isEmpty) {
      debugLog('AuthSessionStore.read token empty');
      return null;
    }

    final state = AuthSessionState(
      token: token,
      user: AuthUser(
        id: row['user_id'] as int? ?? 0,
        username: row['username'] as String? ?? '',
        nickname: row['nickname'] as String? ?? '',
        role: row['role'] as String? ?? '',
      ),
    );
    debugLog(
      'AuthSessionStore.read success',
      data: {
        'userId': state.user.id,
        'username': state.user.username,
        'tokenLength': state.token.length,
      },
    );
    return state;
  }

  @override
  Future<void> save(AuthSessionState state) async {
    debugLog(
      'AuthSessionStore.save',
      data: {
        'userId': state.user.id,
        'username': state.user.username,
        'tokenLength': state.token.length,
      },
    );
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
    debugLog('AuthSessionStore.clear');
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
