/*import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lamha/core/routing/routes.dart';

class DeepLinkingService {
  final AppLinks _appLinks = AppLinks();
  static final DeepLinkingService _instance = DeepLinkingService._internal();
  
  // Singleton pattern
  factory DeepLinkingService() => _instance;
  
  DeepLinkingService._internal();
  
  Future<void> initialize(BuildContext context) async {
    // Handle initial link if app was opened from a deep link
    final initialLink = await _appLinks.getInitialLinkString();
    if (initialLink != null) {
      _handleDeepLink(initialLink, context);
    }

    // Listen for links while app is running
    _appLinks.uriLinkStream.listen((uri) {
      if (uri != null) {
        _handleDeepLink(uri.toString(), context);
      }
    });
  }

  void _handleDeepLink(String link, BuildContext context) {
    print("Received deep link: $link");
    Uri uri = Uri.parse(link);

    // Check if this is a Firebase Auth action link
    if (uri.path.contains('/__/auth/action')) {
      final mode = uri.queryParameters['mode'];
      final oobCode = uri.queryParameters['oobCode'];
      
      // Handle password reset
      if (mode == 'resetPassword' && oobCode != null) {
        print("Navigating to reset password with code: $oobCode");
        GoRouter.of(context).push(Routes.resetPassword, extra: oobCode);
      }
    }
  }
}*/

import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lamha/core/routing/routes.dart';

class DeepLinkingService {
  final AppLinks _appLinks = AppLinks();
  static final DeepLinkingService _instance = DeepLinkingService._internal();
  
  // Singleton pattern
  factory DeepLinkingService() => _instance;
  
  DeepLinkingService._internal();
  
  Future<void> initialize(BuildContext context) async {
    try {
      // Handle initial link if app was opened from a deep link
      final initialLink = await _appLinks.getInitialLinkString();
      if (initialLink != null) {
        print("Initial deep link: ${initialLink.toString()}");
        _handleDeepLink(Uri.parse(initialLink), context);
      }

      // Listen for links while app is running
      _appLinks.uriLinkStream.listen((uri) {
        if (uri != null) {
          print("Received deep link while running: ${uri.toString()}");
          _handleDeepLink(uri, context);
        }
      });
    } catch (e) {
      print("Error initializing deep links: $e");
    }
  }

  void _handleDeepLink(Uri uri, BuildContext context) {
    try {
      print("Processing deep link: $uri");
      print("Path: ${uri.path}");
      print("Query parameters: ${uri.queryParameters}");
      
      // Check if this is a Firebase Auth action link
      if (uri.path.contains('/__/auth/action')) {
        final mode = uri.queryParameters['mode'];
        final oobCode = uri.queryParameters['oobCode'];
        
        print("Firebase Auth action - Mode: $mode, Code: $oobCode");
        
        // Handle password reset
        if (mode == 'resetPassword' && oobCode != null) {
          // Instead of pushing a new route, let the router handle it directly
          if (context.mounted) {
            // Use replaceNamed to avoid stacking navigation
            context.go(Routes.resetPassword, extra: uri.queryParameters);
          }
          //'/__/auth/action'
        }
      }
    } catch (e) {
      print("Error handling deep link: $e");
    }
  }
}