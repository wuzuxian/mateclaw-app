import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'core/network/api_client.dart';
import 'features/auth/data/auth_repository.dart';
import 'features/auth/data/auth_session_store.dart';
import 'features/auth/viewmodel/auth_session.dart';
import 'features/home/data/home_cache_store.dart';
import 'features/home/data/home_repository.dart';
import 'l10n/app_localizations.dart';
import 'routing/app_router.dart';

class MateclawApp extends StatefulWidget {
  const MateclawApp({super.key, this.authSessionStore});

  final AuthSessionStore? authSessionStore;

  @override
  State<MateclawApp> createState() => _MateclawAppState();
}

class _MateclawAppState extends State<MateclawApp> {
  late final AuthSession _authSession;
  late final ApiClient _apiClient = ApiClient(
    authorizationTokenProvider: () => _authSession.token,
  );
  late final AuthRepository _authRepository = AuthRepository(
    apiClient: _apiClient,
  );
  late final HomeRepository _homeRepository = HomeRepository(
    apiClient: _apiClient,
    cacheStore: const HomeCacheStore(),
    userIdProvider: () => _authSession.user?.id,
  );
  late final _router = createAppRouter(_authSession);
  late final Future<void> _restoreSession;

  @override
  void initState() {
    super.initState();
    _authSession = AuthSession(
      store: widget.authSessionStore ?? SqfliteAuthSessionStore(),
    );
    _restoreSession = _authSession.restore();
  }

  @override
  void dispose() {
    _router.dispose();
    _authSession.dispose();
    _apiClient.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _restoreSession,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return MaterialApp(
            title: 'Mateclaw',
            theme: _theme,
            home: const _SessionBootstrapPage(),
          );
        }

        return MultiProvider(
          providers: [
            Provider<ApiClient>.value(value: _apiClient),
            Provider<AuthRepository>.value(value: _authRepository),
            Provider<HomeRepository>.value(value: _homeRepository),
            ChangeNotifierProvider<AuthSession>.value(value: _authSession),
          ],
          child: MaterialApp.router(
            title: 'Mateclaw',
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: AppLocalizations.supportedLocales,
            routerConfig: _router,
            theme: _theme,
          ),
        );
      },
    );
  }

  ThemeData get _theme {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF007AFF)),
      fontFamily: 'SF Pro Display',
      useMaterial3: true,
    );
  }
}

class _SessionBootstrapPage extends StatelessWidget {
  const _SessionBootstrapPage();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFFF5F5F7),
      body: Center(
        child: SizedBox(
          width: 28,
          height: 28,
          child: CircularProgressIndicator(strokeWidth: 2.4),
        ),
      ),
    );
  }
}
