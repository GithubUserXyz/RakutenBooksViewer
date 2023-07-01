import 'package:go_router/go_router.dart';

import 'page/home_page.dart';

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
