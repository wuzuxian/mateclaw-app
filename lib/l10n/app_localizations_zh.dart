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
  String get loginButtonLoading => '登录中...';

  @override
  String get loginUsernameRequired => '请输入用户名';

  @override
  String get loginPasswordRequired => '请输入密码';

  @override
  String get loginInvalidCredentials => '用户名或密码错误';

  @override
  String get loginRateLimited => '尝试次数过多，请稍后再试';

  @override
  String get loginNetworkError => '无法连接服务器，请检查网络或后端服务';

  @override
  String get loginServerError => '登录失败，请稍后再试';

  @override
  String get loginInvalidResponse => '服务器返回数据异常';

  @override
  String get loginUnknownError => '登录失败，请重试';

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
  String get homePeriodTitle => '周期对比';

  @override
  String get homePeriodSubtitle => '从日、周、月三个维度观察系统运行状况。';

  @override
  String get homePeriodToday => '今日';

  @override
  String get homePeriodWeek => '本周';

  @override
  String get homePeriodMonth => '本月';

  @override
  String get homePeriodConversations => '对话数';

  @override
  String get homePeriodMessages => '消息数';

  @override
  String get homePeriodTokens => 'Token';

  @override
  String get homePeriodTools => '工具';

  @override
  String get homePeriodZeroValue => '0';

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
  String get homeModelUnavailable => '未配置模型';

  @override
  String get homeNoRecentRuns => '暂无运行记录';

  @override
  String get homeRetry => '重试';

  @override
  String get homeLoadErrorNetwork => '网络异常，正在展示缓存数据';

  @override
  String get homeLoadErrorUnauthorized => '登录已失效，请重新登录';

  @override
  String get homeLoadErrorForbidden => '无权访问当前工作空间';

  @override
  String get homeLoadErrorServer => '首页数据加载失败';

  @override
  String get homeLoadErrorInvalidResponse => '首页数据格式异常';

  @override
  String get homeLoadErrorUnknown => '首页数据加载失败';

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

  @override
  String get agentKicker => 'Agent';

  @override
  String get agentTitle => '团队';

  @override
  String get agentSegmentMembers => '成员';

  @override
  String get agentSegmentLive => 'Live';

  @override
  String get agentContractName => '合同审查 Agent';

  @override
  String get agentContractDescription => '合同风险识别、条款建议、审批摘要';

  @override
  String get agentOnline => '在线';

  @override
  String get agentContractTools => '6 工具';

  @override
  String get agentDataName => '数据分析 Agent';

  @override
  String get agentDataDescription => '连接数据源并生成经营洞察';

  @override
  String get agentDataState => '空闲 · 3 工具 · MySQL';

  @override
  String get agentSupportName => '客服助理 Agent';

  @override
  String get agentSupportDescription => '渠道消息、FAQ、升级工单';

  @override
  String get agentSupportState => '运行中 · 微信渠道 · 18 会话';

  @override
  String get agentLiveTitle => 'Live 运行态';

  @override
  String get agentLiveAttention => '2 需关注';

  @override
  String get agentLiveRunningCount => '12';

  @override
  String get agentLiveRunningLabel => '运行中';

  @override
  String get agentLiveBlockedCount => '3';

  @override
  String get agentLiveBlockedLabel => '卡住';

  @override
  String get knowledgeKicker => 'Knowledge';

  @override
  String get knowledgeTitle => '知识与记忆';

  @override
  String get knowledgeSearchHint => '搜索知识库、记忆和文档';

  @override
  String get knowledgeBaseCount => '12';

  @override
  String get knowledgeBasesLabel => '知识库';

  @override
  String get knowledgeMemoryCount => '4.8k';

  @override
  String get knowledgeMemoryLabel => '记忆条目';

  @override
  String get knowledgeBasesTitle => '知识库';

  @override
  String get knowledgeLegalLibrary => '法务合同库';

  @override
  String get knowledgeLegalMeta => '326 文档 · 绑定 2 个 Agent';

  @override
  String get knowledgeProductFaq => '产品 FAQ';

  @override
  String get knowledgeProductMeta => '1,240 片段 · 昨天更新';

  @override
  String get knowledgeRecentMemory => '近期记忆';

  @override
  String get knowledgeMemoryPreference => '客户偏好：优先中文回复';

  @override
  String get knowledgeMemoryMeta => '客服助理 Agent · 自动沉淀';

  @override
  String get settingsTitle => '设置';

  @override
  String get settingsWorkspaceRole => '默认工作区 · 管理员';

  @override
  String get settingsHealthTitle => '系统健康';

  @override
  String get settingsHealthMeta => 'API、队列、模型服务均正常';

  @override
  String get settingsHealthBadge => 'Healthy';

  @override
  String get settingsCommonConfig => '常用配置';

  @override
  String get settingsModelProviders => '模型提供商';

  @override
  String get settingsModelProvidersMeta => '8/10 已配置';

  @override
  String get settingsMcpTools => 'MCP 与工具';

  @override
  String get settingsMcpToolsMeta => '24 工具';

  @override
  String get settingsChannelConnections => '渠道连接';

  @override
  String get settingsChannelConnectionsMeta => '飞书、微信';

  @override
  String get settingsSecurity => '安全';

  @override
  String get settingsPendingActions => '待审批动作';

  @override
  String get settingsPendingCount => '3';

  @override
  String get settingsApprovalDescription => '高风险工具、文件访问和命令统一审批。';

  @override
  String get settingsApprovalQueue => '查看审批队列';

  @override
  String get settingsWorkspaceSettings => '工作区设置';

  @override
  String get settingsDefaultWorkspace => '默认工作区';

  @override
  String get settingsWorkspaceMeta => '独立隔离 Agent、知识库、渠道与模型权限';

  @override
  String get settingsMembersChip => '6 成员';

  @override
  String get settingsRolesChip => '4 角色';

  @override
  String get settingsAgentsChip => '12 Agent';

  @override
  String get settingsConfigureWorkspace => '设置工作区';

  @override
  String get settingsSwitchWorkspace => '切换';

  @override
  String get modelProvidersSubtitle => '统一管理供应商、模型和路由';

  @override
  String get modelProviderCatalogTitle => '选择提供商类型';

  @override
  String get modelProviderCatalogSubtitle => '先选品牌，再填写端点和密钥。';

  @override
  String get modelProviderSubtitle => '管理端点、API Key 和默认模型。';

  @override
  String get modelProviderEndpoint => '端点';

  @override
  String get modelProviderApiKey => 'API Key';

  @override
  String get modelProviderDefaultModel => '默认模型';

  @override
  String get modelProviderModelCount => '模型数量';

  @override
  String get modelProviderLatency => '延迟';

  @override
  String get modelProviderRouting => '路由';

  @override
  String get modelProviderModelsTitle => '模型列表';

  @override
  String get modelProviderModelsSubtitle => '按可用性和优先级排序。';

  @override
  String get modelProviderViewModels => '查看模型';

  @override
  String get modelProviderAddProvider => '添加提供商';

  @override
  String get modelProviderTestConnection => '测试连接';

  @override
  String get modelProviderSave => '保存配置';

  @override
  String get modelProviderAvailable => '可用';

  @override
  String get modelProviderHealthy => '正常';

  @override
  String get modelProviderMissingKey => '缺少密钥';

  @override
  String get modelProviderOffline => '离线';

  @override
  String get modelProviderDegraded => '异常';

  @override
  String get modelProviderPrimary => '主';

  @override
  String get modelProviderRecommended => '推荐';

  @override
  String get modelProviderEnabled => '已启用';

  @override
  String get modelProviderFilterAll => '全部';

  @override
  String get modelProviderFilterRecommended => '推荐';

  @override
  String get modelProviderFilterEnabled => '已启用';

  @override
  String get modelProviderConnectionSuccess => '连接正常';

  @override
  String get modelProviderConnectionFailed => '连接失败';

  @override
  String modelProviderHealthyCount(Object count) {
    return '$count 正常';
  }

  @override
  String modelProviderEnabledCount(Object count) {
    return '$count 已启用';
  }
}
