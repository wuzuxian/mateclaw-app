import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../l10n/app_localizations.dart';
import '../../../routing/app_routes.dart';
import '../data/model_provider_catalog.dart';
import 'model_provider_shared.dart';
import 'workbench_chrome.dart';

class ModelProvidersPage extends StatelessWidget {
  const ModelProvidersPage({super.key});

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
                  kicker: l10n.settingsCommonConfig,
                  title: l10n.settingsModelProviders,
                  titleSize: 32,
                  leading: CircleIconButton(
                    icon: Icons.chevron_left,
                    size: 42,
                    iconSize: 22,
                    backgroundColor: WorkbenchColors.surface,
                    iconColor: WorkbenchColors.text,
                    borderColor: WorkbenchColors.border,
                    onTap: () => context.pop(),
                  ),
                  trailing: CircleIconButton(
                    icon: Icons.add,
                    size: 42,
                    iconSize: 22,
                    onTap: () {
                      context.push(AppRoutes.settingsModelProvidersCatalog);
                    },
                  ),
                ),
              ),
              PrototypePositioned(
                x: 20,
                y: 86,
                width: 350,
                height: 84,
                child: _OverviewCard(l10n: l10n),
              ),
              PrototypePositioned(
                x: 20,
                y: 186,
                width: 350,
                height: 458,
                child: _ProviderList(l10n: l10n),
              ),
              PrototypePositioned(
                x: 20,
                y: 660,
                width: 350,
                height: 54,
                child: _FooterActionRow(
                  l10n: l10n,
                  onManageCatalog: () {
                    context.push(AppRoutes.settingsModelProvidersCatalog);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _OverviewCard extends StatelessWidget {
  const _OverviewCard({required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final healthyCount = modelProviders.where((item) {
      return item.status == ModelProviderStatus.healthy;
    }).length;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: WorkbenchColors.dark,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          ModelProviderBrandMark(kind: ModelProviderKind.openai, size: 44),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.modelProvidersSubtitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: WorkbenchColors.surface.withValues(alpha: 0.78),
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  l10n.settingsModelProvidersMeta,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: WorkbenchColors.surface,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    height: 1.2,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          ModelProviderPill(
            label: l10n.modelProviderHealthyCount(healthyCount),
            textColor: WorkbenchColors.green,
            backgroundColor: WorkbenchColors.green.withValues(alpha: 0.15),
          ),
        ],
      ),
    );
  }
}

class _ProviderList extends StatelessWidget {
  const _ProviderList({required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          l10n.settingsModelProviders,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: WorkbenchColors.text,
            fontSize: 20,
            fontWeight: FontWeight.w700,
            height: 1.25,
          ),
        ),
        const SizedBox(height: 12),
        ...List.generate(modelProviders.length, (index) {
          final provider = modelProviders[index];
          return Padding(
            padding: EdgeInsets.only(
              bottom: index == modelProviders.length - 1 ? 0 : 12,
            ),
            child: _ProviderTile(
              provider: provider,
              l10n: l10n,
              onTap: () {
                context.push(
                  AppRoutes.settingsModelProviderDetail(provider.id),
                );
              },
            ),
          );
        }),
      ],
    );
  }
}

class _ProviderTile extends StatelessWidget {
  const _ProviderTile({
    required this.provider,
    required this.l10n,
    required this.onTap,
  });

  final ModelProviderRecord provider;
  final AppLocalizations l10n;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: WorkbenchColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: const BorderSide(color: WorkbenchColors.border),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: SizedBox(
          height: 72,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Row(
              children: [
                ModelProviderBrandMark(kind: provider.kind, size: 42),
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
                              provider.displayName,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: WorkbenchColors.text,
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                height: 1.2,
                              ),
                            ),
                          ),
                          if (provider.isPrimary) ...[
                            const SizedBox(width: 8),
                            ModelProviderPill(
                              label: l10n.modelProviderPrimary,
                              textColor: WorkbenchColors.accent,
                              backgroundColor: const Color(0xFFEAF2FF),
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        provider.endpoint,
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
                const SizedBox(width: 10),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    _ProviderStatusPill(l10n: l10n, status: provider.status),
                    const SizedBox(height: 6),
                    Text(
                      '${provider.latencyMs} ms',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: WorkbenchColors.muted,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        height: 1.1,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 10),
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

class _ProviderStatusPill extends StatelessWidget {
  const _ProviderStatusPill({required this.l10n, required this.status});

  final AppLocalizations l10n;
  final ModelProviderStatus status;

  @override
  Widget build(BuildContext context) {
    return switch (status) {
      ModelProviderStatus.healthy => ModelProviderPill(
        label: l10n.modelProviderHealthy,
        textColor: WorkbenchColors.green,
        backgroundColor: WorkbenchColors.green.withValues(alpha: 0.15),
      ),
      ModelProviderStatus.missingKey => ModelProviderPill(
        label: l10n.modelProviderMissingKey,
        textColor: WorkbenchColors.orange,
        backgroundColor: WorkbenchColors.orange.withValues(alpha: 0.16),
      ),
      ModelProviderStatus.degraded => ModelProviderPill(
        label: l10n.modelProviderDegraded,
        textColor: WorkbenchColors.red,
        backgroundColor: WorkbenchColors.red.withValues(alpha: 0.14),
      ),
      ModelProviderStatus.offline => ModelProviderPill(
        label: l10n.modelProviderOffline,
        textColor: WorkbenchColors.muted,
        backgroundColor: const Color(0xFFF1F3F5),
      ),
    };
  }
}

class _FooterActionRow extends StatelessWidget {
  const _FooterActionRow({required this.l10n, required this.onManageCatalog});

  final AppLocalizations l10n;
  final VoidCallback onManageCatalog;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ModelProviderActionButton(
            label: l10n.modelProviderViewModels,
            backgroundColor: WorkbenchColors.surface,
            foregroundColor: WorkbenchColors.text,
            borderColor: WorkbenchColors.border,
            onTap: () {
              context.push(
                AppRoutes.settingsModelProviderModels(modelProviders.first.id),
              );
            },
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: ModelProviderActionButton(
            label: l10n.modelProviderAddProvider,
            backgroundColor: WorkbenchColors.accent,
            foregroundColor: WorkbenchColors.surface,
            onTap: onManageCatalog,
          ),
        ),
      ],
    );
  }
}
