import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';

abstract final class AppDatabase {
  static const name = 'mateclaw.db';
  static const version = 3;

  static Database? _database;

  static Future<Database> open() async {
    final existingDatabase = _database;
    if (existingDatabase != null) {
      return existingDatabase;
    }

    final databasePath = await getDatabasesPath();
    final database = await openDatabase(
      path.join(databasePath, name),
      version: version,
      onCreate: (database, version) async {
        await _createAuthSessionTable(database);
        await _createHomeCacheTables(database);
      },
      onUpgrade: (database, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await _createHomeCacheTables(database);
        }
        if (oldVersion < 3) {
          await _createHomeCacheOwnerTable(database);
        }
      },
    );

    _database = database;
    return database;
  }

  static Future<void> close() async {
    await _database?.close();
    _database = null;
  }

  static Future<void> _createAuthSessionTable(Database database) async {
    await database.execute('''
CREATE TABLE IF NOT EXISTS auth_session (
  id INTEGER PRIMARY KEY,
  token TEXT NOT NULL,
  user_id INTEGER NOT NULL,
  username TEXT NOT NULL,
  nickname TEXT NOT NULL,
  role TEXT NOT NULL,
  updated_at INTEGER NOT NULL
)
''');
  }

  static Future<void> _createHomeCacheTables(Database database) async {
    await _createHomeCacheOwnerTable(database);
    await database.execute('''
CREATE TABLE IF NOT EXISTS home_profile_cache (
  id INTEGER PRIMARY KEY,
  username TEXT NOT NULL,
  nickname TEXT NOT NULL,
  avatar TEXT,
  email TEXT,
  role TEXT NOT NULL,
  enabled INTEGER NOT NULL,
  updated_at INTEGER NOT NULL
)
''');
    await database.execute('''
CREATE TABLE IF NOT EXISTS workspace_cache (
  id INTEGER PRIMARY KEY,
  name TEXT NOT NULL,
  slug TEXT NOT NULL,
  role TEXT NOT NULL,
  is_default INTEGER NOT NULL,
  member_count INTEGER NOT NULL,
  role_count INTEGER NOT NULL,
  agent_count INTEGER NOT NULL,
  updated_at INTEGER NOT NULL
)
''');
    await database.execute('''
CREATE TABLE IF NOT EXISTS workspace_state (
  id INTEGER PRIMARY KEY,
  default_workspace_id INTEGER NOT NULL,
  updated_at INTEGER NOT NULL
)
''');
    await database.execute('''
CREATE TABLE IF NOT EXISTS home_snapshot_cache (
  workspace_id INTEGER PRIMARY KEY,
  payload_json TEXT NOT NULL,
  updated_at INTEGER NOT NULL
)
''');
  }

  static Future<void> _createHomeCacheOwnerTable(Database database) async {
    await database.execute('''
CREATE TABLE IF NOT EXISTS home_cache_owner (
  id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  updated_at INTEGER NOT NULL
)
''');
  }
}
