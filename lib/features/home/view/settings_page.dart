import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../l10n/app_localizations.dart';
import '../../../routing/app_routes.dart';
import 'workbench_chrome.dart';
import '../viewmodel/settings_view_model.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final viewModel = context.watch<SettingsViewModel>();

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
                height: 72,
                child: _SettingsHeader(l10n: l10n),
              ),
              PrototypePositioned(
                x: 20,
                y: 94,
                width: 350,
                height: 618,
                child: _SettingsContent(
                  l10n: l10n,
                  isLoggingOut: viewModel.isLoggingOut,
                  onLogout: () async {
                    await viewModel.logout();
                    if (!context.mounted) {
                      return;
                    }
                    context.go(AppRoutes.login);
                  },
                ),
              ),
              PrototypePositioned(
                x: 0,
                y: 712,
                width: PrototypeCanvas.width,
                height: 84,
                child: WorkbenchTabBar(
                  l10n: l10n,
                  currentRoute: AppRoutes.settings,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SettingsHeader extends StatelessWidget {
  const _SettingsHeader({required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: WorkbenchColors.surface,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: WorkbenchColors.border),
          ),
          alignment: Alignment.center,
          child: Text(
            l10n.homeAvatarInitial,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: WorkbenchColors.accent,
              fontSize: 22,
              fontWeight: FontWeight.w700,
              height: 1.1,
            ),
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.settingsTitle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: WorkbenchColors.text,
                  fontSize: 34,
                  fontWeight: FontWeight.w700,
                  height: 1.12,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                l10n.settingsWorkspaceRole,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: WorkbenchColors.muted,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  height: 1.2,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SettingsContent extends StatelessWidget {
  const _SettingsContent({
    required this.l10n,
    required this.isLoggingOut,
    required this.onLogout,
  });

  final AppLocalizations l10n;
  final bool isLoggingOut;
  final Future<void> Function() onLogout;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          _SystemHealthCard(l10n: l10n),
          const SizedBox(height: 8),
          _SettingsSection(
            title: l10n.settingsCommonConfig,
            child: _SettingsList(l10n: l10n),
          ),
          const SizedBox(height: 8),
          _SettingsSection(
            title: l10n.settingsSecurity,
            child: _SecurityCard(l10n: l10n),
          ),
          const SizedBox(height: 8),
          _SettingsSection(
            title: l10n.settingsWorkspaceSettings,
            gap: 7,
            child: _WorkspaceCard(l10n: l10n),
          ),
          const SizedBox(height: 8),
          _LogoutEntry(l10n: l10n, isLoggingOut: isLoggingOut, onTap: onLogout),
        ],
      ),
    );
  }
}

class _SystemHealthCard extends StatelessWidget {
  const _SystemHealthCard({required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 76,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: WorkbenchColors.dark,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: WorkbenchColors.green.withValues(alpha: 0.13),
              borderRadius: BorderRadius.circular(14),
            ),
            alignment: Alignment.center,
            child: const Icon(
              Icons.monitor_heart_outlined,
              size: 26,
              color: WorkbenchColors.green,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.settingsHealthTitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: WorkbenchColors.surface,
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    height: 1.15,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  l10n.settingsHealthMeta,
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
          const SizedBox(width: 14),
          _SmallPill(
            label: l10n.settingsHealthBadge,
            textColor: WorkbenchColors.green,
            background: WorkbenchColors.green.withValues(alpha: 0.15),
          ),
        ],
      ),
    );
  }
}

class _SettingsSection extends StatelessWidget {
  const _SettingsSection({
    required this.title,
    required this.child,
    this.gap = 6,
  });

  final String title;
  final Widget child;
  final double gap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _SectionTitle(title),
        SizedBox(height: gap),
        child,
      ],
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
        height: 1.2,
      ),
    );
  }
}

class _SettingsList extends StatelessWidget {
  const _SettingsList({required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(22),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: WorkbenchColors.surface,
          border: Border.all(color: WorkbenchColors.border),
          borderRadius: BorderRadius.circular(22),
        ),
        child: Column(
          children: [
            _SettingsRow(
              icon: Icons.memory_outlined,
              iconColor: WorkbenchColors.accent,
              title: l10n.settingsModelProviders,
              meta: l10n.settingsModelProvidersMeta,
              onTap: () => context.push(AppRoutes.settingsModelProviders),
            ),
            const _DividerLine(),
            _SettingsRow(
              icon: Icons.extension_outlined,
              iconColor: WorkbenchColors.purple,
              title: l10n.settingsMcpTools,
              meta: l10n.settingsMcpToolsMeta,
            ),
            const _DividerLine(),
            _SettingsRow(
              icon: Icons.sensors_outlined,
              iconColor: WorkbenchColors.orange,
              title: l10n.settingsChannelConnections,
              meta: l10n.settingsChannelConnectionsMeta,
            ),
          ],
        ),
      ),
    );
  }
}

class _SettingsRow extends StatelessWidget {
  const _SettingsRow({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.meta,
    this.onTap,
  });

  final IconData icon;
  final Color iconColor;
  final String title;
  final String meta;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final row = SizedBox(
      height: 40,
      child: Row(
        children: [
          const SizedBox(width: 16),
          Icon(icon, size: 22, color: iconColor),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: WorkbenchColors.text,
                fontSize: 15,
                fontWeight: FontWeight.w600,
                height: 1.2,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Text(
            meta,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: WorkbenchColors.muted,
              fontSize: 12,
              fontWeight: FontWeight.w600,
              height: 1.2,
            ),
          ),
          const SizedBox(width: 12),
          const Icon(
            Icons.chevron_right,
            size: 17,
            color: WorkbenchColors.muted,
          ),
          const SizedBox(width: 16),
        ],
      ),
    );

    if (onTap == null) {
      return row;
    }

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(22),
        child: row,
      ),
    );
  }
}

class _DividerLine extends StatelessWidget {
  const _DividerLine();

  @override
  Widget build(BuildContext context) {
    return Container(height: 1, color: WorkbenchColors.border);
  }
}

class _SecurityCard extends StatelessWidget {
  const _SecurityCard({required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 104,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: WorkbenchColors.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: WorkbenchColors.border),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFECEC),
                  borderRadius: BorderRadius.circular(13),
                ),
                alignment: Alignment.center,
                child: const Icon(
                  Icons.gpp_maybe_outlined,
                  size: 20,
                  color: WorkbenchColors.red,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  l10n.settingsPendingActions,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: WorkbenchColors.text,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    height: 1.2,
                  ),
                ),
              ),
              _SmallPill(
                label: l10n.settingsPendingCount,
                textColor: WorkbenchColors.red,
                background: WorkbenchColors.red.withValues(alpha: 0.13),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Text(
            l10n.settingsApprovalDescription,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: WorkbenchColors.muted,
              fontSize: 12,
              fontWeight: FontWeight.w500,
              height: 1.1,
            ),
          ),
          const SizedBox(height: 5),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: WorkbenchColors.accent,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Text(
                l10n.settingsApprovalQueue,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: WorkbenchColors.surface,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  height: 1.1,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _WorkspaceCard extends StatelessWidget {
  const _WorkspaceCard({required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 146,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: WorkbenchColors.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: WorkbenchColors.border),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: const Color(0xFFEAF2FF),
                  borderRadius: BorderRadius.circular(15),
                ),
                alignment: Alignment.center,
                child: const Icon(
                  Icons.business_outlined,
                  size: 23,
                  color: WorkbenchColors.accent,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.settingsDefaultWorkspace,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: WorkbenchColors.text,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      l10n.settingsWorkspaceMeta,
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
              const SizedBox(width: 12),
              const Icon(
                Icons.chevron_right,
                size: 18,
                color: WorkbenchColors.muted,
              ),
            ],
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 28,
            child: Row(
              children: [
                Expanded(
                  child: _WorkspaceChip(label: l10n.settingsMembersChip),
                ),
                const SizedBox(width: 7),
                Expanded(child: _WorkspaceChip(label: l10n.settingsRolesChip)),
                const SizedBox(width: 7),
                Expanded(child: _WorkspaceChip(label: l10n.settingsAgentsChip)),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: _WorkspaceAction(
                    label: l10n.settingsConfigureWorkspace,
                    isPrimary: true,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _WorkspaceAction(
                    label: l10n.settingsSwitchWorkspace,
                    isPrimary: false,
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

class _LogoutEntry extends StatelessWidget {
  const _LogoutEntry({
    required this.l10n,
    required this.isLoggingOut,
    required this.onTap,
  });

  final AppLocalizations l10n;
  final bool isLoggingOut;
  final Future<void> Function() onTap;

  @override
  Widget build(BuildContext context) {
    final content = Container(
      height: 52,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: WorkbenchColors.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0x26FF3B30)),
      ),
      child: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: const Color(0x14FF3B30),
              borderRadius: BorderRadius.circular(12),
            ),
            alignment: Alignment.center,
            child: const Icon(
              Icons.logout_outlined,
              size: 19,
              color: WorkbenchColors.red,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.settingsLogoutTitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: WorkbenchColors.red,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  l10n.settingsLogoutMeta,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: WorkbenchColors.muted,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    height: 1.2,
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, size: 17, color: WorkbenchColors.red),
        ],
      ),
    );

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: isLoggingOut ? null : () => onTap(),
        borderRadius: BorderRadius.circular(18),
        child: Opacity(opacity: isLoggingOut ? 0.65 : 1, child: content),
      ),
    );
  }
}

class _WorkspaceChip extends StatelessWidget {
  const _WorkspaceChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        label,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          color: WorkbenchColors.text,
          fontSize: 11,
          fontWeight: FontWeight.w700,
          height: 1.1,
        ),
      ),
    );
  }
}

class _WorkspaceAction extends StatelessWidget {
  const _WorkspaceAction({required this.label, required this.isPrimary});

  final String label;
  final bool isPrimary;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isPrimary ? WorkbenchColors.accent : const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(13),
      ),
      child: Text(
        label,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: isPrimary ? WorkbenchColors.surface : WorkbenchColors.accent,
          fontSize: 13,
          fontWeight: FontWeight.w700,
          height: 1.1,
        ),
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
