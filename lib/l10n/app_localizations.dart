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
