import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../features/auth/data/auth_repository.dart';
import '../features/auth/view/login_page.dart';
import '../features/auth/viewmodel/auth_session.dart';
import '../features/auth/viewmodel/login_view_model.dart';
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
import '../features/home/data/home_repository.dart';
import '../features/home/viewmodel/home_view_model.dart';
import 'app_routes.dart';

GoRouter createAppRouter(AuthSession authSession) {
  return GoRouter(
    initialLocation: AppRoutes.login,
    refreshListenable: authSession,
    redirect: (context, state) {
      if (!authSession.isInitialized) {
        return null;
      }

      final isLoggingIn = state.matchedLocation == AppRoutes.login;
      final isAuthenticated = authSession.isAuthenticated;

      if (!isAuthenticated && !isLoggingIn) {
        return AppRoutes.login;
      }
      if (isAuthenticated && isLoggingIn) {
        return AppRoutes.home;
      }

      return null;
    },
    routes: [
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) {
          return ChangeNotifierProvider(
            create: (context) => LoginViewModel(
              authRepository: context.read<AuthRepository>(),
              authSession: context.read<AuthSession>(),
            ),
            child: const LoginPage(),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.home,
        builder: (context, state) {
          return ChangeNotifierProvider(
            create: (context) =>
                HomeViewModel(repository: context.read<HomeRepository>()),
            child: const HomePage(),
          );
        },
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
}
