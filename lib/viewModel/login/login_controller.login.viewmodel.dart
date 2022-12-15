import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tech_media/utils/routes/route_name.dart';
import '../../utils/utils.utils.dart';
import '../session/session_controller.session.viewmodel.dart';

class LoginController with ChangeNotifier {
  FirebaseAuth auth = FirebaseAuth.instance;

  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  //user login
  void login(String emailAddress, String password, BuildContext context) async {
    setLoading(true);
    try {
      auth
          .signInWithEmailAndPassword(email: emailAddress, password: password)
          .then((value) {
        SessionController().userId = value.user!.uid.toString();
        Utils.toastMessage("Welcome back");
        setLoading(false);
        //move to next screen
        Navigator.pushNamedAndRemoveUntil(
            context, RouteName.dashboardScreen, (route) => false);
      }).onError((error, stackTrace) {
        setLoading(false);
        Utils.toastMessage(error.toString());
      });
    } catch (e) {
      setLoading(false);
      Utils.toastMessage(e.toString());
    }
  }

  // forgot password

  void forgotPassword(BuildContext context, String emailAddress) async {
    setLoading(true);

    try {
      auth.sendPasswordResetEmail(email: emailAddress).then((value) {
        setLoading(false);
        Navigator.pushNamed(context, RouteName.loginScreen);
        Utils.toastMessage("Please check your email to recover your pass");
      }).onError((error, stackTrace) {
        setLoading(false);
        Utils.toastMessage(error.toString());
      });
    } catch (e) {
      setLoading(false);
      Utils.toastMessage(e.toString());
    }
  }
}
