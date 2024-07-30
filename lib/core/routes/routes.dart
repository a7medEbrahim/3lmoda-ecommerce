import 'package:almoda/core/service/cache_helper.dart';
import 'package:almoda/root_page.dart';
import 'package:almoda/screens/auth/login/login.dart';
import 'package:almoda/screens/auth/singnup/signup.dart';
import 'package:almoda/screens/navigator_page.dart';
import 'package:almoda/screens/taps/categories/categoryies.dart';
import 'package:almoda/screens/taps/home/home.dart';
import 'package:almoda/screens/taps/profile/profile.dart';
import 'package:almoda/screens/taps/wishlist/wishlist.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RoutesName {
  static const String root = "/";
  static const String login = "login";
  static const String registration = "registration";
  static const String home = "home";
  static const String categories = "categories";
  static const String profile = "profile";
  static const String wishlist = "wishlist";
}

class AppRoutes {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _shellNavigatorHomeKey =
      GlobalKey<NavigatorState>(debugLabel: 'shellHome');
  static final _shellNavigatorCategoryKey =
      GlobalKey<NavigatorState>(debugLabel: 'shellCategory');
  static final _shellNavigatorWishlistKey =
      GlobalKey<NavigatorState>(debugLabel: 'shellWishlist');
  static final _shellNavigatorProfileKey =
      GlobalKey<NavigatorState>(debugLabel: 'shellProfile');
  static GoRouter router = GoRouter(
    initialLocation: '/',
    navigatorKey: _rootNavigatorKey,
    redirect: (context, state) {
      final userResponse = CacheHelper.getData('userResponse');
      final loggingIn = (state.fullPath ?? '').startsWith('/login');

      if (userResponse == null && !loggingIn) {
        return '/login';
      }
      if (userResponse != null && loggingIn) {
        return '/home';
      }
      return null;
    },
    routes: [
      GoRoute(
        path: '/',
        name: RoutesName.root,
        builder: (context, state) => const RootApp(),
      ),
      GoRoute(
        path: '/login',
        name: RoutesName.login,
        builder: (context, state) => const Login(),
        routes: [
          GoRoute(
            path: 'registration',
            name: RoutesName.registration,
            builder: (context, state) => const Signup(),
          ),
        ],
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return NavigatorPage(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(navigatorKey: _shellNavigatorHomeKey, routes: [
            GoRoute(
              path: '/home',
              name: RoutesName.home,
              builder: (context, state) => const Home(),
            ),
          ]),
          StatefulShellBranch(
              navigatorKey: _shellNavigatorCategoryKey,
              routes: [
                GoRoute(
                  path: '/categories',
                  name: RoutesName.categories,
                  builder: (context, state) => const Categories(),
                ),
              ]),
          StatefulShellBranch(
              navigatorKey: _shellNavigatorWishlistKey,
              routes: [
                GoRoute(
                  path: '/wishlist',
                  name: RoutesName.wishlist,
                  builder: (context, state) => const Wishlist(),
                ),
              ]),
          StatefulShellBranch(navigatorKey: _shellNavigatorProfileKey, routes: [
            GoRoute(
              path: '/profile',
              name: RoutesName.profile,
              builder: (context, state) => const Profile(),
            ),
          ]),
        ],
      ),
      // Add more routes here if needed
    ],
  );
}
