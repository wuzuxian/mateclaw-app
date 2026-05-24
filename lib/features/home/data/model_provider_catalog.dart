import 'package:flutter/material.dart';

enum ModelProviderKind {
  openai,
  anthropic,
  deepseek,
  dashscope,
  azureOpenAI,
  moonshot,
  openRouter,
  ollama,
}

enum ModelProviderStatus { healthy, missingKey, degraded, offline }

class ProviderModelRecord {
  const ProviderModelRecord({
    required this.name,
    required this.contextWindow,
    required this.recommended,
    required this.enabled,
  });

  final String name;
  final String contextWindow;
  final bool recommended;
  final bool enabled;
}

class ModelProviderRecord {
  const ModelProviderRecord({
    required this.id,
    required this.kind,
    required this.displayName,
    required this.endpoint,
    required this.status,
    required this.isPrimary,
    required this.isEnabled,
    required this.defaultModel,
    required this.modelCount,
    required this.latencyMs,
    required this.trafficShare,
    required this.models,
  });

  final String id;
  final ModelProviderKind kind;
  final String displayName;
  final String endpoint;
  final ModelProviderStatus status;
  final bool isPrimary;
  final bool isEnabled;
  final String defaultModel;
  final int modelCount;
  final int latencyMs;
  final String trafficShare;
  final List<ProviderModelRecord> models;
}

class ModelProviderCatalogEntry {
  const ModelProviderCatalogEntry({
    required this.id,
    required this.kind,
    required this.displayName,
  });

  final String id;
  final ModelProviderKind kind;
  final String displayName;
}

const modelProviderCatalogEntries = [
  ModelProviderCatalogEntry(
    id: 'openai',
    kind: ModelProviderKind.openai,
    displayName: 'OpenAI',
  ),
  ModelProviderCatalogEntry(
    id: 'anthropic',
    kind: ModelProviderKind.anthropic,
    displayName: 'Anthropic',
  ),
  ModelProviderCatalogEntry(
    id: 'deepseek',
    kind: ModelProviderKind.deepseek,
    displayName: 'DeepSeek',
  ),
  ModelProviderCatalogEntry(
    id: 'dashscope',
    kind: ModelProviderKind.dashscope,
    displayName: 'DashScope',
  ),
  ModelProviderCatalogEntry(
    id: 'azure-openai',
    kind: ModelProviderKind.azureOpenAI,
    displayName: 'Azure OpenAI',
  ),
  ModelProviderCatalogEntry(
    id: 'moonshot',
    kind: ModelProviderKind.moonshot,
    displayName: 'Moonshot',
  ),
  ModelProviderCatalogEntry(
    id: 'openrouter',
    kind: ModelProviderKind.openRouter,
    displayName: 'OpenRouter',
  ),
  ModelProviderCatalogEntry(
    id: 'ollama',
    kind: ModelProviderKind.ollama,
    displayName: 'Ollama',
  ),
];

const modelProviders = [
  ModelProviderRecord(
    id: 'openai',
    kind: ModelProviderKind.openai,
    displayName: 'OpenAI',
    endpoint: 'api.openai.com',
    status: ModelProviderStatus.healthy,
    isPrimary: true,
    isEnabled: true,
    defaultModel: 'gpt-4.1-mini',
    modelCount: 4,
    latencyMs: 118,
    trafficShare: '42%',
    models: [
      ProviderModelRecord(
        name: 'gpt-4.1-mini',
        contextWindow: '128K',
        recommended: true,
        enabled: true,
      ),
      ProviderModelRecord(
        name: 'gpt-4.1',
        contextWindow: '128K',
        recommended: false,
        enabled: true,
      ),
      ProviderModelRecord(
        name: 'o3-mini',
        contextWindow: '200K',
        recommended: false,
        enabled: false,
      ),
    ],
  ),
  ModelProviderRecord(
    id: 'deepseek',
    kind: ModelProviderKind.deepseek,
    displayName: 'DeepSeek',
    endpoint: 'api.deepseek.com',
    status: ModelProviderStatus.healthy,
    isPrimary: false,
    isEnabled: true,
    defaultModel: 'deepseek-v3',
    modelCount: 3,
    latencyMs: 92,
    trafficShare: '26%',
    models: [
      ProviderModelRecord(
        name: 'deepseek-v3',
        contextWindow: '128K',
        recommended: true,
        enabled: true,
      ),
      ProviderModelRecord(
        name: 'deepseek-r1',
        contextWindow: '64K',
        recommended: false,
        enabled: true,
      ),
      ProviderModelRecord(
        name: 'deepseek-coder',
        contextWindow: '64K',
        recommended: false,
        enabled: false,
      ),
    ],
  ),
  ModelProviderRecord(
    id: 'anthropic',
    kind: ModelProviderKind.anthropic,
    displayName: 'Anthropic',
    endpoint: 'api.anthropic.com',
    status: ModelProviderStatus.missingKey,
    isPrimary: false,
    isEnabled: false,
    defaultModel: 'claude-3.7-sonnet',
    modelCount: 2,
    latencyMs: 0,
    trafficShare: '0%',
    models: [
      ProviderModelRecord(
        name: 'claude-3.7-sonnet',
        contextWindow: '200K',
        recommended: true,
        enabled: false,
      ),
      ProviderModelRecord(
        name: 'claude-3.5-haiku',
        contextWindow: '200K',
        recommended: false,
        enabled: false,
      ),
    ],
  ),
  ModelProviderRecord(
    id: 'dashscope',
    kind: ModelProviderKind.dashscope,
    displayName: 'DashScope',
    endpoint: 'dashscope.aliyuncs.com',
    status: ModelProviderStatus.degraded,
    isPrimary: false,
    isEnabled: true,
    defaultModel: 'qwen-plus',
    modelCount: 4,
    latencyMs: 186,
    trafficShare: '18%',
    models: [
      ProviderModelRecord(
        name: 'qwen-plus',
        contextWindow: '32K',
        recommended: true,
        enabled: true,
      ),
      ProviderModelRecord(
        name: 'qwen-max',
        contextWindow: '32K',
        recommended: false,
        enabled: true,
      ),
      ProviderModelRecord(
        name: 'qwen-turbo',
        contextWindow: '32K',
        recommended: false,
        enabled: false,
      ),
    ],
  ),
  ModelProviderRecord(
    id: 'ollama',
    kind: ModelProviderKind.ollama,
    displayName: 'Ollama',
    endpoint: '10.0.2.2:11434',
    status: ModelProviderStatus.offline,
    isPrimary: false,
    isEnabled: false,
    defaultModel: 'llama3.1',
    modelCount: 2,
    latencyMs: 0,
    trafficShare: '14%',
    models: [
      ProviderModelRecord(
        name: 'llama3.1',
        contextWindow: '128K',
        recommended: true,
        enabled: false,
      ),
      ProviderModelRecord(
        name: 'qwen2.5',
        contextWindow: '32K',
        recommended: false,
        enabled: false,
      ),
    ],
  ),
];

ModelProviderRecord modelProviderById(String providerId) {
  return modelProviders.firstWhere(
    (provider) => provider.id == providerId,
    orElse: () => modelProviders.first,
  );
}

Color modelProviderColorForKind(ModelProviderKind kind) {
  return switch (kind) {
    ModelProviderKind.openai => const Color(0xFF007AFF),
    ModelProviderKind.anthropic => const Color(0xFFAF52DE),
    ModelProviderKind.deepseek => const Color(0xFF34C759),
    ModelProviderKind.dashscope => const Color(0xFFFF9500),
    ModelProviderKind.azureOpenAI => const Color(0xFF2563EB),
    ModelProviderKind.moonshot => const Color(0xFF8B5CF6),
    ModelProviderKind.openRouter => const Color(0xFF0F766E),
    ModelProviderKind.ollama => const Color(0xFFEF4444),
  };
}

IconData modelProviderIconForKind(ModelProviderKind kind) {
  return switch (kind) {
    ModelProviderKind.openai => Icons.auto_awesome,
    ModelProviderKind.anthropic => Icons.bolt_outlined,
    ModelProviderKind.deepseek => Icons.search_outlined,
    ModelProviderKind.dashscope => Icons.cloud_outlined,
    ModelProviderKind.azureOpenAI => Icons.cloud_circle_outlined,
    ModelProviderKind.moonshot => Icons.nightlight_round_outlined,
    ModelProviderKind.openRouter => Icons.alt_route_outlined,
    ModelProviderKind.ollama => Icons.memory_outlined,
  };
}
