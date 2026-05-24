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

  @override
  String get homeBrand => 'MateClaw';

  @override
  String get homeTitle => '工作台';

  @override
  String get homeAvatarInitial => '吴';

  @override
  String get homeTodayConversations => '今日会话';

  @override
  String get homeHealth => '健康';

  @override
  String get homeTodayCount => '128';

  @override
  String get homeTodayMeta => '1,842 条消息 · 43 次工具调用';

  @override
  String get homeNewChat => '新对话';

  @override
  String get homeAgent => 'Agent';

  @override
  String get homeApproval => '审批';

  @override
  String get homeRecentRuns => '最近运行';

  @override
  String get homeDailySummaryTask => '日报摘要任务';

  @override
  String get homeDailySummaryMeta => '成功 · 2分钟前 · 12.4k tokens';

  @override
  String get homeContractAgent => '合同审查 Agent';

  @override
  String get homeContractAgentMeta => '运行中 · 飞书渠道 · 3 步骤';

  @override
  String get homeCurrentModel => '当前模型';

  @override
  String get homeModelName => 'OpenAI · GPT-4.1';

  @override
  String get homeModelReady => 'Ready';

  @override
  String get homeTabOverview => '总览';

  @override
  String get homeTabChat => '对话';

  @override
  String get homeTabAgent => 'Agent';

  @override
  String get homeTabKnowledge => '知识';

  @override
  String get homeTabSettings => '设置';
}
