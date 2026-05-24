import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('zh'),
  ];

  /// No description provided for @loginBrandMate.
  ///
  /// In zh, this message translates to:
  /// **'Mate'**
  String get loginBrandMate;

  /// No description provided for @loginBrandClaw.
  ///
  /// In zh, this message translates to:
  /// **'Claw'**
  String get loginBrandClaw;

  /// No description provided for @loginSubtitle.
  ///
  /// In zh, this message translates to:
  /// **'登录你的 AI 工作台'**
  String get loginSubtitle;

  /// No description provided for @loginUsernameHint.
  ///
  /// In zh, this message translates to:
  /// **'请输入用户名'**
  String get loginUsernameHint;

  /// No description provided for @loginPasswordHint.
  ///
  /// In zh, this message translates to:
  /// **'请输入密码'**
  String get loginPasswordHint;

  /// No description provided for @loginAgreementPrefix.
  ///
  /// In zh, this message translates to:
  /// **'我已阅读并同意'**
  String get loginAgreementPrefix;

  /// No description provided for @loginAgreementTerms.
  ///
  /// In zh, this message translates to:
  /// **'用户协议'**
  String get loginAgreementTerms;

  /// No description provided for @loginAgreementAnd.
  ///
  /// In zh, this message translates to:
  /// **' 和 '**
  String get loginAgreementAnd;

  /// No description provided for @loginAgreementPrivacy.
  ///
  /// In zh, this message translates to:
  /// **'隐私政策'**
  String get loginAgreementPrivacy;

  /// No description provided for @loginButton.
  ///
  /// In zh, this message translates to:
  /// **'登录'**
  String get loginButton;

  /// No description provided for @loginButtonLoading.
  ///
  /// In zh, this message translates to:
  /// **'登录中...'**
  String get loginButtonLoading;

  /// No description provided for @loginUsernameRequired.
  ///
  /// In zh, this message translates to:
  /// **'请输入用户名'**
  String get loginUsernameRequired;

  /// No description provided for @loginPasswordRequired.
  ///
  /// In zh, this message translates to:
  /// **'请输入密码'**
  String get loginPasswordRequired;

  /// No description provided for @loginInvalidCredentials.
  ///
  /// In zh, this message translates to:
  /// **'用户名或密码错误'**
  String get loginInvalidCredentials;

  /// No description provided for @loginRateLimited.
  ///
  /// In zh, this message translates to:
  /// **'尝试次数过多，请稍后再试'**
  String get loginRateLimited;

  /// No description provided for @loginNetworkError.
  ///
  /// In zh, this message translates to:
  /// **'无法连接服务器，请检查网络或后端服务'**
  String get loginNetworkError;

  /// No description provided for @loginServerError.
  ///
  /// In zh, this message translates to:
  /// **'登录失败，请稍后再试'**
  String get loginServerError;

  /// No description provided for @loginInvalidResponse.
  ///
  /// In zh, this message translates to:
  /// **'服务器返回数据异常'**
  String get loginInvalidResponse;

  /// No description provided for @loginUnknownError.
  ///
  /// In zh, this message translates to:
  /// **'登录失败，请重试'**
  String get loginUnknownError;

  /// No description provided for @loginTogglePasswordVisibility.
  ///
  /// In zh, this message translates to:
  /// **'切换密码可见性'**
  String get loginTogglePasswordVisibility;

  /// No description provided for @loginToggleAgreement.
  ///
  /// In zh, this message translates to:
  /// **'切换协议勾选状态'**
  String get loginToggleAgreement;

  /// No description provided for @homeBrand.
  ///
  /// In zh, this message translates to:
  /// **'MateClaw'**
  String get homeBrand;

  /// No description provided for @homeTitle.
  ///
  /// In zh, this message translates to:
  /// **'工作台'**
  String get homeTitle;

  /// No description provided for @homeAvatarInitial.
  ///
  /// In zh, this message translates to:
  /// **'吴'**
  String get homeAvatarInitial;

  /// No description provided for @homeTodayConversations.
  ///
  /// In zh, this message translates to:
  /// **'今日会话'**
  String get homeTodayConversations;

  /// No description provided for @homeHealth.
  ///
  /// In zh, this message translates to:
  /// **'健康'**
  String get homeHealth;

  /// No description provided for @homeTodayCount.
  ///
  /// In zh, this message translates to:
  /// **'128'**
  String get homeTodayCount;

  /// No description provided for @homeTodayMeta.
  ///
  /// In zh, this message translates to:
  /// **'1,842 条消息 · 43 次工具调用'**
  String get homeTodayMeta;

  /// No description provided for @homeNewChat.
  ///
  /// In zh, this message translates to:
  /// **'新对话'**
  String get homeNewChat;

  /// No description provided for @homeAgent.
  ///
  /// In zh, this message translates to:
  /// **'Agent'**
  String get homeAgent;

  /// No description provided for @homeApproval.
  ///
  /// In zh, this message translates to:
  /// **'审批'**
  String get homeApproval;

  /// No description provided for @homePeriodTitle.
  ///
  /// In zh, this message translates to:
  /// **'周期对比'**
  String get homePeriodTitle;

  /// No description provided for @homePeriodSubtitle.
  ///
  /// In zh, this message translates to:
  /// **'从日、周、月三个维度观察系统运行状况。'**
  String get homePeriodSubtitle;

  /// No description provided for @homePeriodToday.
  ///
  /// In zh, this message translates to:
  /// **'今日'**
  String get homePeriodToday;

  /// No description provided for @homePeriodWeek.
  ///
  /// In zh, this message translates to:
  /// **'本周'**
  String get homePeriodWeek;

  /// No description provided for @homePeriodMonth.
  ///
  /// In zh, this message translates to:
  /// **'本月'**
  String get homePeriodMonth;

  /// No description provided for @homePeriodConversations.
  ///
  /// In zh, this message translates to:
  /// **'对话数'**
  String get homePeriodConversations;

  /// No description provided for @homePeriodMessages.
  ///
  /// In zh, this message translates to:
  /// **'消息数'**
  String get homePeriodMessages;

  /// No description provided for @homePeriodTokens.
  ///
  /// In zh, this message translates to:
  /// **'Token'**
  String get homePeriodTokens;

  /// No description provided for @homePeriodTools.
  ///
  /// In zh, this message translates to:
  /// **'工具'**
  String get homePeriodTools;

  /// No description provided for @homePeriodZeroValue.
  ///
  /// In zh, this message translates to:
  /// **'0'**
  String get homePeriodZeroValue;

  /// No description provided for @homeRecentRuns.
  ///
  /// In zh, this message translates to:
  /// **'最近运行'**
  String get homeRecentRuns;

  /// No description provided for @homeDailySummaryTask.
  ///
  /// In zh, this message translates to:
  /// **'日报摘要任务'**
  String get homeDailySummaryTask;

  /// No description provided for @homeDailySummaryMeta.
  ///
  /// In zh, this message translates to:
  /// **'成功 · 2分钟前 · 12.4k tokens'**
  String get homeDailySummaryMeta;

  /// No description provided for @homeContractAgent.
  ///
  /// In zh, this message translates to:
  /// **'合同审查 Agent'**
  String get homeContractAgent;

  /// No description provided for @homeContractAgentMeta.
  ///
  /// In zh, this message translates to:
  /// **'运行中 · 飞书渠道 · 3 步骤'**
  String get homeContractAgentMeta;

  /// No description provided for @homeCurrentModel.
  ///
  /// In zh, this message translates to:
  /// **'当前模型'**
  String get homeCurrentModel;

  /// No description provided for @homeModelName.
  ///
  /// In zh, this message translates to:
  /// **'OpenAI · GPT-4.1'**
  String get homeModelName;

  /// No description provided for @homeModelReady.
  ///
  /// In zh, this message translates to:
  /// **'Ready'**
  String get homeModelReady;

  /// No description provided for @homeModelUnavailable.
  ///
  /// In zh, this message translates to:
  /// **'未配置模型'**
  String get homeModelUnavailable;

  /// No description provided for @homeNoRecentRuns.
  ///
  /// In zh, this message translates to:
  /// **'暂无运行记录'**
  String get homeNoRecentRuns;

  /// No description provided for @homeRetry.
  ///
  /// In zh, this message translates to:
  /// **'重试'**
  String get homeRetry;

  /// No description provided for @homeLoadErrorNetwork.
  ///
  /// In zh, this message translates to:
  /// **'网络异常，正在展示缓存数据'**
  String get homeLoadErrorNetwork;

  /// No description provided for @homeLoadErrorUnauthorized.
  ///
  /// In zh, this message translates to:
  /// **'登录已失效，请重新登录'**
  String get homeLoadErrorUnauthorized;

  /// No description provided for @homeLoadErrorForbidden.
  ///
  /// In zh, this message translates to:
  /// **'无权访问当前工作空间'**
  String get homeLoadErrorForbidden;

  /// No description provided for @homeLoadErrorServer.
  ///
  /// In zh, this message translates to:
  /// **'首页数据加载失败'**
  String get homeLoadErrorServer;

  /// No description provided for @homeLoadErrorInvalidResponse.
  ///
  /// In zh, this message translates to:
  /// **'首页数据格式异常'**
  String get homeLoadErrorInvalidResponse;

  /// No description provided for @homeLoadErrorUnknown.
  ///
  /// In zh, this message translates to:
  /// **'首页数据加载失败'**
  String get homeLoadErrorUnknown;

  /// No description provided for @homeTabOverview.
  ///
  /// In zh, this message translates to:
  /// **'总览'**
  String get homeTabOverview;

  /// No description provided for @homeTabChat.
  ///
  /// In zh, this message translates to:
  /// **'对话'**
  String get homeTabChat;

  /// No description provided for @homeTabAgent.
  ///
  /// In zh, this message translates to:
  /// **'Agent'**
  String get homeTabAgent;

  /// No description provided for @homeTabKnowledge.
  ///
  /// In zh, this message translates to:
  /// **'知识'**
  String get homeTabKnowledge;

  /// No description provided for @homeTabSettings.
  ///
  /// In zh, this message translates to:
  /// **'设置'**
  String get homeTabSettings;

  /// No description provided for @chatKicker.
  ///
  /// In zh, this message translates to:
  /// **'Chat'**
  String get chatKicker;

  /// No description provided for @chatTitle.
  ///
  /// In zh, this message translates to:
  /// **'对话'**
  String get chatTitle;

  /// No description provided for @chatSearchHint.
  ///
  /// In zh, this message translates to:
  /// **'搜索会话、Agent 或渠道'**
  String get chatSearchHint;

  /// No description provided for @chatNewConversation.
  ///
  /// In zh, this message translates to:
  /// **'新建对话'**
  String get chatNewConversation;

  /// No description provided for @chatNewConversationSubtitle.
  ///
  /// In zh, this message translates to:
  /// **'选择 Agent，开始一次新的任务'**
  String get chatNewConversationSubtitle;

  /// No description provided for @chatRecentConversations.
  ///
  /// In zh, this message translates to:
  /// **'最近对话'**
  String get chatRecentConversations;

  /// No description provided for @chatRecentCount.
  ///
  /// In zh, this message translates to:
  /// **'24'**
  String get chatRecentCount;

  /// No description provided for @chatContractAgent.
  ///
  /// In zh, this message translates to:
  /// **'合同审查 Agent'**
  String get chatContractAgent;

  /// No description provided for @chatContractTime.
  ///
  /// In zh, this message translates to:
  /// **'09:32'**
  String get chatContractTime;

  /// No description provided for @chatContractPreview.
  ///
  /// In zh, this message translates to:
  /// **'发现 3 个高风险点，建议先补充验收条件...'**
  String get chatContractPreview;

  /// No description provided for @chatContractStatus.
  ///
  /// In zh, this message translates to:
  /// **'工具完成'**
  String get chatContractStatus;

  /// No description provided for @chatContractMessageCount.
  ///
  /// In zh, this message translates to:
  /// **'12 条消息'**
  String get chatContractMessageCount;

  /// No description provided for @chatDataAgent.
  ///
  /// In zh, this message translates to:
  /// **'数据分析 Agent'**
  String get chatDataAgent;

  /// No description provided for @chatDataTime.
  ///
  /// In zh, this message translates to:
  /// **'昨天'**
  String get chatDataTime;

  /// No description provided for @chatDataPreview.
  ///
  /// In zh, this message translates to:
  /// **'已生成本周经营指标摘要和异常说明。'**
  String get chatDataPreview;

  /// No description provided for @chatDataMeta.
  ///
  /// In zh, this message translates to:
  /// **'8 条消息 · MySQL 数据源'**
  String get chatDataMeta;

  /// No description provided for @chatSupportAgent.
  ///
  /// In zh, this message translates to:
  /// **'客服助理 Agent'**
  String get chatSupportAgent;

  /// No description provided for @chatSupportTime.
  ///
  /// In zh, this message translates to:
  /// **'周二'**
  String get chatSupportTime;

  /// No description provided for @chatSupportPreview.
  ///
  /// In zh, this message translates to:
  /// **'客户希望确认退款进度，已同步工单状态。'**
  String get chatSupportPreview;

  /// No description provided for @chatSupportMeta.
  ///
  /// In zh, this message translates to:
  /// **'微信渠道 · 5 条消息'**
  String get chatSupportMeta;

  /// No description provided for @chatDailyTask.
  ///
  /// In zh, this message translates to:
  /// **'日报摘要任务'**
  String get chatDailyTask;

  /// No description provided for @chatDailyPreview.
  ///
  /// In zh, this message translates to:
  /// **'Cron 触发 · 成功完成'**
  String get chatDailyPreview;

  /// No description provided for @chatDetailMeta.
  ///
  /// In zh, this message translates to:
  /// **'ReAct · 在线 · GPT-4.1'**
  String get chatDetailMeta;

  /// No description provided for @chatDetailTimestamp.
  ///
  /// In zh, this message translates to:
  /// **'今天 09:32'**
  String get chatDetailTimestamp;

  /// No description provided for @chatUserMessage.
  ///
  /// In zh, this message translates to:
  /// **'帮我检查这份采购合同，重点看付款条款和违约责任。'**
  String get chatUserMessage;

  /// No description provided for @chatBotMessage.
  ///
  /// In zh, this message translates to:
  /// **'已完成初审。发现 3 个高风险点，建议先补充验收条件，再调整逾期付款宽限期。'**
  String get chatBotMessage;

  /// No description provided for @chatRiskPayment.
  ///
  /// In zh, this message translates to:
  /// **'高风险 · 付款节点不明确'**
  String get chatRiskPayment;

  /// No description provided for @chatRiskLiability.
  ///
  /// In zh, this message translates to:
  /// **'中风险 · 违约金上限缺失'**
  String get chatRiskLiability;

  /// No description provided for @chatToolComplete.
  ///
  /// In zh, this message translates to:
  /// **'工具调用完成'**
  String get chatToolComplete;

  /// No description provided for @chatToolMeta.
  ///
  /// In zh, this message translates to:
  /// **'合同解析器 · 法务知识库 · 1.8s'**
  String get chatToolMeta;

  /// No description provided for @chatInputHint.
  ///
  /// In zh, this message translates to:
  /// **'输入消息或上传文件'**
  String get chatInputHint;

  /// No description provided for @agentKicker.
  ///
  /// In zh, this message translates to:
  /// **'Agent'**
  String get agentKicker;

  /// No description provided for @agentTitle.
  ///
  /// In zh, this message translates to:
  /// **'团队'**
  String get agentTitle;

  /// No description provided for @agentSegmentMembers.
  ///
  /// In zh, this message translates to:
  /// **'成员'**
  String get agentSegmentMembers;

  /// No description provided for @agentSegmentLive.
  ///
  /// In zh, this message translates to:
  /// **'Live'**
  String get agentSegmentLive;

  /// No description provided for @agentContractName.
  ///
  /// In zh, this message translates to:
  /// **'合同审查 Agent'**
  String get agentContractName;

  /// No description provided for @agentContractDescription.
  ///
  /// In zh, this message translates to:
  /// **'合同风险识别、条款建议、审批摘要'**
  String get agentContractDescription;

  /// No description provided for @agentOnline.
  ///
  /// In zh, this message translates to:
  /// **'在线'**
  String get agentOnline;

  /// No description provided for @agentContractTools.
  ///
  /// In zh, this message translates to:
  /// **'6 工具'**
  String get agentContractTools;

  /// No description provided for @agentDataName.
  ///
  /// In zh, this message translates to:
  /// **'数据分析 Agent'**
  String get agentDataName;

  /// No description provided for @agentDataDescription.
  ///
  /// In zh, this message translates to:
  /// **'连接数据源并生成经营洞察'**
  String get agentDataDescription;

  /// No description provided for @agentDataState.
  ///
  /// In zh, this message translates to:
  /// **'空闲 · 3 工具 · MySQL'**
  String get agentDataState;

  /// No description provided for @agentSupportName.
  ///
  /// In zh, this message translates to:
  /// **'客服助理 Agent'**
  String get agentSupportName;

  /// No description provided for @agentSupportDescription.
  ///
  /// In zh, this message translates to:
  /// **'渠道消息、FAQ、升级工单'**
  String get agentSupportDescription;

  /// No description provided for @agentSupportState.
  ///
  /// In zh, this message translates to:
  /// **'运行中 · 微信渠道 · 18 会话'**
  String get agentSupportState;

  /// No description provided for @agentLiveTitle.
  ///
  /// In zh, this message translates to:
  /// **'Live 运行态'**
  String get agentLiveTitle;

  /// No description provided for @agentLiveAttention.
  ///
  /// In zh, this message translates to:
  /// **'2 需关注'**
  String get agentLiveAttention;

  /// No description provided for @agentLiveRunningCount.
  ///
  /// In zh, this message translates to:
  /// **'12'**
  String get agentLiveRunningCount;

  /// No description provided for @agentLiveRunningLabel.
  ///
  /// In zh, this message translates to:
  /// **'运行中'**
  String get agentLiveRunningLabel;

  /// No description provided for @agentLiveBlockedCount.
  ///
  /// In zh, this message translates to:
  /// **'3'**
  String get agentLiveBlockedCount;

  /// No description provided for @agentLiveBlockedLabel.
  ///
  /// In zh, this message translates to:
  /// **'卡住'**
  String get agentLiveBlockedLabel;

  /// No description provided for @knowledgeKicker.
  ///
  /// In zh, this message translates to:
  /// **'Knowledge'**
  String get knowledgeKicker;

  /// No description provided for @knowledgeTitle.
  ///
  /// In zh, this message translates to:
  /// **'知识与记忆'**
  String get knowledgeTitle;

  /// No description provided for @knowledgeSearchHint.
  ///
  /// In zh, this message translates to:
  /// **'搜索知识库、记忆和文档'**
  String get knowledgeSearchHint;

  /// No description provided for @knowledgeBaseCount.
  ///
  /// In zh, this message translates to:
  /// **'12'**
  String get knowledgeBaseCount;

  /// No description provided for @knowledgeBasesLabel.
  ///
  /// In zh, this message translates to:
  /// **'知识库'**
  String get knowledgeBasesLabel;

  /// No description provided for @knowledgeMemoryCount.
  ///
  /// In zh, this message translates to:
  /// **'4.8k'**
  String get knowledgeMemoryCount;

  /// No description provided for @knowledgeMemoryLabel.
  ///
  /// In zh, this message translates to:
  /// **'记忆条目'**
  String get knowledgeMemoryLabel;

  /// No description provided for @knowledgeBasesTitle.
  ///
  /// In zh, this message translates to:
  /// **'知识库'**
  String get knowledgeBasesTitle;

  /// No description provided for @knowledgeLegalLibrary.
  ///
  /// In zh, this message translates to:
  /// **'法务合同库'**
  String get knowledgeLegalLibrary;

  /// No description provided for @knowledgeLegalMeta.
  ///
  /// In zh, this message translates to:
  /// **'326 文档 · 绑定 2 个 Agent'**
  String get knowledgeLegalMeta;

  /// No description provided for @knowledgeProductFaq.
  ///
  /// In zh, this message translates to:
  /// **'产品 FAQ'**
  String get knowledgeProductFaq;

  /// No description provided for @knowledgeProductMeta.
  ///
  /// In zh, this message translates to:
  /// **'1,240 片段 · 昨天更新'**
  String get knowledgeProductMeta;

  /// No description provided for @knowledgeRecentMemory.
  ///
  /// In zh, this message translates to:
  /// **'近期记忆'**
  String get knowledgeRecentMemory;

  /// No description provided for @knowledgeMemoryPreference.
  ///
  /// In zh, this message translates to:
  /// **'客户偏好：优先中文回复'**
  String get knowledgeMemoryPreference;

  /// No description provided for @knowledgeMemoryMeta.
  ///
  /// In zh, this message translates to:
  /// **'客服助理 Agent · 自动沉淀'**
  String get knowledgeMemoryMeta;

  /// No description provided for @settingsTitle.
  ///
  /// In zh, this message translates to:
  /// **'设置'**
  String get settingsTitle;

  /// No description provided for @settingsWorkspaceRole.
  ///
  /// In zh, this message translates to:
  /// **'默认工作区 · 管理员'**
  String get settingsWorkspaceRole;

  /// No description provided for @settingsHealthTitle.
  ///
  /// In zh, this message translates to:
  /// **'系统健康'**
  String get settingsHealthTitle;

  /// No description provided for @settingsHealthMeta.
  ///
  /// In zh, this message translates to:
  /// **'API、队列、模型服务均正常'**
  String get settingsHealthMeta;

  /// No description provided for @settingsHealthBadge.
  ///
  /// In zh, this message translates to:
  /// **'Healthy'**
  String get settingsHealthBadge;

  /// No description provided for @settingsCommonConfig.
  ///
  /// In zh, this message translates to:
  /// **'常用配置'**
  String get settingsCommonConfig;

  /// No description provided for @settingsModelProviders.
  ///
  /// In zh, this message translates to:
  /// **'模型提供商'**
  String get settingsModelProviders;

  /// No description provided for @settingsModelProvidersMeta.
  ///
  /// In zh, this message translates to:
  /// **'8/10 已配置'**
  String get settingsModelProvidersMeta;

  /// No description provided for @settingsMcpTools.
  ///
  /// In zh, this message translates to:
  /// **'MCP 与工具'**
  String get settingsMcpTools;

  /// No description provided for @settingsMcpToolsMeta.
  ///
  /// In zh, this message translates to:
  /// **'24 工具'**
  String get settingsMcpToolsMeta;

  /// No description provided for @settingsChannelConnections.
  ///
  /// In zh, this message translates to:
  /// **'渠道连接'**
  String get settingsChannelConnections;

  /// No description provided for @settingsChannelConnectionsMeta.
  ///
  /// In zh, this message translates to:
  /// **'飞书、微信'**
  String get settingsChannelConnectionsMeta;

  /// No description provided for @settingsSecurity.
  ///
  /// In zh, this message translates to:
  /// **'安全'**
  String get settingsSecurity;

  /// No description provided for @settingsPendingActions.
  ///
  /// In zh, this message translates to:
  /// **'待审批动作'**
  String get settingsPendingActions;

  /// No description provided for @settingsPendingCount.
  ///
  /// In zh, this message translates to:
  /// **'3'**
  String get settingsPendingCount;

  /// No description provided for @settingsApprovalDescription.
  ///
  /// In zh, this message translates to:
  /// **'高风险工具、文件访问和命令统一审批。'**
  String get settingsApprovalDescription;

  /// No description provided for @settingsApprovalQueue.
  ///
  /// In zh, this message translates to:
  /// **'查看审批队列'**
  String get settingsApprovalQueue;

  /// No description provided for @settingsWorkspaceSettings.
  ///
  /// In zh, this message translates to:
  /// **'工作区设置'**
  String get settingsWorkspaceSettings;

  /// No description provided for @settingsDefaultWorkspace.
  ///
  /// In zh, this message translates to:
  /// **'默认工作区'**
  String get settingsDefaultWorkspace;

  /// No description provided for @settingsWorkspaceMeta.
  ///
  /// In zh, this message translates to:
  /// **'独立隔离 Agent、知识库、渠道与模型权限'**
  String get settingsWorkspaceMeta;

  /// No description provided for @settingsMembersChip.
  ///
  /// In zh, this message translates to:
  /// **'6 成员'**
  String get settingsMembersChip;

  /// No description provided for @settingsRolesChip.
  ///
  /// In zh, this message translates to:
  /// **'4 角色'**
  String get settingsRolesChip;

  /// No description provided for @settingsAgentsChip.
  ///
  /// In zh, this message translates to:
  /// **'12 Agent'**
  String get settingsAgentsChip;

  /// No description provided for @settingsConfigureWorkspace.
  ///
  /// In zh, this message translates to:
  /// **'设置工作区'**
  String get settingsConfigureWorkspace;

  /// No description provided for @settingsSwitchWorkspace.
  ///
  /// In zh, this message translates to:
  /// **'切换'**
  String get settingsSwitchWorkspace;

  /// No description provided for @modelProvidersSubtitle.
  ///
  /// In zh, this message translates to:
  /// **'统一管理供应商、模型和路由'**
  String get modelProvidersSubtitle;

  /// No description provided for @modelProviderCatalogTitle.
  ///
  /// In zh, this message translates to:
  /// **'选择提供商类型'**
  String get modelProviderCatalogTitle;

  /// No description provided for @modelProviderCatalogSubtitle.
  ///
  /// In zh, this message translates to:
  /// **'先选品牌，再填写端点和密钥。'**
  String get modelProviderCatalogSubtitle;

  /// No description provided for @modelProviderSubtitle.
  ///
  /// In zh, this message translates to:
  /// **'管理端点、API Key 和默认模型。'**
  String get modelProviderSubtitle;

  /// No description provided for @modelProviderEndpoint.
  ///
  /// In zh, this message translates to:
  /// **'端点'**
  String get modelProviderEndpoint;

  /// No description provided for @modelProviderApiKey.
  ///
  /// In zh, this message translates to:
  /// **'API Key'**
  String get modelProviderApiKey;

  /// No description provided for @modelProviderDefaultModel.
  ///
  /// In zh, this message translates to:
  /// **'默认模型'**
  String get modelProviderDefaultModel;

  /// No description provided for @modelProviderModelCount.
  ///
  /// In zh, this message translates to:
  /// **'模型数量'**
  String get modelProviderModelCount;

  /// No description provided for @modelProviderLatency.
  ///
  /// In zh, this message translates to:
  /// **'延迟'**
  String get modelProviderLatency;

  /// No description provided for @modelProviderRouting.
  ///
  /// In zh, this message translates to:
  /// **'路由'**
  String get modelProviderRouting;

  /// No description provided for @modelProviderModelsTitle.
  ///
  /// In zh, this message translates to:
  /// **'模型列表'**
  String get modelProviderModelsTitle;

  /// No description provided for @modelProviderModelsSubtitle.
  ///
  /// In zh, this message translates to:
  /// **'按可用性和优先级排序。'**
  String get modelProviderModelsSubtitle;

  /// No description provided for @modelProviderViewModels.
  ///
  /// In zh, this message translates to:
  /// **'查看模型'**
  String get modelProviderViewModels;

  /// No description provided for @modelProviderAddProvider.
  ///
  /// In zh, this message translates to:
  /// **'添加提供商'**
  String get modelProviderAddProvider;

  /// No description provided for @modelProviderTestConnection.
  ///
  /// In zh, this message translates to:
  /// **'测试连接'**
  String get modelProviderTestConnection;

  /// No description provided for @modelProviderSave.
  ///
  /// In zh, this message translates to:
  /// **'保存配置'**
  String get modelProviderSave;

  /// No description provided for @modelProviderAvailable.
  ///
  /// In zh, this message translates to:
  /// **'可用'**
  String get modelProviderAvailable;

  /// No description provided for @modelProviderHealthy.
  ///
  /// In zh, this message translates to:
  /// **'正常'**
  String get modelProviderHealthy;

  /// No description provided for @modelProviderMissingKey.
  ///
  /// In zh, this message translates to:
  /// **'缺少密钥'**
  String get modelProviderMissingKey;

  /// No description provided for @modelProviderOffline.
  ///
  /// In zh, this message translates to:
  /// **'离线'**
  String get modelProviderOffline;

  /// No description provided for @modelProviderDegraded.
  ///
  /// In zh, this message translates to:
  /// **'异常'**
  String get modelProviderDegraded;

  /// No description provided for @modelProviderPrimary.
  ///
  /// In zh, this message translates to:
  /// **'主'**
  String get modelProviderPrimary;

  /// No description provided for @modelProviderRecommended.
  ///
  /// In zh, this message translates to:
  /// **'推荐'**
  String get modelProviderRecommended;

  /// No description provided for @modelProviderEnabled.
  ///
  /// In zh, this message translates to:
  /// **'已启用'**
  String get modelProviderEnabled;

  /// No description provided for @modelProviderFilterAll.
  ///
  /// In zh, this message translates to:
  /// **'全部'**
  String get modelProviderFilterAll;

  /// No description provided for @modelProviderFilterRecommended.
  ///
  /// In zh, this message translates to:
  /// **'推荐'**
  String get modelProviderFilterRecommended;

  /// No description provided for @modelProviderFilterEnabled.
  ///
  /// In zh, this message translates to:
  /// **'已启用'**
  String get modelProviderFilterEnabled;

  /// No description provided for @modelProviderConnectionSuccess.
  ///
  /// In zh, this message translates to:
  /// **'连接正常'**
  String get modelProviderConnectionSuccess;

  /// No description provided for @modelProviderConnectionFailed.
  ///
  /// In zh, this message translates to:
  /// **'连接失败'**
  String get modelProviderConnectionFailed;

  /// No description provided for @modelProviderHealthyCount.
  ///
  /// In zh, this message translates to:
  /// **'{count} 正常'**
  String modelProviderHealthyCount(Object count);

  /// No description provided for @modelProviderEnabledCount.
  ///
  /// In zh, this message translates to:
  /// **'{count} 已启用'**
  String modelProviderEnabledCount(Object count);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
