/*import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lamha/core/routing/app_routing.dart';
import 'package:lamha/firebase_options.dart';
import 'package:lamha/getit.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  ScreenUtilInit(
  designSize: const Size(375, 812),
  builder: (context, child) {
    return Directionality( // <-- هنا
      textDirection: TextDirection.rtl,
      child: MaterialApp.router(
        title: 'LAMHA App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Cairo',
        ),
        locale: const Locale('ar', 'EG'),
        supportedLocales: const [
          Locale('en', 'US'),
          Locale('ar', 'EG'),
        ],
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        routerConfig: AppRouter.router,
      ),
    );
  },
);

  }
}*/
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lamha/core/routing/app_routing.dart';
import 'package:lamha/core/services/deep_linking_service.dart';
import 'package:lamha/firebase_options.dart';
import 'package:lamha/getit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final deepLinkingService = DeepLinkingService();
  
  @override
  void initState() {
    super.initState();
    // Initialize deep linking after the first frame is rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeDeepLinking();
    });
  }

  void _initializeDeepLinking() {
    if (mounted) {
      final BuildContext? context = AppRouter.navigatorKey.currentContext;
      if (context != null) {
        deepLinkingService.initialize(context);
      } else {
        // If context is not available yet, try again after a delay
        Future.delayed(const Duration(milliseconds: 500), _initializeDeepLinking);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (_, __) => MaterialApp.router(
        title: 'LAMHA App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Cairo',
        ),
        locale: const Locale('ar', 'EG'),
        supportedLocales: const [
          Locale('en', 'US'),
          Locale('ar', 'EG'),
        ],
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        routerConfig: AppRouter.router,
      ),
    );
  }
}