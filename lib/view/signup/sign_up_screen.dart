import 'package:flutter/material.dart';
import 'package:tech_media/res/components/round_button.components.res.dart';
import 'package:tech_media/res/components/text_field.components.dart';
import 'package:tech_media/utils/routes/route_name.dart';

import '../../utils/utils.utils.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({Key? key}) : super(key: key);

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final userNameController = TextEditingController();
  final userNameFocusNode = FocusNode();
  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    userNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    userNameFocusNode.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: height * .01),
                Text("Welcome", style: Theme.of(context).textTheme.headline3),
                SizedBox(height: height * .01),
                Text("Enter your email address\nto connect your account",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.subtitle1),
                SizedBox(height: height * .01),
                Form(
                  key: _formKey,
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: height * .06, bottom: height * 0.01),
                    child: Column(
                      children: [
                        TextFormFieldComponent(
                          controller: userNameController,
                          focusNode: userNameFocusNode,
                          onFieldSubmitValue: (value) {
                            Utils.fieldFocusNode(
                                context, userNameFocusNode, emailFocusNode);
                          },
                          keyboardType: TextInputType.emailAddress,
                          obscureText: false,
                          hintText: "Email",
                          formFieldValidator: (value) {
                            return value.isEmpty ? "Enter email address" : null;
                          },
                        ),
                        SizedBox(height: height * 0.01),
                        TextFormFieldComponent(
                          controller: emailController,
                          focusNode: emailFocusNode,
                          onFieldSubmitValue: (value) {
                            Utils.fieldFocusNode(
                                context, emailFocusNode, passwordFocusNode);
                          },
                          keyboardType: TextInputType.emailAddress,
                          obscureText: false,
                          hintText: "Email",
                          formFieldValidator: (value) {
                            return value.isEmpty ? "Enter email address" : null;
                          },
                        ),
                        SizedBox(height: height * 0.01),
                        TextFormFieldComponent(
                          controller: passwordController,
                          focusNode: passwordFocusNode,
                          onFieldSubmitValue: (value) {},
                          keyboardType: TextInputType.emailAddress,
                          obscureText: true,
                          hintText: "Password",
                          formFieldValidator: (value) {
                            return value.isEmpty ? "Enter password" : null;
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                // Align(
                //   alignment: Alignment.centerRight,
                //   child: Text(
                //     "Forgot Password",
                //     style: Theme.of(context).textTheme.subtitle1!.copyWith(
                //         fontSize: 15, decoration: TextDecoration.underline),
                //   ),
                // ),
                const SizedBox(height: 40),
                RoundedButtonComponent(
                  title: "Create account",
                  onPress: () {
                    if (_formKey.currentState!.validate()) {
                      Utils.toastMessage("message");
                    }
                  },
                ),

                //don't have an account section
                InkWell(
                  onTap: () =>
                      Navigator.pushNamed(context, RouteName.loginScreen),
                  child: Text.rich(
                    TextSpan(
                      text: "Already have an account? ",
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1!
                          .copyWith(fontSize: 15),
                      children: [
                        TextSpan(
                          text: "Login now",
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1!
                              .copyWith(
                                  fontSize: 15,
                                  decoration: TextDecoration.underline),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
