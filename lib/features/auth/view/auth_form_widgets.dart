import 'package:flutter/material.dart';

import '../../../l10n/app_localizations.dart';

abstract final class AuthPalette {
  static const accent = Color(0xFF007AFF);
  static const background = Color(0xFFF5F5F7);
  static const surface = Color(0xFFFFFFFF);
  static const surfaceMuted = Color(0xFFF9FAFB);
  static const text = Color(0xFF111827);
  static const muted = Color(0xFF6B7280);
  static const border = Color(0xFFE5E7EB);
}

class AuthLogoBlock extends StatelessWidget {
  const AuthLogoBlock({super.key, required this.l10n, required this.subtitle});

  final AppLocalizations l10n;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 96,
          height: 96,
          decoration: BoxDecoration(
            color: AuthPalette.surface,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: AuthPalette.border),
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
              color: AuthPalette.accent,
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
                color: AuthPalette.text,
                fontSize: 36,
                fontWeight: FontWeight.w800,
                height: 1.36,
              ),
            ),
            Text(
              l10n.loginBrandClaw,
              style: const TextStyle(
                color: AuthPalette.accent,
                fontSize: 36,
                fontWeight: FontWeight.w800,
                height: 1.36,
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        Text(
          subtitle,
          style: const TextStyle(
            color: AuthPalette.muted,
            fontSize: 14,
            fontWeight: FontWeight.w600,
            height: 1.43,
          ),
        ),
      ],
    );
  }
}

class AuthTextField extends StatelessWidget {
  const AuthTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.icon,
    required this.textInputAction,
    required this.enabled,
    this.obscureText = false,
    this.suffix,
    this.onChanged,
    this.onSubmitted,
  });

  final TextEditingController controller;
  final String hintText;
  final IconData icon;
  final TextInputAction textInputAction;
  final bool enabled;
  final bool obscureText;
  final Widget? suffix;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 54,
      child: TextField(
        controller: controller,
        enabled: enabled,
        obscureText: obscureText,
        textInputAction: textInputAction,
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        cursorColor: AuthPalette.accent,
        style: const TextStyle(
          color: AuthPalette.text,
          fontSize: 15,
          fontWeight: FontWeight.w500,
          height: 1.47,
        ),
        decoration: InputDecoration(
          filled: true,
          fillColor: AuthPalette.surface,
          hintText: hintText,
          hintStyle: const TextStyle(
            color: AuthPalette.muted,
            fontSize: 15,
            fontWeight: FontWeight.w500,
            height: 1.47,
          ),
          prefixIcon: Icon(icon, size: 19, color: AuthPalette.muted),
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
            borderSide: const BorderSide(color: AuthPalette.border),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: const BorderSide(color: AuthPalette.accent),
          ),
        ),
      ),
    );
  }
}

class AuthAgreementRow extends StatelessWidget {
  const AuthAgreementRow({
    super.key,
    required this.l10n,
    required this.hasAgreed,
    required this.onToggleAgreement,
  });

  final AppLocalizations l10n;
  final bool hasAgreed;
  final VoidCallback? onToggleAgreement;

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
                  color: hasAgreed ? AuthPalette.accent : AuthPalette.surface,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                    color: hasAgreed
                        ? AuthPalette.accent
                        : AuthPalette.border,
                  ),
                ),
                child: hasAgreed
                    ? const Icon(
                        Icons.check,
                        size: 14,
                        color: AuthPalette.surface,
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
                          color: AuthPalette.accent,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      TextSpan(text: l10n.loginAgreementAnd),
                      TextSpan(
                        text: l10n.loginAgreementPrivacy,
                        style: const TextStyle(
                          color: AuthPalette.accent,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  style: const TextStyle(
                    color: AuthPalette.muted,
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

class AuthErrorMessage extends StatelessWidget {
  const AuthErrorMessage({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF1F2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFFFCDD2)),
      ),
      child: Text(
        message,
        style: const TextStyle(
          color: Color(0xFFB42318),
          fontSize: 12,
          fontWeight: FontWeight.w700,
          height: 1.42,
        ),
      ),
    );
  }
}

class AuthLoadingLabel extends StatelessWidget {
  const AuthLoadingLabel({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(
          width: 18,
          height: 18,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: AuthPalette.surface,
          ),
        ),
        const SizedBox(width: 10),
        Text(label),
      ],
    );
  }
}
