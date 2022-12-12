import 'package:flutter/material.dart';
import 'package:tech_media/res/components/round_button.components.res.dart';
import 'package:tech_media/res/components/text_field.components.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final emailController = TextEditingController();
  final emailFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormFieldComponent(
              controller: emailController,
              focusNode: emailFocusNode,
              onFieldSubmitValue: (value) {},
              keyboardType: TextInputType.emailAddress,
              obscureText: false,
              hintText: "Email",
              formFieldValidator: (value) {
                return value.isEmpty ? "Enter email address" : null;
              },
            ),
            const SizedBox(height: 40),
            RoundedButtonComponent(
              title: "Login",
              onPress: () {},
            ),
          ],
        ),
      ),
    );
  }
}
