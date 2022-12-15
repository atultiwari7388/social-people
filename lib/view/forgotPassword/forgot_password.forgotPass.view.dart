import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tech_media/res/components/round_button.components.res.dart';
import 'package:tech_media/res/components/text_field.components.dart';
import 'package:tech_media/viewModel/login/login_controller.login.viewmodel.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final emailFocusNode = FocusNode();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    emailFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: ChangeNotifierProvider(
            create: (_) => LoginController(),
            child: Consumer<LoginController>(
              builder: (context, provider, child) {
                return SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: height * .01),
                      Text("Forgot Password",
                          style: Theme.of(context).textTheme.headline3),
                      SizedBox(height: height * .01),
                      Text("Enter your email address\nto recover your password",
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
                                controller: emailController,
                                focusNode: emailFocusNode,
                                onFieldSubmitValue: (value) {},
                                keyboardType: TextInputType.emailAddress,
                                obscureText: false,
                                hintText: "Email",
                                formFieldValidator: (value) {
                                  return value.isEmpty
                                      ? "Enter email address"
                                      : null;
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                      RoundedButtonComponent(
                        loading: provider.loading,
                        title: "Forgot",
                        onPress: () {
                          if (_formKey.currentState!.validate()) {
                            provider.forgotPassword(
                                context, emailController.text.toString());
                          }
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
