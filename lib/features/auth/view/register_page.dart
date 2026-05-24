import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../l10n/app_localizations.dart';
import '../../../routing/app_routes.dart';
import '../viewmodel/register_view_model.dart';
import 'auth_form_widgets.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _usernameController = TextEditingController();
  final _nicknameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _workspaceController = TextEditingController();

  bool _isPasswordObscured = true;
  bool _hasAgreed = true;

  Future<void> _register(RegisterViewModel viewModel) async {
    FocusScope.of(context).unfocus();
    final didRegister = await viewModel.register(
      username: _usernameController.text,
      nickname: _nicknameController.text,
      password: _passwordController.text,
      workspaceName: _workspaceController.text,
    );
    if (!mounted || !didRegister) {
      return;
    }

    context.go(AppRoutes.home);
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _nicknameController.dispose();
    _passwordController.dispose();
    _workspaceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final viewModel = context.watch<RegisterViewModel>();

    return Scaffold(
      backgroundColor: AuthPalette.background,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 34, 20, 38),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 350),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AuthLogoBlock(l10n: l10n, subtitle: l10n.registerSubtitle),
                  const SizedBox(height: 24),
                  _RegisterForm(
                    l10n: l10n,
                    usernameController: _usernameController,
                    nicknameController: _nicknameController,
                    passwordController: _passwordController,
                    workspaceController: _workspaceController,
                    isPasswordObscured: _isPasswordObscured,
                    hasAgreed: _hasAgreed,
                    isLoading: viewModel.isLoading,
                    error: viewModel.error,
                    onTogglePassword: () {
                      setState(() {
                        _isPasswordObscured = !_isPasswordObscured;
                      });
                    },
                    onToggleAgreement: () {
                      setState(() {
                        _hasAgreed = !_hasAgreed;
                      });
                    },
                    onRegister: () => _register(viewModel),
                    onInputChanged: viewModel.clearError,
                  ),
                  const SizedBox(height: 18),
                  _LoginSwitcher(l10n: l10n, isLoading: viewModel.isLoading),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _RegisterForm extends StatelessWidget {
  const _RegisterForm({
    required this.l10n,
    required this.usernameController,
    required this.nicknameController,
    required this.passwordController,
    required this.workspaceController,
    required this.isPasswordObscured,
    required this.hasAgreed,
    required this.isLoading,
    required this.error,
    required this.onTogglePassword,
    required this.onToggleAgreement,
    required this.onRegister,
    required this.onInputChanged,
  });

  final AppLocalizations l10n;
  final TextEditingController usernameController;
  final TextEditingController nicknameController;
  final TextEditingController passwordController;
  final TextEditingController workspaceController;
  final bool isPasswordObscured;
  final bool hasAgreed;
  final bool isLoading;
  final RegisterError? error;
  final VoidCallback onTogglePassword;
  final VoidCallback onToggleAgreement;
  final VoidCallback onRegister;
  final VoidCallback onInputChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AuthTextField(
          controller: usernameController,
          hintText: l10n.registerUsernameHint,
          icon: Icons.person_outline,
          textInputAction: TextInputAction.next,
          enabled: !isLoading,
          onChanged: (_) => onInputChanged(),
        ),
        const SizedBox(height: 14),
        AuthTextField(
          controller: nicknameController,
          hintText: l10n.registerNicknameHint,
          icon: Icons.badge_outlined,
          textInputAction: TextInputAction.next,
          enabled: !isLoading,
          onChanged: (_) => onInputChanged(),
        ),
        const SizedBox(height: 14),
        AuthTextField(
          controller: passwordController,
          hintText: l10n.registerPasswordHint,
          icon: Icons.lock_outline,
          obscureText: isPasswordObscured,
          textInputAction: TextInputAction.next,
          enabled: !isLoading,
          onChanged: (_) => onInputChanged(),
          suffix: SizedBox(
            width: 30,
            height: 30,
            child: IconButton(
              onPressed: isLoading ? null : onTogglePassword,
              padding: EdgeInsets.zero,
              tooltip: l10n.loginTogglePasswordVisibility,
              style: IconButton.styleFrom(
                backgroundColor: AuthPalette.surfaceMuted,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              icon: Icon(
                isPasswordObscured
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                size: 17,
                color: AuthPalette.muted,
              ),
            ),
          ),
        ),
        const SizedBox(height: 14),
        AuthTextField(
          controller: workspaceController,
          hintText: l10n.registerWorkspaceHint,
          icon: Icons.business_center_outlined,
          textInputAction: TextInputAction.done,
          enabled: !isLoading,
          onChanged: (_) => onInputChanged(),
          onSubmitted: (_) {
            if (hasAgreed && !isLoading) {
              onRegister();
            }
          },
        ),
        const SizedBox(height: 10),
        _WorkspaceHint(l10n: l10n),
        const SizedBox(height: 14),
        AuthAgreementRow(
          l10n: l10n,
          hasAgreed: hasAgreed,
          onToggleAgreement: isLoading ? null : onToggleAgreement,
        ),
        if (error != null) ...[
          const SizedBox(height: 12),
          AuthErrorMessage(message: _messageForError(l10n, error!)),
        ],
        const SizedBox(height: 14),
        SizedBox(
          width: double.infinity,
          height: 52,
          child: FilledButton(
            onPressed: hasAgreed && !isLoading ? onRegister : null,
            style: FilledButton.styleFrom(
              backgroundColor: AuthPalette.accent,
              disabledBackgroundColor: AuthPalette.border,
              foregroundColor: AuthPalette.surface,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
              textStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                height: 1.44,
              ),
              elevation: 0,
              shadowColor: Colors.transparent,
            ),
            child: isLoading
                ? AuthLoadingLabel(label: l10n.registerButtonLoading)
                : Text(l10n.registerButton),
          ),
        ),
      ],
    );
  }

  String _messageForError(AppLocalizations l10n, RegisterError error) {
    return switch (error) {
      RegisterError.emptyUsername => l10n.loginUsernameRequired,
      RegisterError.emptyPassword => l10n.loginPasswordRequired,
      RegisterError.usernameTaken => l10n.registerUsernameTaken,
      RegisterError.invalidInput => l10n.registerInvalidInput,
      RegisterError.rateLimited => l10n.loginRateLimited,
      RegisterError.network => l10n.loginNetworkError,
      RegisterError.server => l10n.registerServerError,
      RegisterError.invalidResponse => l10n.loginInvalidResponse,
      RegisterError.unknown => l10n.registerUnknownError,
    };
  }
}

class _WorkspaceHint extends StatelessWidget {
  const _WorkspaceHint({required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.auto_awesome, size: 16, color: AuthPalette.accent),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            l10n.registerWorkspaceHintText,
            style: const TextStyle(
              color: AuthPalette.muted,
              fontSize: 12,
              fontWeight: FontWeight.w600,
              height: 1.42,
            ),
          ),
        ),
      ],
    );
  }
}

class _LoginSwitcher extends StatelessWidget {
  const _LoginSwitcher({required this.l10n, required this.isLoading});

  final AppLocalizations l10n;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          l10n.registerHasAccount,
          style: const TextStyle(
            color: AuthPalette.muted,
            fontSize: 13,
            fontWeight: FontWeight.w600,
            height: 1.38,
          ),
        ),
        TextButton(
          onPressed: isLoading ? null : () => context.go(AppRoutes.login),
          style: TextButton.styleFrom(
            foregroundColor: AuthPalette.accent,
            textStyle: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              height: 1.38,
            ),
          ),
          child: Text(l10n.registerGoLogin),
        ),
      ],
    );
  }
}
