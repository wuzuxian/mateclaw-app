import 'package:go_router/go_router.dart';

import '../features/home/view/home_page.dart';
import 'app_routes.dart';

final appRouter = GoRouter(
  routes: [
    GoRoute(
      path: AppRoutes.home,
      builder: (context, state) => const HomePage(),
    ),
  ],
);
