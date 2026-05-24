import 'package:flutter/material.dart';

import '../../../l10n/app_localizations.dart';
import '../../../routing/app_routes.dart';
import 'workbench_chrome.dart';

class AgentPage extends StatelessWidget {
  const AgentPage({super.key});

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
                height: 74,
                child: SectionPageHeader(
                  kicker: l10n.agentKicker,
                  title: l10n.agentTitle,
                  trailing: const CircleIconButton(
                    icon: Icons.add,
                    size: 42,
                    iconSize: 22,
                  ),
                ),
              ),
              PrototypePositioned(
                x: 20,
                y: 82,
                width: 350,
                height: 610,
                child: _AgentContent(l10n: l10n),
              ),
              PrototypePositioned(
                x: 0,
                y: 712,
                width: PrototypeCanvas.width,
                height: 84,
                child: WorkbenchTabBar(
                  l10n: l10n,
                  currentRoute: AppRoutes.agent,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AgentContent extends StatelessWidget {
  const _AgentContent({required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _SegmentedControl(
          firstLabel: l10n.agentSegmentMembers,
          secondLabel: l10n.agentSegmentLive,
        ),
        const SizedBox(height: 14),
        _AgentCard(
          icon: Icons.manage_search,
          iconColor: WorkbenchColors.accent,
          iconBackground: const Color(0xFFEAF2FF),
          title: l10n.agentContractName,
          description: l10n.agentContractDescription,
          firstPill: l10n.agentOnline,
          secondPill: l10n.agentContractTools,
          actionIcon: Icons.chat_bubble_outline,
          elevated: true,
          height: 118,
        ),
        const SizedBox(height: 14),
        _AgentCard(
          icon: Icons.bar_chart,
          iconColor: WorkbenchColors.orange,
          iconBackground: const Color(0xFFFFF4E5),
          title: l10n.agentDataName,
          description: l10n.agentDataDescription,
          state: l10n.agentDataState,
          height: 104,
        ),
        const SizedBox(height: 14),
        _AgentCard(
          icon: Icons.headset_mic_outlined,
          iconColor: WorkbenchColors.purple,
          iconBackground: const Color(0xFFF4ECFF),
          title: l10n.agentSupportName,
          description: l10n.agentSupportDescription,
          state: l10n.agentSupportState,
          stateColor: WorkbenchColors.green,
          height: 104,
        ),
        const SizedBox(height: 14),
        _LiveRunsCard(l10n: l10n),
      ],
    );
  }
}

class _SegmentedControl extends StatelessWidget {
  const _SegmentedControl({
    required this.firstLabel,
    required this.secondLabel,
  });

  final String firstLabel;
  final String secondLabel;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xFFE9ECEF),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Expanded(child: _Segment(label: firstLabel, isSelected: true)),
          const SizedBox(width: 4),
          Expanded(child: _Segment(label: secondLabel, isSelected: false)),
        ],
      ),
    );
  }
}

class _Segment extends StatelessWidget {
  const _Segment({required this.label, required this.isSelected});

  final String label;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isSelected ? WorkbenchColors.surface : Colors.transparent,
        borderRadius: BorderRadius.circular(11),
      ),
      child: Text(
        label,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: isSelected ? WorkbenchColors.text : WorkbenchColors.muted,
          fontSize: 14,
          fontWeight: FontWeight.w700,
          height: 1.2,
        ),
      ),
    );
  }
}

class _AgentCard extends StatelessWidget {
  const _AgentCard({
    required this.icon,
    required this.iconColor,
    required this.iconBackground,
    required this.title,
    required this.description,
    required this.height,
    this.firstPill,
    this.secondPill,
    this.state,
    this.stateColor = WorkbenchColors.muted,
    this.actionIcon,
    this.elevated = false,
  });

  final IconData icon;
  final Color iconColor;
  final Color iconBackground;
  final String title;
  final String description;
  final double height;
  final String? firstPill;
  final String? secondPill;
  final String? state;
  final Color stateColor;
  final IconData? actionIcon;
  final bool elevated;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: WorkbenchColors.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: WorkbenchColors.border),
        boxShadow: elevated
            ? const [
                BoxShadow(
                  color: Color(0x10000000),
                  blurRadius: 20,
                  offset: Offset(0, 8),
                ),
              ]
            : null,
      ),
      child: Row(
        children: [
          Container(
            width: height > 110 ? 56 : 52,
            height: height > 110 ? 56 : 52,
            decoration: BoxDecoration(
              color: iconBackground,
              borderRadius: BorderRadius.circular(height > 110 ? 18 : 17),
            ),
            alignment: Alignment.center,
            child: Icon(icon, size: height > 110 ? 28 : 26, color: iconColor),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: WorkbenchColors.text,
                    fontSize: height > 110 ? 17 : 16,
                    fontWeight: FontWeight.w700,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  description,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: WorkbenchColors.muted,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 6),
                if (firstPill != null && secondPill != null)
                  Row(
                    children: [
                      _SmallPill(
                        label: firstPill!,
                        textColor: WorkbenchColors.green,
                        background: const Color(0xFFEAF8EF),
                      ),
                      const SizedBox(width: 8),
                      _SmallPill(
                        label: secondPill!,
                        textColor: WorkbenchColors.muted,
                        background: const Color(0xFFF9FAFB),
                      ),
                    ],
                  )
                else if (state != null)
                  Text(
                    state!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: stateColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      height: 1.2,
                    ),
                  ),
              ],
            ),
          ),
          if (actionIcon != null) ...[
            const SizedBox(width: 14),
            Container(
              width: 42,
              height: 42,
              decoration: const BoxDecoration(
                color: WorkbenchColors.accent,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Icon(actionIcon, size: 21, color: WorkbenchColors.surface),
            ),
          ],
        ],
      ),
    );
  }
}

class _SmallPill extends StatelessWidget {
  const _SmallPill({
    required this.label,
    required this.textColor,
    required this.background,
  });

  final String label;
  final Color textColor;
  final Color background;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: textColor,
          fontSize: 11,
          fontWeight: FontWeight.w700,
          height: 1.1,
        ),
      ),
    );
  }
}

class _LiveRunsCard extends StatelessWidget {
  const _LiveRunsCard({required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 128,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: WorkbenchColors.dark,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  l10n.agentLiveTitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: WorkbenchColors.surface,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    height: 1.2,
                  ),
                ),
              ),
              _SmallPill(
                label: l10n.agentLiveAttention,
                textColor: WorkbenchColors.orange,
                background: WorkbenchColors.orange.withValues(alpha: 0.15),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: _LiveMetric(
                    value: l10n.agentLiveRunningCount,
                    label: l10n.agentLiveRunningLabel,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _LiveMetric(
                    value: l10n.agentLiveBlockedCount,
                    label: l10n.agentLiveBlockedLabel,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LiveMetric extends StatelessWidget {
  const _LiveMetric({required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
        color: WorkbenchColors.surface.withValues(alpha: 0.07),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: WorkbenchColors.surface,
              fontSize: 22,
              fontWeight: FontWeight.w700,
              height: 1.0,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: WorkbenchColors.surface.withValues(alpha: 0.6),
                fontSize: 11,
                fontWeight: FontWeight.w600,
                height: 1.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
