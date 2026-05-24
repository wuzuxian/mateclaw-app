import 'dart:convert';

import 'package:sqflite/sqflite.dart';

import '../../../core/debug/debug_log.dart';
import '../../../core/storage/app_database.dart';
import 'home_models.dart';

class HomeCacheStore {
  const HomeCacheStore();

  static const _profileTable = 'home_profile_cache';
  static const _workspaceTable = 'workspace_cache';
  static const _workspaceStateTable = 'workspace_state';
  static const _homeSnapshotTable = 'home_snapshot_cache';
  static const _ownerTable = 'home_cache_owner';
  static const _ownerId = 1;
  static const _workspaceStateId = 1;

  Future<HomeUserProfile?> readProfile(int userId) async {
    if (!await _isOwner(userId)) {
      debugLog(
        'HomeCacheStore.readProfile owner mismatch',
        data: {'userId': userId},
      );
      return null;
    }

    debugLog('HomeCacheStore.readProfile start', data: {'userId': userId});
    final rows = await (await AppDatabase.open()).query(
      _profileTable,
      orderBy: 'updated_at DESC',
      limit: 1,
    );
    if (rows.isEmpty) {
      debugLog('HomeCacheStore.readProfile empty', data: {'userId': userId});
      return null;
    }

    debugLog('HomeCacheStore.readProfile hit', data: {'userId': userId});
    return _profileFromRow(rows.first);
  }

  Future<void> saveProfile(int userId, HomeUserProfile profile) async {
    debugLog(
      'HomeCacheStore.saveProfile start',
      data: {'userId': userId, 'profileId': profile.id},
    );
    await _prepareOwner(userId);
    await (await AppDatabase.open()).insert(_profileTable, {
      'id': profile.id,
      'username': profile.username,
      'nickname': profile.nickname,
      'avatar': profile.avatar,
      'email': profile.email,
      'role': profile.role,
      'enabled': profile.enabled ? 1 : 0,
      'updated_at': DateTime.now().millisecondsSinceEpoch,
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<int?> readDefaultWorkspaceId(int userId) async {
    if (!await _isOwner(userId)) {
      debugLog(
        'HomeCacheStore.readDefaultWorkspaceId owner mismatch',
        data: {'userId': userId},
      );
      return null;
    }

    debugLog(
      'HomeCacheStore.readDefaultWorkspaceId start',
      data: {'userId': userId},
    );
    final rows = await (await AppDatabase.open()).query(
      _workspaceStateTable,
      columns: ['default_workspace_id'],
      where: 'id = ?',
      whereArgs: [_workspaceStateId],
      limit: 1,
    );
    if (rows.isEmpty) {
      debugLog(
        'HomeCacheStore.readDefaultWorkspaceId empty',
        data: {'userId': userId},
      );
      return null;
    }

    final workspaceId = rows.first['default_workspace_id'] as int?;
    debugLog(
      'HomeCacheStore.readDefaultWorkspaceId hit',
      data: {'userId': userId, 'workspaceId': workspaceId},
    );
    return workspaceId;
  }

  Future<List<HomeWorkspace>> readWorkspaces(int userId) async {
    if (!await _isOwner(userId)) {
      debugLog(
        'HomeCacheStore.readWorkspaces owner mismatch',
        data: {'userId': userId},
      );
      return const [];
    }

    debugLog('HomeCacheStore.readWorkspaces start', data: {'userId': userId});
    final rows = await (await AppDatabase.open()).query(
      _workspaceTable,
      orderBy: 'is_default DESC, updated_at DESC',
    );

    debugLog(
      'HomeCacheStore.readWorkspaces hit',
      data: {'userId': userId, 'workspaceCount': rows.length},
    );
    return rows.map(_workspaceFromRow).toList(growable: false);
  }

  Future<void> saveWorkspaces({
    required int userId,
    required int defaultWorkspaceId,
    required List<HomeWorkspace> workspaces,
  }) async {
    debugLog(
      'HomeCacheStore.saveWorkspaces start',
      data: {
        'userId': userId,
        'defaultWorkspaceId': defaultWorkspaceId,
        'workspaceCount': workspaces.length,
      },
    );
    await _prepareOwner(userId);
    final database = await AppDatabase.open();
    await database.transaction((transaction) async {
      await transaction.delete(_workspaceTable);
      final updatedAt = DateTime.now().millisecondsSinceEpoch;
      for (final workspace in workspaces) {
        await transaction.insert(_workspaceTable, {
          'id': workspace.id,
          'name': workspace.name,
          'slug': workspace.slug,
          'role': workspace.role,
          'is_default': workspace.isDefault ? 1 : 0,
          'member_count': workspace.memberCount,
          'role_count': workspace.roleCount,
          'agent_count': workspace.agentCount,
          'updated_at': updatedAt,
        }, conflictAlgorithm: ConflictAlgorithm.replace);
      }
      await transaction.insert(_workspaceStateTable, {
        'id': _workspaceStateId,
        'default_workspace_id': defaultWorkspaceId,
        'updated_at': updatedAt,
      }, conflictAlgorithm: ConflictAlgorithm.replace);
    });
  }

  Future<HomeSnapshot?> readHomeSnapshot({
    required int userId,
    required int workspaceId,
  }) async {
    if (!await _isOwner(userId)) {
      debugLog(
        'HomeCacheStore.readHomeSnapshot owner mismatch',
        data: {'userId': userId, 'workspaceId': workspaceId},
      );
      return null;
    }

    debugLog(
      'HomeCacheStore.readHomeSnapshot start',
      data: {'userId': userId, 'workspaceId': workspaceId},
    );
    final rows = await (await AppDatabase.open()).query(
      _homeSnapshotTable,
      columns: ['payload_json'],
      where: 'workspace_id = ?',
      whereArgs: [workspaceId],
      limit: 1,
    );
    if (rows.isEmpty) {
      debugLog(
        'HomeCacheStore.readHomeSnapshot empty',
        data: {'userId': userId, 'workspaceId': workspaceId},
      );
      return null;
    }

    final payloadJson = rows.first['payload_json'] as String? ?? '';
    final Object? decoded;
    try {
      decoded = jsonDecode(payloadJson);
    } on FormatException {
      debugLog(
        'HomeCacheStore.readHomeSnapshot invalid payload',
        data: {'userId': userId, 'workspaceId': workspaceId},
      );
      return null;
    }
    if (decoded is! Map<String, Object?>) {
      debugLog(
        'HomeCacheStore.readHomeSnapshot unexpected payload',
        data: {'userId': userId, 'workspaceId': workspaceId},
      );
      return null;
    }

    debugLog(
      'HomeCacheStore.readHomeSnapshot hit',
      data: {'userId': userId, 'workspaceId': workspaceId},
    );
    return HomeSnapshot.fromJson(decoded);
  }

  Future<void> saveHomeSnapshot({
    required int userId,
    required int workspaceId,
    required Map<String, Object?> payload,
  }) async {
    debugLog(
      'HomeCacheStore.saveHomeSnapshot start',
      data: {'userId': userId, 'workspaceId': workspaceId},
    );
    await _prepareOwner(userId);
    await (await AppDatabase.open()).insert(_homeSnapshotTable, {
      'workspace_id': workspaceId,
      'payload_json': jsonEncode(payload),
      'updated_at': DateTime.now().millisecondsSinceEpoch,
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> clear() async {
    debugLog('HomeCacheStore.clear');
    final database = await AppDatabase.open();
    await database.transaction((transaction) async {
      await transaction.delete(_profileTable);
      await transaction.delete(_workspaceTable);
      await transaction.delete(_workspaceStateTable);
      await transaction.delete(_homeSnapshotTable);
    });
  }

  Future<bool> _isOwner(int userId) async {
    final rows = await (await AppDatabase.open()).query(
      _ownerTable,
      columns: ['user_id'],
      where: 'id = ?',
      whereArgs: [_ownerId],
      limit: 1,
    );
    if (rows.isEmpty) {
      debugLog(
        'HomeCacheStore._isOwner missing owner',
        data: {'userId': userId},
      );
      return false;
    }

    final isOwner = rows.first['user_id'] == userId;
    if (!isOwner) {
      debugLog(
        'HomeCacheStore._isOwner mismatch',
        data: {'userId': userId, 'ownerUserId': rows.first['user_id']},
      );
    }
    return isOwner;
  }

  Future<void> _prepareOwner(int userId) async {
    if (await _isOwner(userId)) {
      debugLog(
        'HomeCacheStore._prepareOwner already owned',
        data: {'userId': userId},
      );
      return;
    }

    debugLog(
      'HomeCacheStore._prepareOwner switch owner',
      data: {'userId': userId},
    );
    final database = await AppDatabase.open();
    await database.transaction((transaction) async {
      await transaction.delete(_profileTable);
      await transaction.delete(_workspaceTable);
      await transaction.delete(_workspaceStateTable);
      await transaction.delete(_homeSnapshotTable);
      await transaction.insert(_ownerTable, {
        'id': _ownerId,
        'user_id': userId,
        'updated_at': DateTime.now().millisecondsSinceEpoch,
      }, conflictAlgorithm: ConflictAlgorithm.replace);
    });
  }

  HomeUserProfile _profileFromRow(Map<String, Object?> row) {
    return HomeUserProfile(
      id: row['id'] as int? ?? 0,
      username: row['username'] as String? ?? '',
      nickname: row['nickname'] as String? ?? '',
      avatar: row['avatar'] as String?,
      email: row['email'] as String?,
      role: row['role'] as String? ?? '',
      enabled: (row['enabled'] as int? ?? 0) == 1,
    );
  }

  HomeWorkspace _workspaceFromRow(Map<String, Object?> row) {
    return HomeWorkspace(
      id: row['id'] as int? ?? 0,
      name: row['name'] as String? ?? '',
      slug: row['slug'] as String? ?? '',
      role: row['role'] as String? ?? '',
      isDefault: (row['is_default'] as int? ?? 0) == 1,
      memberCount: row['member_count'] as int? ?? 0,
      roleCount: row['role_count'] as int? ?? 0,
      agentCount: row['agent_count'] as int? ?? 0,
    );
  }
}
