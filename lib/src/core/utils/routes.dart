import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:threads/src/features/auth/presentation/auth_screen.dart';
import 'package:threads/src/welcome_screen.dart';

/// The route configuration.
final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      name: 'home',
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const WelcomeScreen();
      },
      routes: <RouteBase>[
        GoRoute(
          name: 'auth',
          path: 'auth',
          builder: (BuildContext context, GoRouterState state) {
            bool isSignInScreen =
                state.uri.queryParameters['authType'] == 'signIn';
            return AuthScreen(isSignInScreen: isSignInScreen);
          },
        ),
      ],
    ),
  ],
);
