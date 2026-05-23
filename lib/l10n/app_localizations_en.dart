// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get loginBrandMate => 'Mate';

  @override
  String get loginBrandClaw => 'Claw';

  @override
  String get loginSubtitle => 'Sign in to your AI workspace';

  @override
  String get loginUsernameHint => 'Enter username';

  @override
  String get loginPasswordHint => 'Enter password';

  @override
  String get loginAgreementPrefix => 'I have read and agree to';

  @override
  String get loginAgreementTerms => 'User Agreement';

  @override
  String get loginAgreementAnd => ' and ';

  @override
  String get loginAgreementPrivacy => 'Privacy Policy';

  @override
  String get loginButton => 'Log in';

  @override
  String get loginTogglePasswordVisibility => 'Toggle password visibility';

  @override
  String get loginToggleAgreement => 'Toggle agreement consent';
}
