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
  String get loginButtonLoading => 'Logging in...';

  @override
  String get loginUsernameRequired => 'Enter username';

  @override
  String get loginPasswordRequired => 'Enter password';

  @override
  String get loginInvalidCredentials => 'Incorrect username or password';

  @override
  String get loginRateLimited => 'Too many attempts. Try again later.';

  @override
  String get loginNetworkError =>
      'Cannot reach the server. Check the network or backend service.';

  @override
  String get loginServerError => 'Login failed. Try again later.';

  @override
  String get loginInvalidResponse => 'Unexpected server response.';

  @override
  String get loginUnknownError => 'Login failed. Try again.';

  @override
  String get loginTogglePasswordVisibility => 'Toggle password visibility';

  @override
  String get loginToggleAgreement => 'Toggle agreement consent';

  @override
  String get homeBrand => 'MateClaw';

  @override
  String get homeTitle => 'Workspace';

  @override
  String get homeAvatarInitial => 'Wu';

  @override
  String get homeTodayConversations => 'Today\'s chats';

  @override
  String get homeHealth => 'Healthy';

  @override
  String get homeTodayCount => '128';

  @override
  String get homeTodayMeta => '1,842 messages · 43 tool calls';

  @override
  String get homeNewChat => 'New chat';

  @override
  String get homeAgent => 'Agent';

  @override
  String get homeApproval => 'Approvals';

  @override
  String get homePeriodTitle => 'Period comparison';

  @override
  String get homePeriodSubtitle =>
      'Track system activity across day, week, and month.';

  @override
  String get homePeriodToday => 'Today';

  @override
  String get homePeriodWeek => 'This week';

  @override
  String get homePeriodMonth => 'This month';

  @override
  String get homePeriodConversations => 'Chats';

  @override
  String get homePeriodMessages => 'Messages';

  @override
  String get homePeriodTokens => 'Token';

  @override
  String get homePeriodTools => 'Tools';

  @override
  String get homePeriodZeroValue => '0';

  @override
  String get homeRecentRuns => 'Recent runs';

  @override
  String get homeDailySummaryTask => 'Daily summary task';

  @override
  String get homeDailySummaryMeta => 'Success · 2 min ago · 12.4k tokens';

  @override
  String get homeContractAgent => 'Contract review Agent';

  @override
  String get homeContractAgentMeta => 'Running · Lark channel · 3 steps';

  @override
  String get homeCurrentModel => 'Current model';

  @override
  String get homeModelName => 'OpenAI · GPT-4.1';

  @override
  String get homeModelReady => 'Ready';

  @override
  String get homeModelUnavailable => 'No model configured';

  @override
  String get homeNoRecentRuns => 'No recent runs';

  @override
  String get homeRetry => 'Retry';

  @override
  String get homeLoadErrorNetwork => 'Network error. Showing cached data.';

  @override
  String get homeLoadErrorUnauthorized => 'Session expired. Sign in again.';

  @override
  String get homeLoadErrorForbidden => 'No access to this workspace.';

  @override
  String get homeLoadErrorServer => 'Failed to load home data.';

  @override
  String get homeLoadErrorInvalidResponse => 'Unexpected home data format.';

  @override
  String get homeLoadErrorUnknown => 'Failed to load home data.';

  @override
  String get homeTabOverview => 'Overview';

  @override
  String get homeTabChat => 'Chat';

  @override
  String get homeTabAgent => 'Agent';

  @override
  String get homeTabKnowledge => 'Knowledge';

  @override
  String get homeTabSettings => 'Settings';

  @override
  String get chatKicker => 'Chat';

  @override
  String get chatTitle => 'Chat';

  @override
  String get chatSearchHint => 'Search chats, Agents, or channels';

  @override
  String get chatNewConversation => 'New conversation';

  @override
  String get chatNewConversationSubtitle =>
      'Choose an Agent and start a new task';

  @override
  String get chatRecentConversations => 'Recent conversations';

  @override
  String get chatRecentCount => '24';

  @override
  String get chatContractAgent => 'Contract review Agent';

  @override
  String get chatContractTime => '09:32';

  @override
  String get chatContractPreview =>
      'Found 3 high-risk points. Add acceptance criteria first...';

  @override
  String get chatContractStatus => 'Tool complete';

  @override
  String get chatContractMessageCount => '12 messages';

  @override
  String get chatDataAgent => 'Data analysis Agent';

  @override
  String get chatDataTime => 'Yesterday';

  @override
  String get chatDataPreview =>
      'Generated this week\'s operating summary and anomaly notes.';

  @override
  String get chatDataMeta => '8 messages · MySQL source';

  @override
  String get chatSupportAgent => 'Support assistant Agent';

  @override
  String get chatSupportTime => 'Tue';

  @override
  String get chatSupportPreview =>
      'Customer asked about refund progress; ticket status synced.';

  @override
  String get chatSupportMeta => 'WeChat channel · 5 messages';

  @override
  String get chatDailyTask => 'Daily summary task';

  @override
  String get chatDailyPreview => 'Cron triggered · Completed';

  @override
  String get chatDetailMeta => 'ReAct · Online · GPT-4.1';

  @override
  String get chatDetailTimestamp => 'Today 09:32';

  @override
  String get chatUserMessage =>
      'Please review this purchase contract, especially payment terms and liability.';

  @override
  String get chatBotMessage =>
      'Initial review complete. Found 3 high-risk points. Add acceptance criteria first, then adjust the grace period for overdue payments.';

  @override
  String get chatRiskPayment => 'High risk · Payment milestones unclear';

  @override
  String get chatRiskLiability => 'Medium risk · Penalty cap missing';

  @override
  String get chatToolComplete => 'Tool call complete';

  @override
  String get chatToolMeta => 'Contract parser · Legal knowledge base · 1.8s';

  @override
  String get chatInputHint => 'Type a message or upload a file';

  @override
  String get agentKicker => 'Agent';

  @override
  String get agentTitle => 'Team';

  @override
  String get agentSegmentMembers => 'Members';

  @override
  String get agentSegmentLive => 'Live';

  @override
  String get agentContractName => 'Contract review Agent';

  @override
  String get agentContractDescription =>
      'Contract risk detection, clause suggestions, approval summaries';

  @override
  String get agentOnline => 'Online';

  @override
  String get agentContractTools => '6 tools';

  @override
  String get agentDataName => 'Data analysis Agent';

  @override
  String get agentDataDescription =>
      'Connect data sources and generate operating insights';

  @override
  String get agentDataState => 'Idle · 3 tools · MySQL';

  @override
  String get agentSupportName => 'Support assistant Agent';

  @override
  String get agentSupportDescription =>
      'Channel messages, FAQ, escalation tickets';

  @override
  String get agentSupportState => 'Running · WeChat channel · 18 chats';

  @override
  String get agentLiveTitle => 'Live runs';

  @override
  String get agentLiveAttention => '2 need attention';

  @override
  String get agentLiveRunningCount => '12';

  @override
  String get agentLiveRunningLabel => 'Running';

  @override
  String get agentLiveBlockedCount => '3';

  @override
  String get agentLiveBlockedLabel => 'Blocked';

  @override
  String get knowledgeKicker => 'Knowledge';

  @override
  String get knowledgeTitle => 'Knowledge & Memory';

  @override
  String get knowledgeSearchHint =>
      'Search knowledge bases, memories, and docs';

  @override
  String get knowledgeBaseCount => '12';

  @override
  String get knowledgeBasesLabel => 'Knowledge bases';

  @override
  String get knowledgeMemoryCount => '4.8k';

  @override
  String get knowledgeMemoryLabel => 'Memory items';

  @override
  String get knowledgeBasesTitle => 'Knowledge bases';

  @override
  String get knowledgeLegalLibrary => 'Legal contract library';

  @override
  String get knowledgeLegalMeta => '326 docs · 2 Agents connected';

  @override
  String get knowledgeProductFaq => 'Product FAQ';

  @override
  String get knowledgeProductMeta => '1,240 chunks · Updated yesterday';

  @override
  String get knowledgeRecentMemory => 'Recent memory';

  @override
  String get knowledgeMemoryPreference =>
      'Customer preference: reply in Chinese first';

  @override
  String get knowledgeMemoryMeta => 'Support assistant Agent · Auto captured';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get settingsWorkspaceRole => 'Default workspace · Admin';

  @override
  String get settingsHealthTitle => 'System health';

  @override
  String get settingsHealthMeta => 'API, queue, and model services are normal';

  @override
  String get settingsHealthBadge => 'Healthy';

  @override
  String get settingsCommonConfig => 'Common settings';

  @override
  String get settingsModelProviders => 'Model providers';

  @override
  String get settingsModelProvidersMeta => '8/10 configured';

  @override
  String get settingsMcpTools => 'MCP & tools';

  @override
  String get settingsMcpToolsMeta => '24 tools';

  @override
  String get settingsChannelConnections => 'Channel connections';

  @override
  String get settingsChannelConnectionsMeta => 'Lark, WeChat';

  @override
  String get settingsSecurity => 'Security';

  @override
  String get settingsPendingActions => 'Pending approvals';

  @override
  String get settingsPendingCount => '3';

  @override
  String get settingsApprovalDescription =>
      'High-risk tools, file access, and commands require unified approval.';

  @override
  String get settingsApprovalQueue => 'View approval queue';

  @override
  String get settingsWorkspaceSettings => 'Workspace settings';

  @override
  String get settingsDefaultWorkspace => 'Default workspace';

  @override
  String get settingsWorkspaceMeta =>
      'Isolate Agents, knowledge bases, channels, and model permissions';

  @override
  String get settingsMembersChip => '6 members';

  @override
  String get settingsRolesChip => '4 roles';

  @override
  String get settingsAgentsChip => '12 Agents';

  @override
  String get settingsConfigureWorkspace => 'Configure workspace';

  @override
  String get settingsSwitchWorkspace => 'Switch';

  @override
  String get settingsLogoutTitle => 'Sign out';

  @override
  String get settingsLogoutMeta => 'Clear local session and return to sign-in';

  @override
  String get modelProvidersSubtitle =>
      'Manage providers, models, and routing in one place.';

  @override
  String get modelProviderCatalogTitle => 'Choose provider type';

  @override
  String get modelProviderCatalogSubtitle =>
      'Pick a brand first, then fill in endpoint and key.';

  @override
  String get modelProviderSubtitle =>
      'Manage endpoint, API key, and default model.';

  @override
  String get modelProviderEndpoint => 'Endpoint';

  @override
  String get modelProviderApiKey => 'API key';

  @override
  String get modelProviderDefaultModel => 'Default model';

  @override
  String get modelProviderModelCount => 'Models';

  @override
  String get modelProviderLatency => 'Latency';

  @override
  String get modelProviderRouting => 'Routing';

  @override
  String get modelProviderModelsTitle => 'Model list';

  @override
  String get modelProviderModelsSubtitle =>
      'Sorted by availability and priority.';

  @override
  String get modelProviderViewModels => 'View models';

  @override
  String get modelProviderAddProvider => 'Add provider';

  @override
  String get modelProviderTestConnection => 'Test connection';

  @override
  String get modelProviderSave => 'Save changes';

  @override
  String get modelProviderAvailable => 'Available';

  @override
  String get modelProviderHealthy => 'Healthy';

  @override
  String get modelProviderMissingKey => 'Missing key';

  @override
  String get modelProviderOffline => 'Offline';

  @override
  String get modelProviderDegraded => 'Degraded';

  @override
  String get modelProviderPrimary => 'Primary';

  @override
  String get modelProviderRecommended => 'Recommended';

  @override
  String get modelProviderEnabled => 'Enabled';

  @override
  String get modelProviderFilterAll => 'All';

  @override
  String get modelProviderFilterRecommended => 'Recommended';

  @override
  String get modelProviderFilterEnabled => 'Enabled';

  @override
  String get modelProviderConnectionSuccess => 'Connection verified';

  @override
  String get modelProviderConnectionFailed => 'Connection failed';

  @override
  String modelProviderHealthyCount(Object count) {
    return '$count Healthy';
  }

  @override
  String modelProviderEnabledCount(Object count) {
    return '$count Enabled';
  }
}
