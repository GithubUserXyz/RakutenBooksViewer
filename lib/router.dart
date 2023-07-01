import 'package:go_router/go_router.dart';
import 'package:rakuten_books_viewer/page/search_page.dart';

import 'page/home_page.dart';

final route = GoRouter(
  routes: [
    GoRoute(
      path: HomePage.routeName,
      builder: (context, state) {
        return const HomePage();
      },
      routes: [
        GoRoute(
          name: SearchPage.screenName,
          path: SearchPage.routeName,
          builder: (context, state) {
            return const SearchPage();
          },
        )
      ],
    ),
  ],
);

/*
final route = GoRouter(
  routes: [
    GoRoute(
      path: SearchPage.routeName,
      builder: (context, state) {
        return const SearchPage();
      },
    ),
  ],
);
*/
