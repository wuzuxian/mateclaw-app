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
      username: json['username'] as String? ?? '',
      nickname: json['nickname'] as String? ?? '',
      avatar: json['avatar'] as String?,
      email: json['email'] as String?,
      role: json['role'] as String? ?? '',
      enabled: json['enabled'] as bool? ?? true,
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
      name: json['name'] as String? ?? '',
      slug: json['slug'] as String? ?? '',
      role: json['role'] as String? ?? '',
      isDefault: json['isDefault'] as bool? ?? false,
      memberCount: _intValue(json['memberCount']),
      roleCount: _intValue(json['roleCount']),
      agentCount: _intValue(json['agentCount']),
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
      currentModel: switch (json['currentModel']) {
        final Map<String, Object?> value => HomeCurrentModel.fromJson(value),
        _ => null,
      },
      todayCard: switch (json['todayCard']) {
        final Map<String, Object?> value => HomeTodayCard.fromJson(value),
        _ => const HomeTodayCard.empty(),
      },
      periods: _listOfMaps(
        json['periods'],
      ).map(HomePeriodStats.fromJson).toList(growable: false),
      recentRuns: _listOfMaps(
        json['recentRuns'],
      ).map(HomeRecentRun.fromJson).toList(growable: false),
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
      providerId: json['providerId'] as String? ?? '',
      providerName: json['providerName'] as String? ?? '',
      model: json['model'] as String? ?? '',
      status: json['status'] as String? ?? 'unknown',
      statusText: json['statusText'] as String? ?? '',
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
      conversations: _intValue(json['conversations']),
      messages: _intValue(json['messages']),
      toolCalls: _intValue(json['toolCalls']),
      healthStatus: json['healthStatus'] as String? ?? 'unknown',
      healthText: json['healthText'] as String? ?? '',
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
      key: json['key'] as String? ?? '',
      title: json['title'] as String? ?? '',
      conversations: _intValue(json['conversations']),
      messages: _intValue(json['messages']),
      totalTokens: _intValue(json['totalTokens']),
      toolCalls: _intValue(json['toolCalls']),
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
      cronJobId: _nullableIntValue(json['cronJobId']),
      title: json['title'] as String? ?? '',
      status: json['status'] as String? ?? 'unknown',
      statusText: json['statusText'] as String? ?? '',
      startedAt: json['startedAt'] as String?,
      timeText: json['timeText'] as String?,
      tokenText: json['tokenText'] as String?,
      detailText: json['detailText'] as String?,
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

List<Map<String, Object?>> _listOfMaps(Object? value) {
  if (value is! List<Object?>) {
    return const [];
  }

  return value.whereType<Map<String, Object?>>().toList(growable: false);
}
