import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../l10n/app_localizations.dart';
import '../../../routing/app_routes.dart';
import '../data/model_provider_catalog.dart';
import 'model_provider_shared.dart';
import 'workbench_chrome.dart';

class ModelProviderCatalogPage extends StatelessWidget {
  const ModelProviderCatalogPage({super.key});

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
                  kicker: l10n.settingsModelProviders,
                  title: l10n.modelProviderCatalogTitle,
                  titleSize: 28,
                  leading: CircleIconButton(
                    icon: Icons.chevron_left,
                    size: 42,
                    iconSize: 22,
                    backgroundColor: WorkbenchColors.surface,
                    iconColor: WorkbenchColors.text,
                    borderColor: WorkbenchColors.border,
                    onTap: () => context.pop(),
                  ),
                ),
              ),
              PrototypePositioned(
                x: 20,
                y: 88,
                width: 350,
                height: 66,
                child: _IntroCard(l10n: l10n),
              ),
              PrototypePositioned(
                x: 20,
                y: 168,
                width: 350,
                height: 438,
                child: _CatalogGrid(l10n: l10n),
              ),
              PrototypePositioned(
                x: 20,
                y: 620,
                width: 350,
                height: 54,
                child: _BottomNote(l10n: l10n),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _IntroCard extends StatelessWidget {
  const _IntroCard({required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: WorkbenchColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: WorkbenchColors.border),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFFEAF2FF),
              borderRadius: BorderRadius.circular(14),
            ),
            alignment: Alignment.center,
            child: const Icon(
              Icons.layers_outlined,
              size: 22,
              color: WorkbenchColors.accent,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              l10n.modelProviderCatalogSubtitle,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: WorkbenchColors.muted,
                fontSize: 12,
                fontWeight: FontWeight.w500,
                height: 1.28,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CatalogGrid extends StatelessWidget {
  const _CatalogGrid({required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: [
        for (final entry in modelProviderCatalogEntries)
          SizedBox(
            width: 170,
            height: 102,
            child: _CatalogTile(
              entry: entry,
              l10n: l10n,
              onTap: () {
                context.push(AppRoutes.settingsModelProviderDetail(entry.id));
              },
            ),
          ),
      ],
    );
  }
}

class _CatalogTile extends StatelessWidget {
  const _CatalogTile({
    required this.entry,
    required this.l10n,
    required this.onTap,
  });

  final ModelProviderCatalogEntry entry;
  final AppLocalizations l10n;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: WorkbenchColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: const BorderSide(color: WorkbenchColors.border),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  ModelProviderBrandMark(kind: entry.kind, size: 38),
                  const Spacer(),
                  const Icon(
                    Icons.chevron_right,
                    size: 18,
                    color: WorkbenchColors.muted,
                  ),
                ],
              ),
              const Spacer(),
              Text(
                entry.displayName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: WorkbenchColors.text,
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  ModelProviderPill(
                    label: l10n.modelProviderAvailable,
                    textColor: WorkbenchColors.green,
                    backgroundColor: WorkbenchColors.green.withValues(
                      alpha: 0.15,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BottomNote extends StatelessWidget {
  const _BottomNote({required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: WorkbenchColors.dark,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.verified_outlined,
            size: 20,
            color: WorkbenchColors.surface,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              l10n.modelProviderCatalogSubtitle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: WorkbenchColors.surface,
                fontSize: 14,
                fontWeight: FontWeight.w700,
                height: 1.2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
