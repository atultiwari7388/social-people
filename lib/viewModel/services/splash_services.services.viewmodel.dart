import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:tech_media/utils/routes/route_name.dart';
import 'package:tech_media/viewModel/session/session_controller.session.viewmodel.dart';

class SplashServices {
  void isLogin(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    final user = auth.currentUser;

    if (user != null) {
      SessionController().userId = user.uid.toString();
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
