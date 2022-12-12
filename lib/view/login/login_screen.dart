import 'package:flutter/material.dart';
import 'package:tech_media/res/components/round_button.components.res.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          RoundedButtonComponent(
            title: "Login",
            onPress: () {},
          ),
        ],
      ),
    );
  }
}
