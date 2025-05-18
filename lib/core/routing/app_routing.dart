import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lamha/core/routing/routes.dart';
import 'package:lamha/features/home/presentation/pages/bottom_nav.dart';
import 'package:lamha/features/authintecation/presentation/screens/forget_password_view.dart';
import 'package:lamha/features/authintecation/presentation/screens/login_view.dart';
import 'package:lamha/features/authintecation/presentation/screens/reset_password_view.dart';
import 'package:lamha/features/authintecation/presentation/screens/signup_view.dart';
import 'package:lamha/features/authintecation/presentation/widgets/send_email.dart';
class AppRouter {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static final GoRouter router = GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: Routes.signup,
    routes: [
      GoRoute(
        path: Routes.signup,
        builder: (context, state) => const SignupView(),
      ),
        GoRoute(
 path: Routes.splash,
        builder: (context, state) => const BottomNav(),
        ),
       
  
      GoRoute(
        path: Routes.login,
        builder: (context, state) => const LoginView(),
      ),
      GoRoute(
        path: Routes.sendemail,
        builder: (context, state) => const SendEmail(),
      ),
      GoRoute(
        path: Routes.forgetPassword,
        builder: (context, state) => const ForgetPasswordView(),
      ),
      GoRoute(
        path: Routes.resetPassword,
        name: Routes.resetPassword,
        builder: (context, state) {
          // Get oobCode from state.extra or from query parameters
          final String? oobCode = state.extra is String 
              ? state.extra as String
              : state.uri.queryParameters['oobCode'];
          return ResetPasswordView(oobCode: oobCode);
        },
      ),
      // Add a route for handling Firebase Auth deep links directly
      GoRoute(
        path: '/__/auth/action',
        builder: (context, state) {
          final mode = state.uri.queryParameters['mode'];
          final oobCode = state.uri.queryParameters['oobCode'];
          
          // Handle password reset
          if (mode == 'resetPassword' && oobCode != null) {
            return ResetPasswordView(oobCode: oobCode);
          }
          
          // Default to signup if no specific action is matched
          return const SignupView();
        },
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