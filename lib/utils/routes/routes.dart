import 'package:flutter/material.dart';
import 'package:tech_media/utils/routes/route_name.dart';
import 'package:tech_media/view/dashboard/dashboard_view.view.dart';
import 'package:tech_media/view/forgotPassword/forgot_password.forgotPass.view.dart';
import 'package:tech_media/view/login/login_screen.dart';
import 'package:tech_media/view/profile/profile_view.profile.view.dart';
import 'package:tech_media/view/signup/sign_up_screen.dart';
import 'package:tech_media/view/splash/splash_screen.dart';
import 'package:tech_media/view/userList/user_list_view.userList.view.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // final arguments = settings.arguments;
    switch (settings.name) {
      case RouteName.splashScreen:
        return MaterialPageRoute(builder: (_) => const SplashScreen());

      case RouteName.loginScreen:
        return MaterialPageRoute(builder: (_) => const LoginView());

      case RouteName.signupScreen:
        return MaterialPageRoute(builder: (_) => const SignUpView());

      case RouteName.dashboardScreen:
        return MaterialPageRoute(builder: (_) => const DashBoardView());

      case RouteName.forgotPassword:
        return MaterialPageRoute(builder: (_) => const ForgotPassword());

      case RouteName.profileScreen:
        return MaterialPageRoute(builder: (_) => const ProfileView());

      case RouteName.userListScreen:
        return MaterialPageRoute(builder: (_) => const UserListView());

      default:
        return MaterialPageRoute(builder: (_) {
          return Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          );
        });
    }
  }
}
