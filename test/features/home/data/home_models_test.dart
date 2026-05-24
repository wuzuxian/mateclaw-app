import 'package:flutter_test/flutter_test.dart';
import 'package:mateclaw_app/core/network/api_client.dart';
import 'package:mateclaw_app/features/home/data/home_models.dart';
import 'package:mateclaw_app/features/home/data/home_cache_store.dart';
import 'package:mateclaw_app/features/home/data/home_repository.dart';
import 'package:mateclaw_app/features/home/viewmodel/home_view_model.dart';

void main() {
  test('parses flexible home snapshot payloads', () {
    final snapshot = HomeSnapshot.fromJson({
      'current_model':
          '{"provider_id":"openai","provider_name":"OpenAI","model_name":"gpt-4.1","status":"ready","status_text":"Ready"}',
      'today_card': {
        'conversation_count': '128',
        'message_count': 1842,
        'tool_call_count': '43',
        'health_status': 'healthy',
        'health_text': '健康',
      },
      'periods': {
        'today': {
          'conversation_count': '128',
          'message_count': '1842',
          'total_tokens': '124000',
          'tool_call_count': '43',
        },
        'thisWeek': {
          'conversations': 560,
          'messages': 7200,
          'totalTokens': 520000,
          'toolCalls': 180,
        },
        'thisMonth': {
          'conversations': 2100,
          'messages': 31200,
          'tokenCount': 2480000,
          'toolCallCount': 790,
        },
      },
      'recent_runs': {
        'items': [
          {
            'id': '10001',
            'cron_job_id': '3001',
            'run_title': '日报摘要任务',
            'state': 'success',
            'state_text': '成功',
            'time_text': '2分钟前',
            'token_text': '12.4k tokens',
          },
        ],
      },
    });

    expect(snapshot.currentModel?.providerName, 'OpenAI');
    expect(snapshot.currentModel?.model, 'gpt-4.1');
    expect(snapshot.todayCard.conversations, 128);
    expect(snapshot.todayCard.messages, 1842);
    expect(snapshot.todayCard.toolCalls, 43);
    expect(snapshot.todayCard.healthStatus, 'healthy');
    expect(snapshot.periods, hasLength(3));
    expect(snapshot.periods[0].key, 'today');
    expect(snapshot.periods[0].title, '今日');
    expect(snapshot.periods[0].totalTokens, 124000);
    expect(snapshot.periods[2].toolCalls, 790);
    expect(snapshot.recentRuns, hasLength(1));
    expect(snapshot.recentRuns.first.title, '日报摘要任务');
    expect(snapshot.recentRuns.first.status, 'success');
    expect(snapshot.recentRuns.first.statusText, '成功');
  });

  test(
    'keeps cached data visible when refresh returns invalid response',
    () async {
      final cachedData = HomeDashboardData(
        workspaceId: 1,
        profile: null,
        workspaces: const [],
        snapshot: const HomeSnapshot(
          currentModel: null,
          todayCard: HomeTodayCard.empty(),
          periods: [],
          recentRuns: [],
        ),
        isFromCache: true,
      );
      final viewModel = HomeViewModel(
        repository: _FakeHomeRepository(cachedData: cachedData),
      );

      await viewModel.load();

      expect(viewModel.data, isNotNull);
      expect(viewModel.error, isNull);
    },
  );
}

class _FakeHomeRepository extends HomeRepository {
  _FakeHomeRepository({required this.cachedData})
    : super(
        apiClient: ApiClient(baseUrl: 'http://127.0.0.1:9'),
        cacheStore: const HomeCacheStore(),
        userIdProvider: () => 1,
      );

  final HomeDashboardData? cachedData;

  @override
  Future<HomeDashboardData?> readCachedHome() async => cachedData;

  @override
  Future<HomeDashboardData> refreshHome({int recentRunLimit = 5}) async {
    throw const ApiException(type: ApiExceptionType.invalidResponse);
  }

  @override
  Future<bool> canReachBackend() async => true;
}
