import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../l10n/app_localizations.dart';
import '../../../routing/app_routes.dart';

class ChatListPage extends StatelessWidget {
  const ChatListPage({super.key});

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
                height: 72,
                child: _ChatHeader(l10n: l10n),
              ),
              _PrototypePositioned(
                x: 20,
                y: 86,
                width: 350,
                height: 46,
                child: _SearchBox(label: l10n.chatSearchHint),
              ),
              _PrototypePositioned(
                x: 20,
                y: 150,
                width: 350,
                height: 560,
                child: _ConversationContent(l10n: l10n),
              ),
              _PrototypePositioned(
                x: 0,
                y: 712,
                width: _prototypeWidth,
                height: 84,
                child: _ChatTabBar(l10n: l10n),
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
        final widthScale = constraints.maxWidth / ChatListPage._prototypeWidth;
        final heightScale =
            constraints.maxHeight / ChatListPage._prototypeSafeHeight;
        final scale = widthScale < heightScale ? widthScale : heightScale;

        return MediaQuery.withNoTextScaling(
          child: Center(
            child: SizedBox(
              width: ChatListPage._prototypeWidth * scale,
              height: ChatListPage._prototypeSafeHeight * scale,
              child: Transform.scale(
                scale: scale,
                alignment: Alignment.topLeft,
                child: SizedBox(
                  width: ChatListPage._prototypeWidth,
                  height: ChatListPage._prototypeSafeHeight,
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

class _ChatHeader extends StatelessWidget {
  const _ChatHeader({required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.chatKicker,
                style: const TextStyle(
                  color: ChatListPage._accent,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  height: 1.23,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                l10n.chatTitle,
                style: const TextStyle(
                  color: ChatListPage._text,
                  fontSize: 34,
                  fontWeight: FontWeight.w700,
                  height: 1.18,
                ),
              ),
            ],
          ),
        ),
        Material(
          color: ChatListPage._accent,
          shape: const CircleBorder(),
          elevation: 0,
          shadowColor: Colors.transparent,
          child: InkWell(
            onTap: () {},
            customBorder: const CircleBorder(),
            child: const SizedBox(
              width: 46,
              height: 46,
              child: Icon(Icons.add, size: 23, color: ChatListPage._surface),
            ),
          ),
        ),
      ],
    );
  }
}

class _SearchBox extends StatelessWidget {
  const _SearchBox({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: ChatListPage._surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: ChatListPage._border),
      ),
      child: Row(
        children: [
          const Icon(Icons.search, size: 19, color: ChatListPage._muted),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: ChatListPage._muted,
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

class _ConversationContent extends StatelessWidget {
  const _ConversationContent({required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _NewConversationCard(l10n: l10n),
        const SizedBox(height: 14),
        _RecentHeader(l10n: l10n),
        const SizedBox(height: 14),
        _ConversationTile(
          icon: Icons.manage_search,
          iconColor: ChatListPage._accent,
          iconBackground: Color(0xFFEAF2FF),
          title: l10n.chatContractAgent,
          time: l10n.chatContractTime,
          preview: l10n.chatContractPreview,
          status: l10n.chatContractStatus,
          meta: l10n.chatContractMessageCount,
          elevated: true,
          onTap: () => context.push(AppRoutes.chatDetail),
        ),
        const SizedBox(height: 14),
        _ConversationTile(
          icon: Icons.bar_chart,
          iconColor: ChatListPage._orange,
          iconBackground: Color(0xFFFFF4E5),
          title: l10n.chatDataAgent,
          time: l10n.chatDataTime,
          preview: l10n.chatDataPreview,
          meta: l10n.chatDataMeta,
          onTap: () {},
        ),
        const SizedBox(height: 14),
        _ConversationTile(
          icon: Icons.headset_mic_outlined,
          iconColor: ChatListPage._purple,
          iconBackground: Color(0xFFF4ECFF),
          title: l10n.chatSupportAgent,
          time: l10n.chatSupportTime,
          preview: l10n.chatSupportPreview,
          meta: l10n.chatSupportMeta,
          onTap: () {},
        ),
        const SizedBox(height: 14),
        _DailyTaskTile(l10n: l10n),
      ],
    );
  }
}

class _NewConversationCard extends StatelessWidget {
  const _NewConversationCard({required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: ChatListPage._dark,
      borderRadius: BorderRadius.circular(24),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(24),
        child: SizedBox(
          height: 88,
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(
                    Icons.add_comment_outlined,
                    size: 24,
                    color: ChatListPage._surface,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.chatNewConversation,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: ChatListPage._surface,
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          height: 1.41,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        l10n.chatNewConversationSubtitle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: ChatListPage._surface.withValues(alpha: 0.6),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          height: 1.42,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Icon(
                  Icons.chevron_right,
                  size: 18,
                  color: ChatListPage._surface.withValues(alpha: 0.6),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _RecentHeader extends StatelessWidget {
  const _RecentHeader({required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            l10n.chatRecentConversations,
            style: const TextStyle(
              color: ChatListPage._text,
              fontSize: 20,
              fontWeight: FontWeight.w700,
              height: 1.45,
            ),
          ),
        ),
        Text(
          l10n.chatRecentCount,
          style: const TextStyle(
            color: ChatListPage._muted,
            fontSize: 13,
            fontWeight: FontWeight.w700,
            height: 1.23,
          ),
        ),
      ],
    );
  }
}

class _ConversationTile extends StatelessWidget {
  const _ConversationTile({
    required this.icon,
    required this.iconColor,
    required this.iconBackground,
    required this.title,
    required this.time,
    required this.preview,
    required this.meta,
    required this.onTap,
    this.status,
    this.elevated = false,
  });

  final IconData icon;
  final Color iconColor;
  final Color iconBackground;
  final String title;
  final String time;
  final String preview;
  final String? status;
  final String meta;
  final VoidCallback onTap;
  final bool elevated;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: ChatListPage._surface,
      borderRadius: BorderRadius.circular(22),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(22),
        child: Container(
          height: elevated ? 98 : 92,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: ChatListPage._border),
            boxShadow: elevated
                ? const [
                    BoxShadow(
                      color: Color(0x0E000000),
                      blurRadius: 16,
                      offset: Offset(0, 5),
                    ),
                  ]
                : null,
          ),
          child: Row(
            children: [
              Container(
                width: elevated ? 48 : 46,
                height: elevated ? 48 : 46,
                decoration: BoxDecoration(
                  color: iconBackground,
                  borderRadius: BorderRadius.circular(elevated ? 16 : 15),
                ),
                child: Icon(icon, size: elevated ? 24 : 23, color: iconColor),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: ChatListPage._text,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              height: 1.18,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          time,
                          style: const TextStyle(
                            color: ChatListPage._muted,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            height: 1.18,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 3),
                    Text(
                      preview,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: ChatListPage._muted,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        height: 1.22,
                      ),
                    ),
                    const SizedBox(height: 3),
                    _ConversationMeta(status: status, meta: meta),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ConversationMeta extends StatelessWidget {
  const _ConversationMeta({required this.meta, this.status});

  final String meta;
  final String? status;

  @override
  Widget build(BuildContext context) {
    if (status == null) {
      return Text(
        meta,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          color: ChatListPage._muted,
          fontSize: 11,
          fontWeight: FontWeight.w600,
          height: 1.18,
        ),
      );
    }

    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
          decoration: BoxDecoration(
            color: const Color(0xFFEAF8EF),
            borderRadius: BorderRadius.circular(999),
          ),
          child: Text(
            status!,
            style: const TextStyle(
              color: ChatListPage._green,
              fontSize: 11,
              fontWeight: FontWeight.w700,
              height: 1.0,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            meta,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: ChatListPage._muted,
              fontSize: 11,
              fontWeight: FontWeight.w600,
              height: 1.18,
            ),
          ),
        ),
      ],
    );
  }
}

class _DailyTaskTile extends StatelessWidget {
  const _DailyTaskTile({required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: ChatListPage._surface,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: ChatListPage._border),
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: const Color(0xFFEAF8EF),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(
              Icons.account_tree_outlined,
              size: 21,
              color: ChatListPage._green,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.chatDailyTask,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: ChatListPage._text,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    height: 1.33,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  l10n.chatDailyPreview,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: ChatListPage._muted,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    height: 1.42,
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

class _ChatTabBar extends StatelessWidget {
  const _ChatTabBar({required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: ChatListPage._surface.withValues(alpha: 0.9),
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
            _TabItem(
              icon: Icons.dashboard_outlined,
              label: l10n.homeTabOverview,
              route: AppRoutes.home,
            ),
            _TabItem(
              icon: Icons.chat_bubble_outline,
              label: l10n.homeTabChat,
              route: AppRoutes.chat,
              isSelected: true,
            ),
            _TabItem(
              icon: Icons.smart_toy_outlined,
              label: l10n.homeTabAgent,
              route: AppRoutes.agent,
            ),
            _TabItem(
              icon: Icons.storage_outlined,
              label: l10n.homeTabKnowledge,
              route: AppRoutes.knowledge,
            ),
            _TabItem(
              icon: Icons.settings_outlined,
              label: l10n.homeTabSettings,
              route: AppRoutes.settings,
            ),
          ],
        ),
      ),
    );
  }
}

class _TabItem extends StatelessWidget {
  const _TabItem({
    required this.icon,
    required this.label,
    required this.route,
    this.isSelected = false,
  });

  final IconData icon;
  final String label;
  final String route;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final color = isSelected ? ChatListPage._accent : ChatListPage._muted;

    return Expanded(
      child: InkWell(
        onTap: () {
          if (!isSelected) {
            context.go(route);
          }
        },
        borderRadius: BorderRadius.circular(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 22, color: color),
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
