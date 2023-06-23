import 'package:go_router/go_router.dart';

import 'home_page.dart';

final route = GoRouter(
  routes: [
    GoRoute(
      path: HomePage.routeName,
      builder: (context, state) {
        return const HomePage();
      },
    ),
  ],
);
