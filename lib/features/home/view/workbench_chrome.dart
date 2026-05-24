import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../l10n/app_localizations.dart';
import '../../../routing/app_routes.dart';

abstract final class WorkbenchColors {
  static const accent = Color(0xFF007AFF);
  static const background = Color(0xFFF5F5F7);
  static const surface = Color(0xFFFFFFFF);
  static const text = Color(0xFF111827);
  static const muted = Color(0xFF6B7280);
  static const border = Color(0xFFE5E7EB);
  static const green = Color(0xFF34C759);
  static const purple = Color(0xFFAF52DE);
  static const orange = Color(0xFFFF9500);
  static const red = Color(0xFFFF3B30);
  static const dark = Color(0xFF111827);
}

class PrototypeCanvas extends StatelessWidget {
  const PrototypeCanvas({required this.child, super.key});

  static const width = 390.0;
  static const safeHeight = 796.0;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final widthScale = constraints.maxWidth / width;
        final heightScale = constraints.maxHeight / safeHeight;
        final scale = widthScale < heightScale ? widthScale : heightScale;

        return MediaQuery.withNoTextScaling(
          child: Center(
            child: SizedBox(
              width: width * scale,
              height: safeHeight * scale,
              child: Transform.scale(
                scale: scale,
                alignment: Alignment.topLeft,
                child: SizedBox(width: width, height: safeHeight, child: child),
              ),
            ),
          ),
        );
      },
    );
  }
}

class PrototypePositioned extends StatelessWidget {
  const PrototypePositioned({
    required this.x,
    required this.y,
    required this.width,
    required this.height,
    required this.child,
    super.key,
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

class WorkbenchTabBar extends StatelessWidget {
  const WorkbenchTabBar({
    required this.l10n,
    required this.currentRoute,
    super.key,
  });

  final AppLocalizations l10n;
  final String currentRoute;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: WorkbenchColors.surface.withValues(alpha: 0.9),
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
            for (final tab in WorkbenchTab.values)
              Expanded(
                child: _WorkbenchTabItem(
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

enum WorkbenchTab {
  overview(Icons.dashboard_outlined, AppRoutes.home),
  chat(Icons.chat_bubble_outline, AppRoutes.chat),
  agent(Icons.smart_toy_outlined, AppRoutes.agent),
  knowledge(Icons.storage_outlined, AppRoutes.knowledge),
  settings(Icons.settings_outlined, AppRoutes.settings);

  const WorkbenchTab(this.icon, this.route);

  final IconData icon;
  final String route;

  String label(AppLocalizations l10n) {
    return switch (this) {
      WorkbenchTab.overview => l10n.homeTabOverview,
      WorkbenchTab.chat => l10n.homeTabChat,
      WorkbenchTab.agent => l10n.homeTabAgent,
      WorkbenchTab.knowledge => l10n.homeTabKnowledge,
      WorkbenchTab.settings => l10n.homeTabSettings,
    };
  }
}

class _WorkbenchTabItem extends StatelessWidget {
  const _WorkbenchTabItem({
    required this.tab,
    required this.label,
    required this.isSelected,
  });

  final WorkbenchTab tab;
  final String label;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final color = isSelected ? WorkbenchColors.accent : WorkbenchColors.muted;

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
            Icon(tab.icon, size: 20, color: color),
            const SizedBox(height: 2),
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: color,
                fontSize: 10.5,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                height: 1.1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SectionPageHeader extends StatelessWidget {
  const SectionPageHeader({
    required this.kicker,
    required this.title,
    this.titleSize = 34,
    this.leading,
    this.trailing,
    super.key,
  });

  final String kicker;
  final String title;
  final double titleSize;
  final Widget? leading;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (leading != null) ...[leading!, const SizedBox(width: 12)],
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                kicker,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: WorkbenchColors.accent,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  height: 1.23,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: WorkbenchColors.text,
                  fontSize: titleSize,
                  fontWeight: FontWeight.w700,
                  height: 1.18,
                ),
              ),
            ],
          ),
        ),
        if (trailing != null) ...[const SizedBox(width: 14), trailing!],
      ],
    );
  }
}

class CircleIconButton extends StatelessWidget {
  const CircleIconButton({
    required this.icon,
    required this.size,
    required this.iconSize,
    this.onTap,
    this.backgroundColor = WorkbenchColors.accent,
    this.iconColor = WorkbenchColors.surface,
    this.borderColor,
    super.key,
  });

  final IconData icon;
  final double size;
  final double iconSize;
  final VoidCallback? onTap;
  final Color backgroundColor;
  final Color iconColor;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap ?? () {},
        customBorder: const CircleBorder(),
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: backgroundColor,
            shape: BoxShape.circle,
            border: borderColor == null
                ? null
                : Border.all(color: borderColor!),
          ),
          alignment: Alignment.center,
          child: Icon(icon, size: iconSize, color: iconColor),
        ),
      ),
    );
  }
}

class WorkbenchSearchField extends StatelessWidget {
  const WorkbenchSearchField({required this.label, super.key});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: WorkbenchColors.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: WorkbenchColors.border),
      ),
      child: Row(
        children: [
          const Icon(Icons.search, size: 20, color: WorkbenchColors.muted),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: WorkbenchColors.muted,
                fontSize: 14,
                fontWeight: FontWeight.w500,
                height: 1.43,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
