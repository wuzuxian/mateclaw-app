import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../l10n/app_localizations.dart';
import '../../../routing/app_routes.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const _accent = Color(0xFF007AFF);
  static const _background = Color(0xFFF5F5F7);
  static const _surface = Color(0xFFFFFFFF);
  static const _text = Color(0xFF111827);
  static const _muted = Color(0xFF6B7280);
  static const _border = Color(0xFFE5E7EB);
  static const _green = Color(0xFF34C759);
  static const _purple = Color(0xFFAF52DE);
  static const _orange = Color(0xFFFF9500);
  static const _dark = Color(0xFF111827);
  static const _prototypeWidth = 390.0;
  static const _prototypeSafeHeight = 796.0;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: _background,
      body: SafeArea(
        bottom: false,
        child: _ScaledPrototypeCanvas(
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              _PrototypePositioned(
                x: 20,
                y: 10,
                width: 350,
                height: 70,
                child: _HomeHeader(l10n: l10n),
              ),
              _PrototypePositioned(
                x: 20,
                y: 82,
                width: 350,
                height: 154,
                child: _TodayCard(l10n: l10n),
              ),
              _PrototypePositioned(
                x: 20,
                y: 250,
                width: 350,
                height: 86,
                child: _QuickActions(l10n: l10n),
              ),
              _PrototypePositioned(
                x: 20,
                y: 350,
                width: 350,
                height: 185,
                child: _RecentRuns(l10n: l10n),
              ),
              _PrototypePositioned(
                x: 20,
                y: 549,
                width: 350,
                height: 98,
                child: _ModelCard(l10n: l10n),
              ),
              _PrototypePositioned(
                x: 0,
                y: 712,
                width: HomePage._prototypeWidth,
                height: 84,
                child: _HomeTabBar(l10n: l10n, currentRoute: AppRoutes.home),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AgentPage extends StatelessWidget {
  const AgentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const _PlaceholderTabPage(tab: _HomeTab.agent);
  }
}

class KnowledgePage extends StatelessWidget {
  const KnowledgePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const _PlaceholderTabPage(tab: _HomeTab.knowledge);
  }
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const _PlaceholderTabPage(tab: _HomeTab.settings);
  }
}

class _PlaceholderTabPage extends StatelessWidget {
  const _PlaceholderTabPage({required this.tab});

  final _HomeTab tab;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: HomePage._background,
      body: SafeArea(
        bottom: false,
        child: _ScaledPrototypeCanvas(
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Center(
                child: Text(
                  tab.label(l10n),
                  style: const TextStyle(
                    color: HomePage._text,
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    height: 1.2,
                  ),
                ),
              ),
              _PrototypePositioned(
                x: 0,
                y: 712,
                width: HomePage._prototypeWidth,
                height: 84,
                child: _HomeTabBar(l10n: l10n, currentRoute: tab.route),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ScaledPrototypeCanvas extends StatelessWidget {
  const _ScaledPrototypeCanvas({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final widthScale = constraints.maxWidth / HomePage._prototypeWidth;
        final heightScale =
            constraints.maxHeight / HomePage._prototypeSafeHeight;
        final scale = widthScale < heightScale ? widthScale : heightScale;
        final scaledWidth = HomePage._prototypeWidth * scale;
        final scaledHeight = HomePage._prototypeSafeHeight * scale;

        return MediaQuery.withNoTextScaling(
          child: Center(
            child: SizedBox(
              width: scaledWidth,
              height: scaledHeight,
              child: Transform.scale(
                scale: scale,
                alignment: Alignment.topLeft,
                child: SizedBox(
                  width: HomePage._prototypeWidth,
                  height: HomePage._prototypeSafeHeight,
                  child: child,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _PrototypePositioned extends StatelessWidget {
  const _PrototypePositioned({
    required this.x,
    required this.y,
    required this.width,
    required this.height,
    required this.child,
  });

  final double x;
  final double y;
  final double width;
  final double height;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: x,
      top: y,
      width: width,
      height: height,
      child: child,
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
                  color: HomePage._accent,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  height: 1.38,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                l10n.homeTitle,
                style: const TextStyle(
                  color: HomePage._text,
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
            color: HomePage._surface,
            borderRadius: BorderRadius.circular(21),
            border: Border.all(color: HomePage._border),
          ),
          alignment: Alignment.center,
          child: Text(
            l10n.homeAvatarInitial,
            style: const TextStyle(
              color: HomePage._accent,
              fontSize: 17,
              fontWeight: FontWeight.w700,
              height: 1.47,
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
        color: HomePage._surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: HomePage._border),
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
                    color: HomePage._muted,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    height: 1.4,
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
              color: HomePage._text,
              fontSize: 46,
              fontWeight: FontWeight.w700,
              height: 1.15,
            ),
          ),
          const Spacer(),
          Text(
            l10n.homeTodayMeta,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: HomePage._muted,
              fontSize: 13,
              fontWeight: FontWeight.w500,
              height: 1.46,
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
              color: HomePage._green,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(
              color: HomePage._green,
              fontSize: 12,
              fontWeight: FontWeight.w600,
              height: 1.42,
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
        color: HomePage._accent,
      ),
      _QuickActionData(
        icon: Icons.smart_toy_outlined,
        label: l10n.homeAgent,
        color: HomePage._purple,
      ),
      _QuickActionData(
        icon: Icons.verified_user_outlined,
        label: l10n.homeApproval,
        color: HomePage._green,
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
      color: HomePage._surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: const BorderSide(color: HomePage._border),
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
                color: HomePage._text,
                fontSize: 13,
                fontWeight: FontWeight.w600,
                height: 1.38,
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
            color: HomePage._text,
            fontSize: 20,
            fontWeight: FontWeight.w700,
            height: 1.45,
          ),
        ),
        const SizedBox(height: 10),
        _RunTile(
          icon: Icons.account_tree_outlined,
          iconColor: HomePage._accent,
          iconBackground: Color(0xFFEEF2FF),
          title: l10n.homeDailySummaryTask,
          meta: l10n.homeDailySummaryMeta,
        ),
        const SizedBox(height: 10),
        _RunTile(
          icon: Icons.timer_outlined,
          iconColor: HomePage._orange,
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
      color: HomePage._surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: const BorderSide(color: HomePage._border),
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
                          color: HomePage._text,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          height: 1.33,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        meta,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: HomePage._muted,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          height: 1.42,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                const Icon(
                  Icons.chevron_right,
                  size: 18,
                  color: HomePage._muted,
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
        color: HomePage._dark,
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
              color: HomePage._surface,
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
                    color: HomePage._surface.withValues(alpha: 0.6),
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    height: 1.38,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  l10n.homeModelName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: HomePage._surface,
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    height: 1.41,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
            decoration: BoxDecoration(
              color: HomePage._green.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(999),
            ),
            child: Text(
              l10n.homeModelReady,
              style: const TextStyle(
                color: HomePage._green,
                fontSize: 12,
                fontWeight: FontWeight.w700,
                height: 1.33,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HomeTabBar extends StatelessWidget {
  const _HomeTabBar({required this.l10n, required this.currentRoute});

  final AppLocalizations l10n;
  final String currentRoute;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: HomePage._surface.withValues(alpha: 0.9),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0F000000),
            blurRadius: 18,
            offset: Offset(0, -6),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(18, 10, 18, 24),
        child: Row(
          children: [
            for (final tab in _HomeTab.values)
              Expanded(
                child: _TabItem(
                  tab: tab,
                  label: tab.label(l10n),
                  isSelected: currentRoute == tab.route,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

enum _HomeTab {
  overview(Icons.dashboard_outlined, AppRoutes.home),
  chat(Icons.chat_bubble_outline, AppRoutes.chat),
  agent(Icons.smart_toy_outlined, AppRoutes.agent),
  knowledge(Icons.storage_outlined, AppRoutes.knowledge),
  settings(Icons.settings_outlined, AppRoutes.settings);

  const _HomeTab(this.icon, this.route);

  final IconData icon;
  final String route;

  String label(AppLocalizations l10n) {
    return switch (this) {
      _HomeTab.overview => l10n.homeTabOverview,
      _HomeTab.chat => l10n.homeTabChat,
      _HomeTab.agent => l10n.homeTabAgent,
      _HomeTab.knowledge => l10n.homeTabKnowledge,
      _HomeTab.settings => l10n.homeTabSettings,
    };
  }
}

class _TabItem extends StatelessWidget {
  const _TabItem({
    required this.tab,
    required this.label,
    required this.isSelected,
  });

  final _HomeTab tab;
  final String label;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final color = isSelected ? HomePage._accent : HomePage._muted;

    return InkWell(
      onTap: () {
        if (!isSelected) {
          context.go(tab.route);
        }
      },
      borderRadius: BorderRadius.circular(12),
      child: SizedBox(
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(tab.icon, size: 22, color: color),
            const SizedBox(height: 4),
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: color,
                fontSize: 11,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                height: 1.45,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
