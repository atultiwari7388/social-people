import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tech_media/utils/routes/route_name.dart';
import '../../utils/utils.utils.dart';

class LoginController with ChangeNotifier {
  FirebaseAuth auth = FirebaseAuth.instance;

  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  //create user
  void login(String emailAddress, String password, BuildContext context) async {
    setLoading(true);
    try {
      auth
          .signInWithEmailAndPassword(email: emailAddress, password: password)
          .then((value) {
        Utils.toastMessage("Welcome back");
        setLoading(false);
        //move to next screen
        Navigator.pushNamedAndRemoveUntil(
            context, RouteName.homeScreen, (route) => false);
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
