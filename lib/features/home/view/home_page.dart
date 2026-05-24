import 'package:flutter/material.dart';

import '../../../l10n/app_localizations.dart';
import '../../../routing/app_routes.dart';
import 'workbench_chrome.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

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
                child: _HomeHeader(l10n: l10n),
              ),
              PrototypePositioned(
                x: 20,
                y: 82,
                width: 350,
                height: 154,
                child: _TodayCard(l10n: l10n),
              ),
              PrototypePositioned(
                x: 20,
                y: 250,
                width: 350,
                height: 86,
                child: _QuickActions(l10n: l10n),
              ),
              PrototypePositioned(
                x: 20,
                y: 350,
                width: 350,
                height: 185,
                child: _RecentRuns(l10n: l10n),
              ),
              PrototypePositioned(
                x: 20,
                y: 549,
                width: 350,
                height: 98,
                child: _ModelCard(l10n: l10n),
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
  }
}

class _HomeHeader extends StatelessWidget {
  const _HomeHeader({required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
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
          child: Text(
            l10n.homeAvatarInitial,
            style: const TextStyle(
              color: WorkbenchColors.accent,
              fontSize: 17,
              fontWeight: FontWeight.w700,
              height: 1.2,
            ),
          ),
        ),
      ],
    );
  }
}

class _TodayCard extends StatelessWidget {
  const _TodayCard({required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
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
              _HealthChip(label: l10n.homeHealth),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            l10n.homeTodayCount,
            style: const TextStyle(
              color: WorkbenchColors.text,
              fontSize: 46,
              fontWeight: FontWeight.w700,
              height: 1.05,
            ),
          ),
          const Spacer(),
          Text(
            l10n.homeTodayMeta,
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
}

class _HealthChip extends StatelessWidget {
  const _HealthChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
      decoration: BoxDecoration(
        color: const Color(0xFFEAF8EF),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 7,
            height: 7,
            decoration: const BoxDecoration(
              color: WorkbenchColors.green,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(
              color: WorkbenchColors.green,
              fontSize: 12,
              fontWeight: FontWeight.w600,
              height: 1.1,
            ),
          ),
        ],
      ),
    );
  }
}

class _QuickActions extends StatelessWidget {
  const _QuickActions({required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final actions = [
      _QuickActionData(
        icon: Icons.chat_bubble_outline,
        label: l10n.homeNewChat,
        color: WorkbenchColors.accent,
      ),
      _QuickActionData(
        icon: Icons.smart_toy_outlined,
        label: l10n.homeAgent,
        color: WorkbenchColors.purple,
      ),
      _QuickActionData(
        icon: Icons.verified_user_outlined,
        label: l10n.homeApproval,
        color: WorkbenchColors.green,
      ),
    ];

    return SizedBox(
      height: 86,
      child: Row(
        children: [
          for (final action in actions) ...[
            Expanded(child: _QuickAction(data: action)),
            if (action != actions.last) const SizedBox(width: 10),
          ],
        ],
      ),
    );
  }
}

class _QuickActionData {
  const _QuickActionData({
    required this.icon,
    required this.label,
    required this.color,
  });

  final IconData icon;
  final String label;
  final Color color;
}

class _QuickAction extends StatelessWidget {
  const _QuickAction({required this.data});

  final _QuickActionData data;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: WorkbenchColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: const BorderSide(color: WorkbenchColors.border),
      ),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(data.icon, size: 22, color: data.color),
            const SizedBox(height: 8),
            Text(
              data.label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: WorkbenchColors.text,
                fontSize: 13,
                fontWeight: FontWeight.w600,
                height: 1.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RecentRuns extends StatelessWidget {
  const _RecentRuns({required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
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
        _RunTile(
          icon: Icons.account_tree_outlined,
          iconColor: WorkbenchColors.accent,
          iconBackground: Color(0xFFEEF2FF),
          title: l10n.homeDailySummaryTask,
          meta: l10n.homeDailySummaryMeta,
        ),
        const SizedBox(height: 10),
        _RunTile(
          icon: Icons.timer_outlined,
          iconColor: WorkbenchColors.orange,
          iconBackground: Color(0xFFFFF4E5),
          title: l10n.homeContractAgent,
          meta: l10n.homeContractAgentMeta,
        ),
      ],
    );
  }
}

class _RunTile extends StatelessWidget {
  const _RunTile({
    required this.icon,
    required this.iconColor,
    required this.iconBackground,
    required this.title,
    required this.meta,
  });

  final IconData icon;
  final Color iconColor;
  final Color iconBackground;
  final String title;
  final String meta;

  @override
  Widget build(BuildContext context) {
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
                    color: iconBackground,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  alignment: Alignment.center,
                  child: Icon(icon, size: 19, color: iconColor),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
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
  const _ModelCard({required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
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
                  l10n.homeModelName,
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
              color: WorkbenchColors.green.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(999),
            ),
            child: Text(
              l10n.homeModelReady,
              style: const TextStyle(
                color: WorkbenchColors.green,
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
}
