// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get loginBrandMate => 'Mate';

  @override
  String get loginBrandClaw => 'Claw';

  @override
  String get loginSubtitle => '登录你的 AI 工作台';

  @override
  String get loginUsernameHint => '请输入用户名';

  @override
  String get loginPasswordHint => '请输入密码';

  @override
  String get loginAgreementPrefix => '我已阅读并同意';

  @override
  String get loginAgreementTerms => '用户协议';

  @override
  String get loginAgreementAnd => ' 和 ';

  @override
  String get loginAgreementPrivacy => '隐私政策';

  @override
  String get loginButton => '登录';

  @override
  String get loginTogglePasswordVisibility => '切换密码可见性';

  @override
  String get loginToggleAgreement => '切换协议勾选状态';
}
