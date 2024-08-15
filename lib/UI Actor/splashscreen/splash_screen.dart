import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nitoons/UI Actor/onboarding/onboarding.dart';

import '../../gen/assets.gen.dart';

class SplashScreen extends StatefulWidget {
  static String routeName = "/splash_screen";
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.instance.getToken().then((token) {
      print("FCM Token: $token");
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Received a notification in the foreground: ${message.messageId}');
      if (message.notification != null) {
        print('Notification Title: ${message.notification!.title}');
        print('Notification Body: ${message.notification!.body}');
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Notification clicked!');
    });

    Timer(
        const Duration(
          seconds: 5,
        ), () {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => Onboarding()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 1500),
          opacity: 1,
          curve: Curves.easeIn,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    Assets.svgs.logotext,
                  ),
                ],
              ),
              Positioned(
                  bottom: 36.h,
                  child: CupertinoActivityIndicator(
                    color: Colors.white,
                    radius: 22.r,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
