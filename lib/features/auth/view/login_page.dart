import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../l10n/app_localizations.dart';
import '../../../routing/app_routes.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  static const _accent = Color(0xFF007AFF);
  static const _background = Color(0xFFF5F5F7);
  static const _surface = Color(0xFFFFFFFF);
  static const _surfaceMuted = Color(0xFFF9FAFB);
  static const _text = Color(0xFF111827);
  static const _muted = Color(0xFF6B7280);
  static const _border = Color(0xFFE5E7EB);

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isPasswordObscured = true;
  bool _hasAgreed = true;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: _background,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 54, 20, 48),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 350),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _LogoBlock(l10n: l10n),
                  const SizedBox(height: 34),
                  _LoginForm(
                    l10n: l10n,
                    usernameController: _usernameController,
                    passwordController: _passwordController,
                    isPasswordObscured: _isPasswordObscured,
                    hasAgreed: _hasAgreed,
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
                    onLogin: () => context.go(AppRoutes.home),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _LogoBlock extends StatelessWidget {
  const _LogoBlock({required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 96,
          height: 96,
          decoration: BoxDecoration(
            color: _LoginPageState._surface,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: _LoginPageState._border),
            boxShadow: const [
              BoxShadow(
                color: Color(0x12000000),
                blurRadius: 24,
                offset: Offset(0, 8),
              ),
            ],
          ),
          alignment: Alignment.center,
          child: Container(
            width: 62,
            height: 62,
            decoration: BoxDecoration(
              color: const Color(0xFFEAF2FF),
              borderRadius: BorderRadius.circular(18),
            ),
            child: const Icon(
              Icons.smart_toy_outlined,
              size: 32,
              color: _LoginPageState._accent,
            ),
          ),
        ),
        const SizedBox(height: 14),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              l10n.loginBrandMate,
              style: const TextStyle(
                color: _LoginPageState._text,
                fontSize: 36,
                fontWeight: FontWeight.w800,
                height: 1.36,
              ),
            ),
            Text(
              l10n.loginBrandClaw,
              style: const TextStyle(
                color: _LoginPageState._accent,
                fontSize: 36,
                fontWeight: FontWeight.w800,
                height: 1.36,
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        Text(
          l10n.loginSubtitle,
          style: const TextStyle(
            color: _LoginPageState._muted,
            fontSize: 14,
            fontWeight: FontWeight.w600,
            height: 1.43,
          ),
        ),
      ],
    );
  }
}

class _LoginForm extends StatelessWidget {
  const _LoginForm({
    required this.l10n,
    required this.usernameController,
    required this.passwordController,
    required this.isPasswordObscured,
    required this.hasAgreed,
    required this.onTogglePassword,
    required this.onToggleAgreement,
    required this.onLogin,
  });

  final AppLocalizations l10n;
  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final bool isPasswordObscured;
  final bool hasAgreed;
  final VoidCallback onTogglePassword;
  final VoidCallback onToggleAgreement;
  final VoidCallback onLogin;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _LoginTextField(
          controller: usernameController,
          hintText: l10n.loginUsernameHint,
          icon: Icons.person_outline,
          textInputAction: TextInputAction.next,
        ),
        const SizedBox(height: 16),
        _LoginTextField(
          controller: passwordController,
          hintText: l10n.loginPasswordHint,
          icon: Icons.lock_outline,
          obscureText: isPasswordObscured,
          textInputAction: TextInputAction.done,
          suffix: SizedBox(
            width: 30,
            height: 30,
            child: IconButton(
              onPressed: onTogglePassword,
              padding: EdgeInsets.zero,
              tooltip: l10n.loginTogglePasswordVisibility,
              style: IconButton.styleFrom(
                backgroundColor: _LoginPageState._surfaceMuted,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              icon: Icon(
                isPasswordObscured
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                size: 17,
                color: _LoginPageState._muted,
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        _AgreementRow(
          l10n: l10n,
          hasAgreed: hasAgreed,
          onToggleAgreement: onToggleAgreement,
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          height: 52,
          child: FilledButton(
            onPressed: hasAgreed ? onLogin : null,
            style: FilledButton.styleFrom(
              backgroundColor: _LoginPageState._accent,
              disabledBackgroundColor: _LoginPageState._border,
              foregroundColor: _LoginPageState._surface,
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
            child: Text(l10n.loginButton),
          ),
        ),
      ],
    );
  }
}

class _LoginTextField extends StatelessWidget {
  const _LoginTextField({
    required this.controller,
    required this.hintText,
    required this.icon,
    required this.textInputAction,
    this.obscureText = false,
    this.suffix,
  });

  final TextEditingController controller;
  final String hintText;
  final IconData icon;
  final TextInputAction textInputAction;
  final bool obscureText;
  final Widget? suffix;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 54,
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        textInputAction: textInputAction,
        cursorColor: _LoginPageState._accent,
        style: const TextStyle(
          color: _LoginPageState._text,
          fontSize: 15,
          fontWeight: FontWeight.w500,
          height: 1.47,
        ),
        decoration: InputDecoration(
          filled: true,
          fillColor: _LoginPageState._surface,
          hintText: hintText,
          hintStyle: const TextStyle(
            color: _LoginPageState._muted,
            fontSize: 15,
            fontWeight: FontWeight.w500,
            height: 1.47,
          ),
          prefixIcon: Icon(icon, size: 19, color: _LoginPageState._muted),
          prefixIconConstraints: const BoxConstraints(
            minWidth: 43,
            minHeight: 54,
          ),
          suffixIcon: suffix == null
              ? null
              : Padding(
                  padding: const EdgeInsets.only(right: 14),
                  child: suffix,
                ),
          suffixIconConstraints: const BoxConstraints(
            minWidth: 44,
            minHeight: 54,
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 16),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: const BorderSide(color: _LoginPageState._border),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: const BorderSide(color: _LoginPageState._accent),
          ),
        ),
      ),
    );
  }
}

class _AgreementRow extends StatelessWidget {
  const _AgreementRow({
    required this.l10n,
    required this.hasAgreed,
    required this.onToggleAgreement,
  });

  final AppLocalizations l10n;
  final bool hasAgreed;
  final VoidCallback onToggleAgreement;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      checked: hasAgreed,
      label: l10n.loginToggleAgreement,
      child: InkWell(
        onTap: onToggleAgreement,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 2),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: hasAgreed
                      ? _LoginPageState._accent
                      : _LoginPageState._surface,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                    color: hasAgreed
                        ? _LoginPageState._accent
                        : _LoginPageState._border,
                  ),
                ),
                child: hasAgreed
                    ? const Icon(
                        Icons.check,
                        size: 14,
                        color: _LoginPageState._surface,
                      )
                    : null,
              ),
              const SizedBox(width: 9),
              Expanded(
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(text: l10n.loginAgreementPrefix),
                      TextSpan(
                        text: l10n.loginAgreementTerms,
                        style: const TextStyle(
                          color: _LoginPageState._accent,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      TextSpan(text: l10n.loginAgreementAnd),
                      TextSpan(
                        text: l10n.loginAgreementPrivacy,
                        style: const TextStyle(
                          color: _LoginPageState._accent,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  style: const TextStyle(
                    color: _LoginPageState._muted,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    height: 1.42,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
