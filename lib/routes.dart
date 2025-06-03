import 'package:ecommerce/view/screen/auth/forgetpassword.dart';
import 'package:ecommerce/view/screen/auth/login.dart';
import 'package:ecommerce/view/screen/auth/resetpassword.dart';
import 'package:ecommerce/view/screen/auth/signup.dart';
import 'package:ecommerce/view/screen/auth/verifycode.dart';
import 'package:ecommerce/view/screen/language.dart';
import 'package:ecommerce/view/screen/on_boarding.dart';

import 'package:get/get.dart';

class Routes {
  static const String onBoarding = '/onBoarding';
  static const String login = '/login';
  static const String language = '/language';
  static const String signUp = '/signUp';
  static const String forgetPassword = '/forgetPassword';
  static const String verfiyCode = '/verfiyCode';
  static const String resetPassword = '/resetPassword';

  static String getOnBoarding() => onBoarding;
  static String getLogin() => login;
  static String getLanguage() => language;
  static String getSignUp() => signUp;
  static String getVerfiyCode() => verfiyCode;
  static String getForgetPassword() => forgetPassword;
  static String getResetPassword() => resetPassword;

  static List<GetPage> routes = [
    GetPage(name: onBoarding, page: () => const OnBoarding()),
    GetPage(name: login, page: () => const Login()),
    GetPage(name: language, page: () => const Language()),
    GetPage(name: signUp, page: () => const SignUp()),
    GetPage(name: verfiyCode, page: () => const VerfiyCode()),
    GetPage(name: forgetPassword, page: () => const ForgetPassword()),
    GetPage(name: resetPassword, page: () => const ResetPassword()),
  ];
}
