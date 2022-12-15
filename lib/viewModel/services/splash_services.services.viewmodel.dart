import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:tech_media/utils/routes/route_name.dart';

class SplashServices {
  void isLogin(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    final user = auth.currentUser;

    if (user != null) {
      Timer(
        const Duration(seconds: 10),
        () => Navigator.pushNamedAndRemoveUntil(
            context, RouteName.homeScreen, (route) => false),
      );
    } else {
      Timer(
        const Duration(seconds: 10),
        () => Navigator.pushNamedAndRemoveUntil(
            context, RouteName.loginScreen, (route) => false),
      );
    }
  }
}
