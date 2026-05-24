import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../l10n/app_localizations.dart';
import '../../../routing/app_routes.dart';
import '../data/home_models.dart';
import '../viewmodel/home_view_model.dart';
import 'workbench_chrome.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<HomeViewModel>().load();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Consumer<HomeViewModel>(
      builder: (context, viewModel, child) {
        final data = viewModel.data;

        return Scaffold(
          backgroundColor: WorkbenchColors.background,
          body: SafeArea(
            bottom: false,
            child: PrototypeCanvas(
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  PrototypePositioned(
                    x: 20,
                    y: 10,
                    width: 350,
                    height: 70,
                    child: _HomeHeader(l10n: l10n, profile: data?.profile),
                  ),
                  PrototypePositioned(
                    x: 20,
                    y: 82,
                    width: 350,
                    height: 98,
                    child: _ModelCard(
                      l10n: l10n,
                      model: data?.snapshot.currentModel,
                    ),
                  ),
                  PrototypePositioned(
                    x: 20,
                    y: 194,
                    width: 350,
                    height: 154,
                    child: _TodayCard(
                      l10n: l10n,
                      todayCard: data?.snapshot.todayCard,
                    ),
                  ),
                  PrototypePositioned(
                    x: 20,
                    y: 362,
                    width: 350,
                    height: 153,
                    child: _PeriodComparison(
                      l10n: l10n,
                      periods: data?.snapshot.periods ?? const [],
                    ),
                  ),
                  PrototypePositioned(
                    x: 20,
                    y: 529,
                    width: 350,
                    height: 185,
                    child: _RecentRuns(
                      l10n: l10n,
                      runs: data?.snapshot.recentRuns ?? const [],
                      showFallbackRuns: data == null,
                    ),
                  ),
                  if (viewModel.error != null)
                    PrototypePositioned(
                      x: 20,
                      y: 676,
                      width: 350,
                      height: 36,
                      child: _HomeErrorBanner(
                        message: viewModel.error!.message(l10n),
                        retryLabel: l10n.homeRetry,
                        onRetry: viewModel.refresh,
                      ),
                    ),
                  if (viewModel.isLoading)
                    const PrototypePositioned(
                      x: 342,
                      y: 12,
                      width: 28,
                      height: 28,
                      child: CircularProgressIndicator(strokeWidth: 2.4),
                    ),
                  PrototypePositioned(
                    x: 0,
                    y: 712,
                    width: PrototypeCanvas.width,
                    height: 84,
                    child: WorkbenchTabBar(
                      l10n: l10n,
                      currentRoute: AppRoutes.home,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

extension on HomeLoadError {
  String message(AppLocalizations l10n) {
    return switch (this) {
      HomeLoadError.network => l10n.homeLoadErrorNetwork,
      HomeLoadError.unauthorized => l10n.homeLoadErrorUnauthorized,
      HomeLoadError.forbidden => l10n.homeLoadErrorForbidden,
      HomeLoadError.server => l10n.homeLoadErrorServer,
      HomeLoadError.invalidResponse => l10n.homeLoadErrorInvalidResponse,
      HomeLoadError.unknown => l10n.homeLoadErrorUnknown,
    };
  }
}

class _HomeErrorBanner extends StatelessWidget {
  const _HomeErrorBanner({
    required this.message,
    required this.retryLabel,
    required this.onRetry,
  });

  final String message;
  final String retryLabel;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: WorkbenchColors.dark,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        onTap: onRetry,
        borderRadius: BorderRadius.circular(18),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: [
              const Icon(
                Icons.info_outline,
                size: 16,
                color: WorkbenchColors.orange,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  message,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: WorkbenchColors.surface,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    height: 1.2,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                retryLabel,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: WorkbenchColors.orange,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  height: 1.2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HomeHeader extends StatelessWidget {
  const _HomeHeader({required this.l10n, required this.profile});

  final AppLocalizations l10n;
  final HomeUserProfile? profile;

  @override
  Widget build(BuildContext context) {
    final avatarInitial = _avatarInitial(profile, l10n);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.homeBrand,
                style: const TextStyle(
                  color: WorkbenchColors.accent,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  height: 1.38,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                l10n.homeTitle,
                style: const TextStyle(
                  color: WorkbenchColors.text,
                  fontSize: 34,
                  fontWeight: FontWeight.w700,
                  height: 1.18,
                ),
              ),
            ],
          ),
        ),
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: WorkbenchColors.surface,
            borderRadius: BorderRadius.circular(21),
            border: Border.all(color: WorkbenchColors.border),
          ),
          alignment: Alignment.center,
          child: _AvatarContent(
            avatarUrl: profile?.avatar,
            fallbackInitial: avatarInitial,
          ),
        ),
      ],
    );
  }

  String _avatarInitial(HomeUserProfile? profile, AppLocalizations l10n) {
    final displayName = profile?.nickname.isNotEmpty ?? false
        ? profile!.nickname
        : profile?.username;
    if (displayName == null || displayName.isEmpty) {
      return l10n.homeAvatarInitial;
    }
    return displayName.characters.first;
  }
}

class _AvatarContent extends StatelessWidget {
  const _AvatarContent({
    required this.avatarUrl,
    required this.fallbackInitial,
  });

  final String? avatarUrl;
  final String fallbackInitial;

  @override
  Widget build(BuildContext context) {
    final url = avatarUrl;
    if (url != null && url.isNotEmpty) {
      return ClipOval(
        child: Image.network(
          url,
          width: 42,
          height: 42,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return _AvatarInitial(label: fallbackInitial);
          },
        ),
      );
    }

    return _AvatarInitial(label: fallbackInitial);
  }
}

class _AvatarInitial extends StatelessWidget {
  const _AvatarInitial({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
        color: WorkbenchColors.accent,
        fontSize: 17,
        fontWeight: FontWeight.w700,
        height: 1.2,
      ),
    );
  }
}

class _TodayCard extends StatelessWidget {
  const _TodayCard({required this.l10n, required this.todayCard});

  final AppLocalizations l10n;
  final HomeTodayCard? todayCard;

  @override
  Widget build(BuildContext context) {
    final card = todayCard;
    final healthText = card?.healthText.isNotEmpty ?? false
        ? card!.healthText
        : l10n.homeHealth;

    return Container(
      height: 154,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: WorkbenchColors.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: WorkbenchColors.border),
        boxShadow: const [
          BoxShadow(
            color: Color(0x12000000),
            blurRadius: 24,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  l10n.homeTodayConversations,
                  style: const TextStyle(
                    color: WorkbenchColors.muted,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    height: 1.3,
                  ),
                ),
              ),
              _HealthChip(
                label: healthText,
                status: card?.healthStatus ?? 'healthy',
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            card == null
                ? l10n.homeTodayCount
                : _formatCompactNumber(card.conversations),
            style: const TextStyle(
              color: WorkbenchColors.text,
              fontSize: 46,
              fontWeight: FontWeight.w700,
              height: 1.05,
            ),
          ),
          const Spacer(),
          Text(
            card == null
                ? l10n.homeTodayMeta
                : _todayMeta(l10n: l10n, card: card),
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: WorkbenchColors.muted,
              fontSize: 13,
              fontWeight: FontWeight.w500,
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }

  String _todayMeta({
    required AppLocalizations l10n,
    required HomeTodayCard card,
  }) {
    final messagesLabel = l10n.homePeriodMessages;
    final toolsLabel = l10n.homePeriodTools;
    return '${_formatCompactNumber(card.messages)} $messagesLabel · '
        '${_formatCompactNumber(card.toolCalls)} $toolsLabel';
  }
}

class _HealthChip extends StatelessWidget {
  const _HealthChip({required this.label, required this.status});

  final String label;
  final String status;

  @override
  Widget build(BuildContext context) {
    final color = _statusColor(status);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 7,
            height: 7,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              height: 1.1,
            ).copyWith(color: color),
          ),
        ],
      ),
    );
  }
}

class _PeriodComparison extends StatelessWidget {
  const _PeriodComparison({required this.l10n, required this.periods});

  final AppLocalizations l10n;
  final List<HomePeriodStats> periods;

  @override
  Widget build(BuildContext context) {
    final cards = periods.isEmpty
        ? [
            _PeriodStatsData(title: l10n.homePeriodToday),
            _PeriodStatsData(title: l10n.homePeriodWeek),
            _PeriodStatsData(title: l10n.homePeriodMonth),
          ]
        : periods
              .map(
                (period) => _PeriodStatsData(
                  title: period.title,
                  conversations: period.conversations,
                  messages: period.messages,
                  totalTokens: period.totalTokens,
                  toolCalls: period.toolCalls,
                ),
              )
              .toList(growable: false);

    final labels = [
      l10n.homePeriodConversations,
      l10n.homePeriodMessages,
      l10n.homePeriodTokens,
      l10n.homePeriodTools,
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          l10n.homePeriodTitle,
          style: const TextStyle(
            color: WorkbenchColors.text,
            fontSize: 20,
            fontWeight: FontWeight.w700,
            height: 1.25,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          l10n.homePeriodSubtitle,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: WorkbenchColors.muted,
            fontSize: 11,
            fontWeight: FontWeight.w500,
            height: 1.45,
          ),
        ),
        const SizedBox(height: 8),
        Expanded(
          child: Row(
            children: [
              for (final period in cards) ...[
                Expanded(
                  child: _PeriodStatsCard(data: period, labels: labels),
                ),
                if (period != cards.last) const SizedBox(width: 8),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _PeriodStatsData {
  const _PeriodStatsData({
    required this.title,
    this.conversations = 0,
    this.messages = 0,
    this.totalTokens = 0,
    this.toolCalls = 0,
  });

  final String title;
  final int conversations;
  final int messages;
  final int totalTokens;
  final int toolCalls;

  List<int> get values => [conversations, messages, totalTokens, toolCalls];
}

class _PeriodStatsCard extends StatelessWidget {
  const _PeriodStatsCard({required this.data, required this.labels});

  final _PeriodStatsData data;
  final List<String> labels;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: WorkbenchColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: WorkbenchColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            data.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Color(0xFF0F4C4A),
              fontSize: 12,
              fontWeight: FontWeight.w700,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 3),
          for (var index = 0; index < labels.length; index += 1) ...[
            _PeriodStatRow(
              label: labels[index],
              value: _formatCompactNumber(data.values[index]),
            ),
            if (index != labels.length - 1) const SizedBox(height: 3),
          ],
        ],
      ),
    );
  }
}

class _PeriodStatRow extends StatelessWidget {
  const _PeriodStatRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Color(0xFF8B6F61),
              fontSize: 9,
              fontWeight: FontWeight.w500,
              height: 1.2,
            ),
          ),
        ),
        const SizedBox(width: 2),
        Text(
          value,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: WorkbenchColors.text,
            fontSize: 10,
            fontWeight: FontWeight.w700,
            height: 1.2,
          ),
        ),
      ],
    );
  }
}

class _RecentRuns extends StatelessWidget {
  const _RecentRuns({
    required this.l10n,
    required this.runs,
    required this.showFallbackRuns,
  });

  final AppLocalizations l10n;
  final List<HomeRecentRun> runs;
  final bool showFallbackRuns;

  @override
  Widget build(BuildContext context) {
    final fallbackRuns = [
      HomeRecentRun(
        id: 0,
        title: l10n.homeDailySummaryTask,
        status: 'success',
        statusText: '',
        timeText: l10n.homeDailySummaryMeta,
      ),
      HomeRecentRun(
        id: 0,
        title: l10n.homeContractAgent,
        status: 'running',
        statusText: '',
        detailText: l10n.homeContractAgentMeta,
      ),
    ];
    final visibleRuns = runs.isEmpty && showFallbackRuns ? fallbackRuns : runs;
    final topRuns = visibleRuns.take(2).toList(growable: false);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          l10n.homeRecentRuns,
          style: const TextStyle(
            color: WorkbenchColors.text,
            fontSize: 20,
            fontWeight: FontWeight.w700,
            height: 1.25,
          ),
        ),
        const SizedBox(height: 10),
        if (visibleRuns.isEmpty)
          _EmptyRuns(label: l10n.homeNoRecentRuns)
        else
          for (final run in topRuns) ...[
            _RunTile(run: run),
            if (run != topRuns.last) const SizedBox(height: 10),
          ],
      ],
    );
  }
}

class _RunTile extends StatelessWidget {
  const _RunTile({required this.run});

  final HomeRecentRun run;

  @override
  Widget build(BuildContext context) {
    final statusColor = _runStatusColor(run.status);
    final icon = _runStatusIcon(run.status);
    final meta = _runMeta(run);

    return Material(
      color: WorkbenchColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: const BorderSide(color: WorkbenchColors.border),
      ),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(18),
        child: SizedBox(
          height: 68,
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: statusColor.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  alignment: Alignment.center,
                  child: Icon(icon, size: 19, color: statusColor),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        run.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: WorkbenchColors.text,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        meta,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: WorkbenchColors.muted,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          height: 1.2,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                const Icon(
                  Icons.chevron_right,
                  size: 18,
                  color: WorkbenchColors.muted,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ModelCard extends StatelessWidget {
  const _ModelCard({required this.l10n, required this.model});

  final AppLocalizations l10n;
  final HomeCurrentModel? model;

  @override
  Widget build(BuildContext context) {
    final currentModel = model;
    final status = currentModel?.status ?? 'ready';
    final statusText = currentModel?.statusText.isNotEmpty ?? false
        ? currentModel!.statusText
        : l10n.homeModelReady;
    final modelName = currentModel == null
        ? l10n.homeModelName
        : _modelDisplayName(currentModel, l10n);
    final statusColor = _statusColor(status);

    return Container(
      height: 98,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: WorkbenchColors.dark,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(14),
            ),
            alignment: Alignment.center,
            child: const Icon(
              Icons.auto_awesome,
              size: 22,
              color: WorkbenchColors.surface,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.homeCurrentModel,
                  style: TextStyle(
                    color: WorkbenchColors.surface.withValues(alpha: 0.6),
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  modelName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: WorkbenchColors.surface,
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    height: 1.2,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
            decoration: BoxDecoration(
              color: statusColor.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(999),
            ),
            child: Text(
              statusText,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: statusColor,
                fontSize: 12,
                fontWeight: FontWeight.w700,
                height: 1.1,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _modelDisplayName(
    HomeCurrentModel currentModel,
    AppLocalizations l10n,
  ) {
    if (currentModel.providerName.isEmpty && currentModel.model.isEmpty) {
      return l10n.homeModelUnavailable;
    }
    if (currentModel.providerName.isEmpty) {
      return currentModel.model;
    }
    if (currentModel.model.isEmpty) {
      return currentModel.providerName;
    }
    return '${currentModel.providerName} · ${currentModel.model}';
  }
}

class _EmptyRuns extends StatelessWidget {
  const _EmptyRuns({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 68,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: WorkbenchColors.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: WorkbenchColors.border),
      ),
      child: Text(
        label,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          color: WorkbenchColors.muted,
          fontSize: 13,
          fontWeight: FontWeight.w600,
          height: 1.2,
        ),
      ),
    );
  }
}

String _formatCompactNumber(int value) {
  if (value >= 1000000) {
    final formatted = (value / 1000000).toStringAsFixed(1);
    return '${_trimTrailingZero(formatted)}M';
  }
  if (value >= 1000) {
    final formatted = (value / 1000).toStringAsFixed(1);
    return '${_trimTrailingZero(formatted)}k';
  }
  return value.toString();
}

String _trimTrailingZero(String value) {
  return value.endsWith('.0') ? value.substring(0, value.length - 2) : value;
}

Color _statusColor(String status) {
  return switch (status) {
    'ready' || 'healthy' || 'success' => WorkbenchColors.green,
    'warning' || 'running' => WorkbenchColors.orange,
    'error' || 'failed' => WorkbenchColors.red,
    _ => WorkbenchColors.muted,
  };
}

Color _runStatusColor(String status) {
  return switch (status) {
    'success' => WorkbenchColors.accent,
    'running' => WorkbenchColors.orange,
    'failed' => WorkbenchColors.red,
    _ => WorkbenchColors.muted,
  };
}

IconData _runStatusIcon(String status) {
  return switch (status) {
    'running' => Icons.timer_outlined,
    'failed' => Icons.error_outline,
    _ => Icons.account_tree_outlined,
  };
}

String _runMeta(HomeRecentRun run) {
  final parts = [
    run.statusText,
    run.timeText,
    run.tokenText,
    run.detailText,
  ].where((part) => part != null && part.isNotEmpty).cast<String>();

  return parts.join(' · ');
}
