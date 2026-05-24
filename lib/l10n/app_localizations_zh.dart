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

  @override
  String get chatKicker => 'Chat';

  @override
  String get chatTitle => '对话';

  @override
  String get chatSearchHint => '搜索会话、Agent 或渠道';

  @override
  String get chatNewConversation => '新建对话';

  @override
  String get chatNewConversationSubtitle => '选择 Agent，开始一次新的任务';

  @override
  String get chatRecentConversations => '最近对话';

  @override
  String get chatRecentCount => '24';

  @override
  String get chatContractAgent => '合同审查 Agent';

  @override
  String get chatContractTime => '09:32';

  @override
  String get chatContractPreview => '发现 3 个高风险点，建议先补充验收条件...';

  @override
  String get chatContractStatus => '工具完成';

  @override
  String get chatContractMessageCount => '12 条消息';

  @override
  String get chatDataAgent => '数据分析 Agent';

  @override
  String get chatDataTime => '昨天';

  @override
  String get chatDataPreview => '已生成本周经营指标摘要和异常说明。';

  @override
  String get chatDataMeta => '8 条消息 · MySQL 数据源';

  @override
  String get chatSupportAgent => '客服助理 Agent';

  @override
  String get chatSupportTime => '周二';

  @override
  String get chatSupportPreview => '客户希望确认退款进度，已同步工单状态。';

  @override
  String get chatSupportMeta => '微信渠道 · 5 条消息';

  @override
  String get chatDailyTask => '日报摘要任务';

  @override
  String get chatDailyPreview => 'Cron 触发 · 成功完成';

  @override
  String get chatDetailMeta => 'ReAct · 在线 · GPT-4.1';

  @override
  String get chatDetailTimestamp => '今天 09:32';

  @override
  String get chatUserMessage => '帮我检查这份采购合同，重点看付款条款和违约责任。';

  @override
  String get chatBotMessage => '已完成初审。发现 3 个高风险点，建议先补充验收条件，再调整逾期付款宽限期。';

  @override
  String get chatRiskPayment => '高风险 · 付款节点不明确';

  @override
  String get chatRiskLiability => '中风险 · 违约金上限缺失';

  @override
  String get chatToolComplete => '工具调用完成';

  @override
  String get chatToolMeta => '合同解析器 · 法务知识库 · 1.8s';

  @override
  String get chatInputHint => '输入消息或上传文件';
}
