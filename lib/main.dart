import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nitoons/firebase_options.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'UI Actor/splashscreen/splash_screen.dart';
import 'constants/theme.dart';
import 'router.dart';
import 'locator.dart';

final navigatorKeyProvider = Provider<GlobalKey<NavigatorState>>((ref) {
  return GlobalKey<NavigatorState>();
});

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // await FirebaseMessaging.instance.setAutoInitEnabled(true);

  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  try {
    await setupLocator();

    runApp(ProviderScope(
      child: Nitoons(
        appTheme: AppTheme(),
      ),
    ));
  } catch (error) {
    (error);
  }
}

// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   await Firebase.initializeApp();
//   print('Handling a background message: ${message.messageId}');
// }

class Nitoons extends StatelessWidget {
  final AppTheme appTheme;
  Nitoons({super.key, required this.appTheme});

  final analytics = FirebaseAnalytics.instance;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      // splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: appTheme.light,
          navigatorObservers: [
            FirebaseAnalyticsObserver(analytics: analytics),
          ],
          title: 'Actor App',
          routes: routes,
          onUnknownRoute: (settings) {
            return MaterialPageRoute(builder: (ctx) => SplashScreen());
            // ProducerMonologueRolesPage
          },
        );
      },
    );
  }
}
