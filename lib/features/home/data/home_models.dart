import 'dart:convert';

class HomeDashboardData {
  const HomeDashboardData({
    required this.workspaceId,
    required this.profile,
    required this.workspaces,
    required this.snapshot,
    required this.isFromCache,
  });

  final int workspaceId;
  final HomeUserProfile? profile;
  final List<HomeWorkspace> workspaces;
  final HomeSnapshot snapshot;
  final bool isFromCache;

  HomeDashboardData copyWith({bool? isFromCache}) {
    return HomeDashboardData(
      workspaceId: workspaceId,
      profile: profile,
      workspaces: workspaces,
      snapshot: snapshot,
      isFromCache: isFromCache ?? this.isFromCache,
    );
  }
}

class HomeUserProfile {
  const HomeUserProfile({
    required this.id,
    required this.username,
    required this.nickname,
    required this.role,
    required this.enabled,
    this.avatar,
    this.email,
  });

  factory HomeUserProfile.fromJson(Map<String, Object?> json) {
    return HomeUserProfile(
      id: _intValue(json['id']),
      username: _stringValue(
        _pick(json, ['username', 'userName', 'user_name']),
      ),
      nickname: _stringValue(
        _pick(json, ['nickname', 'nickName', 'nick_name']),
      ),
      avatar:
          _stringValue(
            _pick(json, ['avatar', 'avatarUrl', 'avatar_url']),
          ).isEmpty
          ? null
          : _stringValue(_pick(json, ['avatar', 'avatarUrl', 'avatar_url'])),
      email:
          _stringValue(
            _pick(json, ['email', 'emailAddress', 'email_address']),
          ).isEmpty
          ? null
          : _stringValue(
              _pick(json, ['email', 'emailAddress', 'email_address']),
            ),
      role: _stringValue(_pick(json, ['role', 'userRole', 'user_role'])),
      enabled: _boolValue(json['enabled']) ?? true,
    );
  }

  final int id;
  final String username;
  final String nickname;
  final String? avatar;
  final String? email;
  final String role;
  final bool enabled;
}

class HomeWorkspace {
  const HomeWorkspace({
    required this.id,
    required this.name,
    required this.slug,
    required this.role,
    required this.isDefault,
    required this.memberCount,
    required this.roleCount,
    required this.agentCount,
  });

  factory HomeWorkspace.fromJson(Map<String, Object?> json) {
    return HomeWorkspace(
      id: _intValue(json['id']),
      name: _stringValue(
        _pick(json, ['name', 'workspaceName', 'workspace_name']),
      ),
      slug: _stringValue(
        _pick(json, ['slug', 'workspaceSlug', 'workspace_slug']),
      ),
      role: _stringValue(
        _pick(json, ['role', 'workspaceRole', 'workspace_role']),
      ),
      isDefault: _boolValue(_pick(json, ['isDefault', 'is_default'])) ?? false,
      memberCount: _intValue(_pick(json, ['memberCount', 'member_count'])),
      roleCount: _intValue(_pick(json, ['roleCount', 'role_count'])),
      agentCount: _intValue(_pick(json, ['agentCount', 'agent_count'])),
    );
  }

  final int id;
  final String name;
  final String slug;
  final String role;
  final bool isDefault;
  final int memberCount;
  final int roleCount;
  final int agentCount;
}

class HomeSnapshot {
  const HomeSnapshot({
    required this.currentModel,
    required this.todayCard,
    required this.periods,
    required this.recentRuns,
  });

  factory HomeSnapshot.fromJson(Map<String, Object?> json) {
    return HomeSnapshot(
      currentModel: _modelFromJson(json),
      todayCard: _todayCardFromJson(json),
      periods: _periodsFromJson(json),
      recentRuns: _recentRunsFromJson(json),
    );
  }

  final HomeCurrentModel? currentModel;
  final HomeTodayCard todayCard;
  final List<HomePeriodStats> periods;
  final List<HomeRecentRun> recentRuns;
}

class HomeCurrentModel {
  const HomeCurrentModel({
    required this.providerId,
    required this.providerName,
    required this.model,
    required this.status,
    required this.statusText,
  });

  factory HomeCurrentModel.fromJson(Map<String, Object?> json) {
    return HomeCurrentModel(
      providerId: _stringValue(_pick(json, ['providerId', 'provider_id'])),
      providerName: _stringValue(
        _pick(json, ['providerName', 'provider_name']),
      ),
      model: _stringValue(_pick(json, ['model', 'modelName', 'model_name'])),
      status: _stringValue(
        _pick(json, ['status', 'state']),
        fallback: 'unknown',
      ),
      statusText: _stringValue(
        _pick(json, ['statusText', 'status_text', 'stateText', 'state_text']),
      ),
    );
  }

  final String providerId;
  final String providerName;
  final String model;
  final String status;
  final String statusText;
}

class HomeTodayCard {
  const HomeTodayCard({
    required this.conversations,
    required this.messages,
    required this.toolCalls,
    required this.healthStatus,
    required this.healthText,
  });

  const HomeTodayCard.empty()
    : conversations = 0,
      messages = 0,
      toolCalls = 0,
      healthStatus = 'unknown',
      healthText = '';

  factory HomeTodayCard.fromJson(Map<String, Object?> json) {
    return HomeTodayCard(
      conversations: _intValue(
        _pick(json, [
          'conversations',
          'conversationCount',
          'conversation_count',
        ]),
      ),
      messages: _intValue(
        _pick(json, ['messages', 'messageCount', 'message_count']),
      ),
      toolCalls: _intValue(
        _pick(json, [
          'toolCalls',
          'tool_calls',
          'toolCallCount',
          'tool_call_count',
        ]),
      ),
      healthStatus: _stringValue(
        _pick(json, ['healthStatus', 'health_status']),
        fallback: 'unknown',
      ),
      healthText: _stringValue(_pick(json, ['healthText', 'health_text'])),
    );
  }

  final int conversations;
  final int messages;
  final int toolCalls;
  final String healthStatus;
  final String healthText;
}

class HomePeriodStats {
  const HomePeriodStats({
    required this.key,
    required this.title,
    required this.conversations,
    required this.messages,
    required this.totalTokens,
    required this.toolCalls,
  });

  factory HomePeriodStats.fromJson(Map<String, Object?> json) {
    return HomePeriodStats(
      key: _stringValue(_pick(json, ['key', 'periodKey', 'period_key'])),
      title: _stringValue(
        _pick(json, ['title', 'periodTitle', 'period_title']),
      ),
      conversations: _intValue(
        _pick(json, [
          'conversations',
          'conversationCount',
          'conversation_count',
        ]),
      ),
      messages: _intValue(
        _pick(json, ['messages', 'messageCount', 'message_count']),
      ),
      totalTokens: _intValue(
        _pick(json, [
          'totalTokens',
          'total_tokens',
          'totalToken',
          'total_token',
          'tokenCount',
          'token_count',
        ]),
      ),
      toolCalls: _intValue(
        _pick(json, [
          'toolCalls',
          'tool_calls',
          'toolCallCount',
          'tool_call_count',
        ]),
      ),
    );
  }

  final String key;
  final String title;
  final int conversations;
  final int messages;
  final int totalTokens;
  final int toolCalls;
}

class HomeRecentRun {
  const HomeRecentRun({
    required this.id,
    required this.title,
    required this.status,
    required this.statusText,
    this.cronJobId,
    this.startedAt,
    this.timeText,
    this.tokenText,
    this.detailText,
  });

  factory HomeRecentRun.fromJson(Map<String, Object?> json) {
    return HomeRecentRun(
      id: _intValue(json['id']),
      cronJobId: _nullableIntValue(_pick(json, ['cronJobId', 'cron_job_id'])),
      title: _stringValue(_pick(json, ['title', 'runTitle', 'run_title'])),
      status: _stringValue(
        _pick(json, ['status', 'state']),
        fallback: 'unknown',
      ),
      statusText: _stringValue(
        _pick(json, ['statusText', 'status_text', 'stateText', 'state_text']),
      ),
      startedAt: _stringValue(_pick(json, ['startedAt', 'started_at'])).isEmpty
          ? null
          : _stringValue(_pick(json, ['startedAt', 'started_at'])),
      timeText: _stringValue(_pick(json, ['timeText', 'time_text'])).isEmpty
          ? null
          : _stringValue(_pick(json, ['timeText', 'time_text'])),
      tokenText: _stringValue(_pick(json, ['tokenText', 'token_text'])).isEmpty
          ? null
          : _stringValue(_pick(json, ['tokenText', 'token_text'])),
      detailText:
          _stringValue(_pick(json, ['detailText', 'detail_text'])).isEmpty
          ? null
          : _stringValue(_pick(json, ['detailText', 'detail_text'])),
    );
  }

  final int id;
  final int? cronJobId;
  final String title;
  final String status;
  final String statusText;
  final String? startedAt;
  final String? timeText;
  final String? tokenText;
  final String? detailText;
}

int _intValue(Object? value) {
  return switch (value) {
    final int value => value,
    final String value => int.tryParse(value) ?? 0,
    _ => 0,
  };
}

int? _nullableIntValue(Object? value) {
  return switch (value) {
    final int value => value,
    final String value => int.tryParse(value),
    _ => null,
  };
}

String _stringValue(Object? value, {String fallback = ''}) {
  return switch (value) {
    final String value when value.isNotEmpty => value,
    final int value => value.toString(),
    final bool value => value.toString(),
    _ => fallback,
  };
}

bool? _boolValue(Object? value) {
  return switch (value) {
    final bool value => value,
    final int value => value != 0,
    final String value => switch (value.toLowerCase()) {
      'true' || '1' => true,
      'false' || '0' => false,
      _ => null,
    },
    _ => null,
  };
}

HomeCurrentModel? _modelFromJson(Map<String, Object?> json) {
  final modelJson = _mapValue(
    _pick(json, ['currentModel', 'current_model', 'model']),
  );
  if (modelJson == null) {
    return null;
  }
  return HomeCurrentModel.fromJson(modelJson);
}

HomeTodayCard _todayCardFromJson(Map<String, Object?> json) {
  final todayCardJson = _mapValue(
    _pick(json, ['todayCard', 'today_card', 'today', 'overview']),
  );
  if (todayCardJson == null) {
    return const HomeTodayCard.empty();
  }
  return HomeTodayCard.fromJson(todayCardJson);
}

List<HomePeriodStats> _periodsFromJson(Map<String, Object?> json) {
  final rawPeriods = _pick(json, ['periods', 'period_stats', 'periodStats']);
  final list = _listValue(rawPeriods);
  if (list != null) {
    final periods = <HomePeriodStats>[];
    final orderedKeys = ['today', 'thisWeek', 'thisMonth'];
    for (var index = 0; index < list.length; index += 1) {
      final item = list[index];
      final periodJson = _mapValue(item);
      if (periodJson == null) {
        continue;
      }
      periods.add(
        _periodFromJson(
          periodJson,
          fallbackKey: index < orderedKeys.length ? orderedKeys[index] : '',
        ),
      );
    }
    if (periods.isNotEmpty) {
      return periods;
    }
  }

  final map = _mapValue(rawPeriods);
  if (map != null) {
    final orderedKeys = ['today', 'thisWeek', 'thisMonth'];
    final periods = <HomePeriodStats>[];
    for (final key in orderedKeys) {
      final periodJson = _mapValue(map[key]);
      if (periodJson == null) {
        continue;
      }
      periods.add(_periodFromJson(periodJson, fallbackKey: key));
    }
    if (periods.isNotEmpty) {
      return periods;
    }

    for (final entry in map.entries) {
      final periodJson = _mapValue(entry.value);
      if (periodJson == null) {
        continue;
      }
      periods.add(_periodFromJson(periodJson, fallbackKey: entry.key));
    }
    if (periods.isNotEmpty) {
      return periods;
    }
  }

  final periods = <HomePeriodStats>[];
  for (final key in ['today', 'thisWeek', 'thisMonth']) {
    final periodJson = _mapValue(json[key]);
    if (periodJson == null) {
      continue;
    }
    periods.add(_periodFromJson(periodJson, fallbackKey: key));
  }
  return periods;
}

List<HomeRecentRun> _recentRunsFromJson(Map<String, Object?> json) {
  final rawRuns = _pick(json, ['recentRuns', 'recent_runs', 'runs']);
  final candidates = [
    rawRuns,
    _mapValue(rawRuns)?['items'],
    _mapValue(rawRuns)?['list'],
    _mapValue(rawRuns)?['records'],
  ];

  for (final candidate in candidates) {
    final list = _listValue(candidate);
    if (list == null) {
      continue;
    }

    return list
        .map(_mapValue)
        .whereType<Map<String, Object?>>()
        .map(HomeRecentRun.fromJson)
        .toList(growable: false);
  }

  return const [];
}

HomePeriodStats _periodFromJson(
  Map<String, Object?> json, {
  required String fallbackKey,
}) {
  final key = _stringValue(
    _pick(json, ['key', 'periodKey', 'period_key']),
    fallback: fallbackKey,
  );
  final title = _stringValue(
    _pick(json, ['title', 'periodTitle', 'period_title']),
    fallback: _defaultPeriodTitle(key),
  );

  return HomePeriodStats.fromJson({...json, 'key': key, 'title': title});
}

String _defaultPeriodTitle(String key) {
  final normalized = key.replaceAll('_', '').toLowerCase();
  return switch (normalized) {
    'today' => '今日',
    'thisweek' || 'week' => '本周',
    'thismonth' || 'month' => '本月',
    _ => key,
  };
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

List<Object?>? _listValue(Object? value) {
  if (value is List<Object?>) {
    return value;
  }
  if (value is List) {
    return value.cast<Object?>();
  }
  if (value is String && value.isNotEmpty) {
    try {
      final decoded = jsonDecode(value);
      if (decoded is List) {
        return decoded.cast<Object?>();
      }
    } on FormatException {
      return null;
    }
  }
  return null;
}

Object? _pick(Map<String, Object?> json, List<String> keys) {
  for (final key in keys) {
    if (json.containsKey(key)) {
      return json[key];
    }
  }
  return null;
}
