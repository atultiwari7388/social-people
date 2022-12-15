import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:tech_media/utils/routes/route_name.dart';
import 'package:tech_media/utils/utils.utils.dart';
import '../session/session_controller.session.viewmodel.dart';

class SignUpController with ChangeNotifier {
  FirebaseAuth auth = FirebaseAuth.instance;
  //realtime database
  DatabaseReference dbRef = FirebaseDatabase.instance.ref().child("Users");
  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  //create user
  void createAccount(String userName, String emailAddress, String password,
      BuildContext context) async {
    setLoading(true);
    try {
      auth
          .createUserWithEmailAndPassword(
              email: emailAddress, password: password)
          .then((value) {
        SessionController().userId = value.user!.uid.toString();
        Utils.toastMessage("Account Created Successfully");
        setLoading(false);
        //store user data to realtime database
        dbRef.child(value.user!.uid.toString()).set({
          "uid": value.user!.uid.toString(),
          "email": value.user!.email.toString(),
          "userName": userName,
          "onlineStatus": "noOne",
          "phoneNumber": "",
          "profilePicture": "",
        }).then((value) {
          setLoading(false);
          //move to home screen
          Navigator.pushNamedAndRemoveUntil(
              context, RouteName.dashboardScreen, (route) => false);
        }).onError((error, stackTrace) {
          setLoading(false);
          Utils.toastMessage(error.toString());
        });
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

//27:37
