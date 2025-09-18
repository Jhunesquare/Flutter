import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'screens/home_screen.dart';
import 'screens/detail_screen.dart';
import 'screens/tabs_screen.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      name: 'home',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/detail/:id',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return DetailScreen(message: id);
      },
    ),
    GoRoute(
      path: '/tabs',
      name: 'tabs',
      builder: (context, state) => const TabsScreen(),
    ),
  ],
);
