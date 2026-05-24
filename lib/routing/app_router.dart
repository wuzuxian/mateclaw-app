import 'package:go_router/go_router.dart';

import '../features/auth/view/login_page.dart';
import '../features/chat/view/chat_detail_page.dart';
import '../features/chat/view/chat_list_page.dart';
import '../features/home/view/agent_page.dart';
import '../features/home/view/home_page.dart';
import '../features/home/view/model_provider_catalog_page.dart';
import '../features/home/view/model_provider_detail_page.dart';
import '../features/home/view/model_provider_models_page.dart';
import '../features/home/view/model_providers_page.dart';
import '../features/home/view/knowledge_page.dart';
import '../features/home/view/settings_page.dart';
import 'app_routes.dart';

final appRouter = GoRouter(
  initialLocation: AppRoutes.login,
  routes: [
    GoRoute(
      path: AppRoutes.login,
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: AppRoutes.home,
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: AppRoutes.chat,
      builder: (context, state) => const ChatListPage(),
    ),
    GoRoute(
      path: AppRoutes.chatDetail,
      builder: (context, state) => const ChatDetailPage(),
    ),
    GoRoute(
      path: AppRoutes.agent,
      builder: (context, state) => const AgentPage(),
    ),
    GoRoute(
      path: AppRoutes.knowledge,
      builder: (context, state) => const KnowledgePage(),
    ),
    GoRoute(
      path: AppRoutes.settings,
      builder: (context, state) => const SettingsPage(),
    ),
    GoRoute(
      path: AppRoutes.settingsModelProviders,
      builder: (context, state) => const ModelProvidersPage(),
    ),
    GoRoute(
      path: AppRoutes.settingsModelProvidersCatalog,
      builder: (context, state) => const ModelProviderCatalogPage(),
    ),
    GoRoute(
      path: '${AppRoutes.settingsModelProviders}/:providerId',
      builder: (context, state) {
        final providerId = state.pathParameters['providerId'];
        return ModelProviderDetailPage(providerId: providerId ?? 'openai');
      },
    ),
    GoRoute(
      path: '${AppRoutes.settingsModelProviders}/:providerId/models',
      builder: (context, state) {
        final providerId = state.pathParameters['providerId'];
        return ModelProviderModelsPage(providerId: providerId ?? 'openai');
      },
    ),
  ],
);
