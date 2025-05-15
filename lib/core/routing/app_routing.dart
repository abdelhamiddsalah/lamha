import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lamha/core/routing/routes.dart';
import 'package:lamha/features/home/presentation/pages/bottom_nav.dart';
import 'package:lamha/features/onboarding/presentation/pages/onboarding_view.dart';
import 'package:lamha/features/authintecation/presentation/screens/forget_password_view.dart';
import 'package:lamha/features/authintecation/presentation/screens/login_view.dart';
import 'package:lamha/features/authintecation/presentation/screens/reset_password_view.dart';
import 'package:lamha/features/authintecation/presentation/screens/signup_view.dart';
class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: Routes.splash,
    routes: [
      GoRoute(
        path: Routes.splash,
        builder: (context, state) => const BottomNav(),
      ),
      GoRoute(
        path: Routes.login,
        builder: (context, state) => const LoginView(),
      ),
      GoRoute(
        path: Routes.register,
        builder: (context, state) => const SignupView(),
      ),
      GoRoute(
        path: Routes.forgetPassword,
        builder: (context, state) => const ForgetPasswordView(),
      ),
      GoRoute(
        path: Routes.resetPassword,
        builder: (context, state) => const ResetPasswordView(),
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