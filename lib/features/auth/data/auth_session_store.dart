import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';

import 'auth_models.dart';

abstract class AuthSessionStore {
  Future<AuthSessionState?> read();

  Future<void> save(AuthSessionState state);

  Future<void> clear();

  Future<void> close();
}

class SqfliteAuthSessionStore implements AuthSessionStore {
  Database? _database;

  static const _databaseName = 'mateclaw.db';
  static const _databaseVersion = 1;
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
    await _database?.close();
    _database = null;
  }

  Future<Database> _openDatabase() async {
    final existingDatabase = _database;
    if (existingDatabase != null) {
      return existingDatabase;
    }

    final databasePath = await getDatabasesPath();
    final database = await openDatabase(
      path.join(databasePath, _databaseName),
      version: _databaseVersion,
      onCreate: (database, version) async {
        await database.execute('''
CREATE TABLE $_sessionTable (
  id INTEGER PRIMARY KEY,
  token TEXT NOT NULL,
  user_id INTEGER NOT NULL,
  username TEXT NOT NULL,
  nickname TEXT NOT NULL,
  role TEXT NOT NULL,
  updated_at INTEGER NOT NULL
)
''');
      },
    );
    _database = database;
    return database;
  }
}
