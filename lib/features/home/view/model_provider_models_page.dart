import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../l10n/app_localizations.dart';
import '../data/model_provider_catalog.dart';
import 'model_provider_shared.dart';
import 'workbench_chrome.dart';

class ModelProviderModelsPage extends StatefulWidget {
  const ModelProviderModelsPage({required this.providerId, super.key});

  final String providerId;

  @override
  State<ModelProviderModelsPage> createState() =>
      _ModelProviderModelsPageState();
}

class _ModelProviderModelsPageState extends State<ModelProviderModelsPage> {
  int _selectedFilter = 0;
  final Set<String> _enabledOverrides = {};

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final provider = modelProviderById(widget.providerId);
    final models = _filteredModels(provider.models);
    final enabledCount = _effectiveEnabledCount(provider.models);

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
                y: 86,
                width: 350,
                height: 68,
                child: _IntroCard(
                  provider: provider,
                  l10n: l10n,
                  enabledCount: enabledCount,
                ),
              ),
              PrototypePositioned(
                x: 20,
                y: 168,
                width: 350,
                height: 44,
                child: _FilterBar(
                  l10n: l10n,
                  selectedFilter: _selectedFilter,
                  onChanged: (index) {
                    setState(() {
                      _selectedFilter = index;
                    });
                  },
                ),
              ),
              PrototypePositioned(
                x: 20,
                y: 228,
                width: 350,
                height: 430,
                child: _ModelList(
                  provider: provider,
                  l10n: l10n,
                  models: models,
                  enabledOverrides: _enabledOverrides,
                  onToggle: (name) {
                    setState(() {
                      if (_enabledOverrides.contains(name)) {
                        _enabledOverrides.remove(name);
                      } else {
                        _enabledOverrides.add(name);
                      }
                    });
                  },
                ),
              ),
              PrototypePositioned(
                x: 20,
                y: 674,
                width: 350,
                height: 44,
                child: ModelProviderActionButton(
                  label: l10n.modelProviderSave,
                  backgroundColor: WorkbenchColors.accent,
                  foregroundColor: WorkbenchColors.surface,
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(l10n.modelProviderConnectionSuccess),
                      ),
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

  List<ProviderModelRecord> _filteredModels(List<ProviderModelRecord> models) {
    return switch (_selectedFilter) {
      1 => models.where((item) => item.recommended).toList(),
      2 => models.where((item) => _isEnabled(item)).toList(),
      _ => models,
    };
  }

  bool _isEnabled(ProviderModelRecord model) {
    return _enabledOverrides.contains(model.name) ? true : model.enabled;
  }

  int _effectiveEnabledCount(List<ProviderModelRecord> models) {
    return models.where(_isEnabled).length;
  }
}

class _IntroCard extends StatelessWidget {
  const _IntroCard({
    required this.provider,
    required this.l10n,
    required this.enabledCount,
  });

  final ModelProviderRecord provider;
  final AppLocalizations l10n;
  final int enabledCount;

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
          ModelProviderBrandMark(kind: provider.kind, size: 40),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  provider.endpoint,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: WorkbenchColors.text,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '$enabledCount/${provider.models.length} ${l10n.modelProviderEnabled}',
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
              Text(
                l10n.modelProviderDefaultModel,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: WorkbenchColors.muted,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  height: 1.1,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                provider.defaultModel,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: WorkbenchColors.text,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  height: 1.1,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _FilterBar extends StatelessWidget {
  const _FilterBar({
    required this.l10n,
    required this.selectedFilter,
    required this.onChanged,
  });

  final AppLocalizations l10n;
  final int selectedFilter;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    final labels = [
      l10n.modelProviderFilterAll,
      l10n.modelProviderFilterRecommended,
      l10n.modelProviderFilterEnabled,
    ];

    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xFFE9ECEF),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          for (var index = 0; index < labels.length; index++) ...[
            Expanded(
              child: _FilterSegment(
                label: labels[index],
                selected: selectedFilter == index,
                onTap: () => onChanged(index),
              ),
            ),
            if (index != labels.length - 1) const SizedBox(width: 4),
          ],
        ],
      ),
    );
  }
}

class _FilterSegment extends StatelessWidget {
  const _FilterSegment({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(11),
        child: Container(
          height: 36,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: selected ? WorkbenchColors.surface : Colors.transparent,
            borderRadius: BorderRadius.circular(11),
          ),
          child: Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: selected ? WorkbenchColors.text : WorkbenchColors.muted,
              fontSize: 13,
              fontWeight: FontWeight.w700,
              height: 1.2,
            ),
          ),
        ),
      ),
    );
  }
}

class _ModelList extends StatelessWidget {
  const _ModelList({
    required this.provider,
    required this.l10n,
    required this.models,
    required this.enabledOverrides,
    required this.onToggle,
  });

  final ModelProviderRecord provider;
  final AppLocalizations l10n;
  final List<ProviderModelRecord> models;
  final Set<String> enabledOverrides;
  final ValueChanged<String> onToggle;

  @override
  Widget build(BuildContext context) {
    if (models.isEmpty) {
      return Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: WorkbenchColors.surface,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: WorkbenchColors.border),
        ),
        child: Text(
          l10n.modelProviderMissingKey,
          style: const TextStyle(
            color: WorkbenchColors.muted,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: ListView.separated(
            padding: EdgeInsets.zero,
            itemCount: models.length,
            separatorBuilder: (context, index) => const SizedBox(height: 10),
            itemBuilder: (context, index) {
              final model = models[index];
              final enabled = enabledOverrides.contains(model.name)
                  ? true
                  : model.enabled;
              return _ModelTile(
                provider: provider,
                model: model,
                enabled: enabled,
                l10n: l10n,
                onToggle: () => onToggle(model.name),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _ModelTile extends StatelessWidget {
  const _ModelTile({
    required this.provider,
    required this.model,
    required this.enabled,
    required this.l10n,
    required this.onToggle,
  });

  final ModelProviderRecord provider;
  final ProviderModelRecord model;
  final bool enabled;
  final AppLocalizations l10n;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 76,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: WorkbenchColors.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: WorkbenchColors.border),
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: modelProviderColorForKind(
                provider.kind,
              ).withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(14),
            ),
            alignment: Alignment.center,
            child: const Icon(
              Icons.auto_awesome_outlined,
              size: 20,
              color: WorkbenchColors.accent,
            ),
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
                        model.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: WorkbenchColors.text,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          height: 1.2,
                        ),
                      ),
                    ),
                    if (model.recommended) ...[
                      const SizedBox(width: 8),
                      ModelProviderPill(
                        label: l10n.modelProviderRecommended,
                        textColor: WorkbenchColors.orange,
                        backgroundColor: WorkbenchColors.orange.withValues(
                          alpha: 0.15,
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  model.contextWindow,
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
          Switch(value: enabled, onChanged: (_) => onToggle()),
        ],
      ),
    );
  }
}
