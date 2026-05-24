import 'package:flutter/material.dart';

import '../../../l10n/app_localizations.dart';
import '../../../routing/app_routes.dart';
import 'workbench_chrome.dart';

class KnowledgePage extends StatelessWidget {
  const KnowledgePage({super.key});

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
                  kicker: l10n.knowledgeKicker,
                  title: l10n.knowledgeTitle,
                  titleSize: 32,
                ),
              ),
              PrototypePositioned(
                x: 20,
                y: 82,
                width: 350,
                height: 48,
                child: WorkbenchSearchField(label: l10n.knowledgeSearchHint),
              ),
              PrototypePositioned(
                x: 20,
                y: 148,
                width: 350,
                height: 544,
                child: _KnowledgeContent(l10n: l10n),
              ),
              PrototypePositioned(
                x: 0,
                y: 712,
                width: PrototypeCanvas.width,
                height: 84,
                child: WorkbenchTabBar(
                  l10n: l10n,
                  currentRoute: AppRoutes.knowledge,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _KnowledgeContent extends StatelessWidget {
  const _KnowledgeContent({required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          height: 96,
          child: Row(
            children: [
              Expanded(
                child: _StatCard(
                  value: l10n.knowledgeBaseCount,
                  label: l10n.knowledgeBasesLabel,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _StatCard(
                  value: l10n.knowledgeMemoryCount,
                  label: l10n.knowledgeMemoryLabel,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        _SectionTitle(l10n.knowledgeBasesTitle),
        const SizedBox(height: 14),
        _KnowledgeTile(
          icon: Icons.menu_book_outlined,
          iconColor: WorkbenchColors.accent,
          iconBackground: const Color(0xFFEAF2FF),
          title: l10n.knowledgeLegalLibrary,
          meta: l10n.knowledgeLegalMeta,
        ),
        const SizedBox(height: 14),
        _KnowledgeTile(
          icon: Icons.storage_outlined,
          iconColor: WorkbenchColors.green,
          iconBackground: const Color(0xFFEAF8EF),
          title: l10n.knowledgeProductFaq,
          meta: l10n.knowledgeProductMeta,
        ),
        const SizedBox(height: 14),
        _SectionTitle(l10n.knowledgeRecentMemory),
        const SizedBox(height: 14),
        _MemoryCard(l10n: l10n),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: WorkbenchColors.surface,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: WorkbenchColors.border),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: WorkbenchColors.text,
              fontSize: 30,
              fontWeight: FontWeight.w700,
              height: 1.05,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: WorkbenchColors.muted,
              fontSize: 12,
              fontWeight: FontWeight.w600,
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
        color: WorkbenchColors.text,
        fontSize: 20,
        fontWeight: FontWeight.w700,
        height: 1.25,
      ),
    );
  }
}

class _KnowledgeTile extends StatelessWidget {
  const _KnowledgeTile({
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
    return Container(
      height: 92,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: WorkbenchColors.surface,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: WorkbenchColors.border),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: iconBackground,
              borderRadius: BorderRadius.circular(16),
            ),
            alignment: Alignment.center,
            child: Icon(icon, size: 24, color: iconColor),
          ),
          const SizedBox(width: 13),
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
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    height: 1.25,
                  ),
                ),
                const SizedBox(height: 4),
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
          const SizedBox(width: 13),
          const Icon(
            Icons.chevron_right,
            size: 18,
            color: WorkbenchColors.muted,
          ),
        ],
      ),
    );
  }
}

class _MemoryCard extends StatelessWidget {
  const _MemoryCard({required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 84,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: WorkbenchColors.dark,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: WorkbenchColors.surface.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(14),
            ),
            alignment: Alignment.center,
            child: const Icon(
              Icons.psychology_outlined,
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
                  l10n.knowledgeMemoryPreference,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: WorkbenchColors.surface,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  l10n.knowledgeMemoryMeta,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: WorkbenchColors.surface.withValues(alpha: 0.6),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    height: 1.2,
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
