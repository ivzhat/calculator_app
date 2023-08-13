import 'package:calculator_app/scaffold_with_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'feature/calculator/ui/calculator_page.dart';
import 'feature/calculator/ui/diagram_page.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  routes: [
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      pageBuilder: (context, state, child) {
        return NoTransitionPage(
            child: ScaffoldWithNavBar(
              location: state.uri.toString(),
              child: child,
            )
        );
      },
      routes: [
        GoRoute(
          parentNavigatorKey: _shellNavigatorKey,
          path: '/',
          pageBuilder: (context, state) {
            return NoTransitionPage(
              child: Scaffold(
                appBar: AppBar(
                    title: const Text('Калькулятор')
                ),
                body: CalculatorPage(),
              ),
            );
          }
        ),
        GoRoute(
          parentNavigatorKey: _shellNavigatorKey,
          path: '/diagram',
          pageBuilder: (context, state) {
            return NoTransitionPage(
              child: Scaffold(
                appBar: AppBar(
                    title: const Text('Диаграмма')
                ),
                body: const DiagramPage(),
              ),
            );
          }
        ),
      ],
    )
  ],
);