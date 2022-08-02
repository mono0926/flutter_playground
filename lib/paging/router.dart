import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'api_users_page.dart';
import 'home_page.dart';
import 'users_page.dart';

final routerProvider = Provider(
  (ref) => GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (_, __) => const HomePage(),
        routes: [
          GoRoute(
            path: 'users',
            builder: (_, __) => const UsersPage(),
          ),
          GoRoute(
            path: 'api_users',
            builder: (_, __) => const ApiUsersPage(),
          ),
        ],
      ),
    ],
  ),
);
