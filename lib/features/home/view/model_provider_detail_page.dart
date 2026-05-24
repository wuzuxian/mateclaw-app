import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../l10n/app_localizations.dart';
import '../../../routing/app_routes.dart';
import '../data/model_provider_catalog.dart';
import 'model_provider_shared.dart';
import 'workbench_chrome.dart';

class ModelProviderDetailPage extends StatelessWidget {
  const ModelProviderDetailPage({required this.providerId, super.key});

  final String providerId;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final provider = modelProviderById(providerId);

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
                  title: provider.displayName,
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
                height: 104,
                child: _HeaderCard(provider: provider, l10n: l10n),
              ),
              PrototypePositioned(
                x: 20,
                y: 208,
                width: 350,
                height: 60,
                child: _MetricsRow(provider: provider, l10n: l10n),
              ),
              PrototypePositioned(
                x: 20,
                y: 282,
                width: 350,
                height: 170,
                child: _ConfigCard(
                  provider: provider,
                  l10n: l10n,
                  onViewModels: () {
                    context.push(
                      AppRoutes.settingsModelProviderModels(provider.id),
                    );
                  },
                ),
              ),
              PrototypePositioned(
                x: 20,
                y: 468,
                width: 350,
                height: 50,
                child: Row(
                  children: [
                    Expanded(
                      child: ModelProviderActionButton(
                        label: l10n.modelProviderTestConnection,
                        backgroundColor: WorkbenchColors.surface,
                        foregroundColor: WorkbenchColors.text,
                        borderColor: WorkbenchColors.border,
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                l10n.modelProviderConnectionSuccess,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ModelProviderActionButton(
                        label: l10n.modelProviderSave,
                        backgroundColor: WorkbenchColors.accent,
                        foregroundColor: WorkbenchColors.surface,
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                l10n.modelProviderConnectionSuccess,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              PrototypePositioned(
                x: 20,
                y: 536,
                width: 350,
                height: 120,
                child: _SummaryCard(
                  provider: provider,
                  l10n: l10n,
                  onViewModels: () {
                    context.push(
                      AppRoutes.settingsModelProviderModels(provider.id),
                    );
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

class _HeaderCard extends StatelessWidget {
  const _HeaderCard({required this.provider, required this.l10n});

  final ModelProviderRecord provider;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: WorkbenchColors.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: WorkbenchColors.border),
      ),
      child: Row(
        children: [
          ModelProviderBrandMark(kind: provider.kind, size: 46),
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
                          fontSize: 18,
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
          _StatusPill(l10n: l10n, status: provider.status),
        ],
      ),
    );
  }
}

class _MetricsRow extends StatelessWidget {
  const _MetricsRow({required this.provider, required this.l10n});

  final ModelProviderRecord provider;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ModelProviderMetricTile(
            label: l10n.modelProviderModelCount,
            value: provider.modelCount.toString(),
            backgroundColor: WorkbenchColors.surface,
            valueColor: WorkbenchColors.text,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: ModelProviderMetricTile(
            label: l10n.modelProviderLatency,
            value: provider.latencyMs == 0 ? '--' : '${provider.latencyMs} ms',
            backgroundColor: WorkbenchColors.surface,
            valueColor: WorkbenchColors.text,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: ModelProviderMetricTile(
            label: l10n.modelProviderRouting,
            value: provider.trafficShare,
            backgroundColor: WorkbenchColors.surface,
            valueColor: WorkbenchColors.text,
          ),
        ),
      ],
    );
  }
}

class _ConfigCard extends StatelessWidget {
  const _ConfigCard({
    required this.provider,
    required this.l10n,
    required this.onViewModels,
  });

  final ModelProviderRecord provider;
  final AppLocalizations l10n;
  final VoidCallback onViewModels;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: WorkbenchColors.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: WorkbenchColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _FieldRow(
            label: l10n.modelProviderEndpoint,
            value: provider.endpoint,
          ),
          const SizedBox(height: 10),
          _FieldRow(
            label: l10n.modelProviderApiKey,
            value: provider.status == ModelProviderStatus.missingKey
                ? l10n.modelProviderMissingKey
                : 'sk-••••••••••••',
          ),
          const SizedBox(height: 10),
          _FieldRow(
            label: l10n.modelProviderDefaultModel,
            value: provider.defaultModel,
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 38,
            child: ModelProviderActionButton(
              label: l10n.modelProviderViewModels,
              backgroundColor: const Color(0xFFF9FAFB),
              foregroundColor: WorkbenchColors.accent,
              onTap: onViewModels,
            ),
          ),
        ],
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({
    required this.provider,
    required this.l10n,
    required this.onViewModels,
  });

  final ModelProviderRecord provider;
  final AppLocalizations l10n;
  final VoidCallback onViewModels;

  @override
  Widget build(BuildContext context) {
    final enabledCount = provider.models.where((item) => item.enabled).length;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  l10n.modelProviderModelsSubtitle,
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
              ModelProviderPill(
                label: l10n.modelProviderEnabledCount(enabledCount),
                textColor: WorkbenchColors.green,
                backgroundColor: WorkbenchColors.green.withValues(alpha: 0.15),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            l10n.modelProviderSubtitle,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: WorkbenchColors.muted,
              fontSize: 12,
              fontWeight: FontWeight.w500,
              height: 1.25,
            ),
          ),
          const Spacer(),
          SizedBox(
            height: 38,
            child: ModelProviderActionButton(
              label: l10n.modelProviderViewModels,
              backgroundColor: WorkbenchColors.accent,
              foregroundColor: WorkbenchColors.surface,
              onTap: onViewModels,
            ),
          ),
        ],
      ),
    );
  }
}

class _FieldRow extends StatelessWidget {
  const _FieldRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 88,
            child: Text(
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
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              value,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.right,
              style: const TextStyle(
                color: WorkbenchColors.text,
                fontSize: 12,
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

class _StatusPill extends StatelessWidget {
  const _StatusPill({required this.l10n, required this.status});

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
