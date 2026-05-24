import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../l10n/app_localizations.dart';
import '../../../routing/app_routes.dart';

class ChatDetailPage extends StatelessWidget {
  const ChatDetailPage({super.key});

  static const _accent = Color(0xFF007AFF);
  static const _background = Color(0xFFF5F5F7);
  static const _surface = Color(0xFFFFFFFF);
  static const _text = Color(0xFF111827);
  static const _muted = Color(0xFF6B7280);
  static const _border = Color(0xFFE5E7EB);
  static const _green = Color(0xFF34C759);
  static const _orange = Color(0xFFFF9500);
  static const _red = Color(0xFFFF3B30);
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
                x: 16,
                y: 10,
                width: 358,
                height: 58,
                child: _ChatDetailHeader(l10n: l10n),
              ),
              _PrototypePositioned(
                x: 20,
                y: 84,
                width: 350,
                height: 548,
                child: _MessageThread(l10n: l10n),
              ),
              _PrototypePositioned(
                x: 16,
                y: 716,
                width: 358,
                height: 56,
                child: _Composer(l10n: l10n),
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
        final widthScale =
            constraints.maxWidth / ChatDetailPage._prototypeWidth;
        final heightScale =
            constraints.maxHeight / ChatDetailPage._prototypeSafeHeight;
        final scale = widthScale < heightScale ? widthScale : heightScale;

        return MediaQuery.withNoTextScaling(
          child: Center(
            child: SizedBox(
              width: ChatDetailPage._prototypeWidth * scale,
              height: ChatDetailPage._prototypeSafeHeight * scale,
              child: Transform.scale(
                scale: scale,
                alignment: Alignment.topLeft,
                child: SizedBox(
                  width: ChatDetailPage._prototypeWidth,
                  height: ChatDetailPage._prototypeSafeHeight,
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

class _ChatDetailHeader extends StatelessWidget {
  const _ChatDetailHeader({required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _HeaderIconButton(
          icon: Icons.chevron_left,
          color: ChatDetailPage._accent,
          onTap: () => context.go(AppRoutes.chat),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: const Color(0xFFEAF2FF),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(
                  Icons.smart_toy_outlined,
                  size: 24,
                  color: ChatDetailPage._accent,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.chatContractAgent,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: ChatDetailPage._text,
                        fontSize: 19,
                        fontWeight: FontWeight.w700,
                        height: 1.26,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      l10n.chatDetailMeta,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: ChatDetailPage._muted,
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
        ),
        const SizedBox(width: 10),
        _HeaderIconButton(
          icon: Icons.more_horiz,
          color: ChatDetailPage._text,
          onTap: () {},
        ),
      ],
    );
  }
}

class _HeaderIconButton extends StatelessWidget {
  const _HeaderIconButton({
    required this.icon,
    required this.color,
    required this.onTap,
  });

  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: ChatDetailPage._surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(19),
        side: const BorderSide(color: ChatDetailPage._border),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(19),
        child: SizedBox(
          width: 38,
          height: 38,
          child: Icon(icon, size: 22, color: color),
        ),
      ),
    );
  }
}

class _MessageThread extends StatelessWidget {
  const _MessageThread({required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Center(
          child: Text(
            l10n.chatDetailTimestamp,
            style: const TextStyle(
              color: ChatDetailPage._muted,
              fontSize: 12,
              fontWeight: FontWeight.w600,
              height: 1.42,
            ),
          ),
        ),
        const SizedBox(height: 14),
        Align(
          alignment: Alignment.centerRight,
          child: _UserBubble(message: l10n.chatUserMessage),
        ),
        const SizedBox(height: 14),
        Align(
          alignment: Alignment.centerLeft,
          child: _BotBubble(l10n: l10n),
        ),
        const SizedBox(height: 14),
        _ToolTrace(l10n: l10n),
      ],
    );
  }
}

class _UserBubble extends StatelessWidget {
  const _UserBubble({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 276,
      padding: const EdgeInsets.all(14),
      decoration: const BoxDecoration(
        color: ChatDetailPage._accent,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(6),
        ),
      ),
      child: Text(
        message,
        style: const TextStyle(
          color: ChatDetailPage._surface,
          fontSize: 15,
          fontWeight: FontWeight.w500,
          height: 1.35,
        ),
      ),
    );
  }
}

class _BotBubble extends StatelessWidget {
  const _BotBubble({required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 302,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: ChatDetailPage._surface,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
          bottomLeft: Radius.circular(6),
          bottomRight: Radius.circular(20),
        ),
        border: Border.all(color: ChatDetailPage._border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            l10n.chatBotMessage,
            style: const TextStyle(
              color: ChatDetailPage._text,
              fontSize: 15,
              fontWeight: FontWeight.w500,
              height: 1.35,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFF9FAFB),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.chatRiskPayment,
                  style: const TextStyle(
                    color: ChatDetailPage._red,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    height: 1.38,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  l10n.chatRiskLiability,
                  style: const TextStyle(
                    color: ChatDetailPage._orange,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    height: 1.38,
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

class _ToolTrace extends StatelessWidget {
  const _ToolTrace({required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFEEF8F1),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.construction_outlined,
            size: 20,
            color: ChatDetailPage._green,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.chatToolComplete,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: ChatDetailPage._text,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    height: 1.43,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  l10n.chatToolMeta,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: ChatDetailPage._muted,
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

class _Composer extends StatelessWidget {
  const _Composer({required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 8, 8, 8),
      decoration: BoxDecoration(
        color: ChatDetailPage._surface.withValues(alpha: 0.95),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: const Color(0xFFD1D5DB)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x10000000),
            blurRadius: 18,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.attach_file, size: 20, color: Color(0xFF8E8E93)),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              l10n.chatInputHint,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Color(0xFF8E8E93),
                fontSize: 14,
                fontWeight: FontWeight.w500,
                height: 1.43,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Container(
            width: 34,
            height: 34,
            decoration: const BoxDecoration(
              color: ChatDetailPage._accent,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.arrow_upward,
              size: 18,
              color: ChatDetailPage._surface,
            ),
          ),
        ],
      ),
    );
  }
}
