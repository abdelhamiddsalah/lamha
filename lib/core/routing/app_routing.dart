import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lamha/core/routing/routes.dart';
import 'package:lamha/features/splash/presentation/pages/splash_view.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: Routes.splash,
    routes: [
      GoRoute(
        path: Routes.splash,
        builder: (context, state) => const SplashView(),
      ),
    ],
    errorBuilder:
        (context, state) => ErrorPage(routeName: state.uri.toString()),
  );
}

class ErrorPage extends StatelessWidget {
  final String? routeName;
  const ErrorPage({super.key, this.routeName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Error')),
      body: Center(child: Text('No route defined for $routeName')),
    );
  }
}