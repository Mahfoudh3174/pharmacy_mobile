import 'package:ecommerce/core/middleware/regitred_middleware.dart';
import 'package:ecommerce/view/screen/auth/forgetpassword/forgetpassword.dart';
import 'package:ecommerce/view/screen/auth/forgetpassword/success_reset_password.dart';
import 'package:ecommerce/view/screen/auth/login.dart';
import 'package:ecommerce/view/screen/auth/forgetpassword/resetpassword.dart';
import 'package:ecommerce/view/screen/auth/signup.dart';
import 'package:ecommerce/view/screen/auth/forgetpassword/verifycode.dart';
import 'package:ecommerce/view/screen/auth/success_signup.dart';
import 'package:ecommerce/view/screen/auth/verifycodesignup.dart';
import 'package:ecommerce/view/screen/home_screen.dart';
import 'package:ecommerce/view/screen/medication_view.dart';

import 'package:ecommerce/view/screen/language.dart';
import 'package:ecommerce/view/screen/on_boarding.dart';
import 'package:ecommerce/view/screen/pharmacie_view.dart';


import 'package:get/get.dart';

class Routes {
  static const String onBoarding = '/onBoarding';
  static const String login = '/login';
  static const String language = '/';
  static const String signUp = '/signUp';

  static const String verifiercheckmail = '/verifiercheckmail';
  static const String successSignUp = '/successSignUp';

  static const String forgetPassword = '/forgetPassword';
  static const String verfiyCode = '/verfiyCode';
  static const String resetPassword = '/resetPassword';
  static const String successResetPassword = '/successResetPassword';

  static const String home = '/home';
  static const String medications="/medications";
  static const String pharmacies = '/pharmacies';



  static List<GetPage> routes = [
    GetPage(name: onBoarding, page: () => const OnBoarding()),
    GetPage(name: login, page: () => const Login()),
    GetPage(name: language, page: () => const Language(),middlewares: [RegitredMiddleware()]),
    GetPage(name: signUp, page: () => const SignUp()),
    GetPage(name: verifiercheckmail, page: () => const VerfiyCodeSignUp()),
    GetPage(name: verfiyCode, page: () => const VerfiyCode()),
    GetPage(name: forgetPassword, page: () => const ForgetPassword()),
    GetPage(name: resetPassword, page: () => const ResetPassword()),
    GetPage(name: successResetPassword, page: () => const SuccessResetPassword()),
    GetPage(name: successSignUp, page: () => const SuccessSignUp()),
    GetPage(name: home, page: () => const HomeScreen()), 
    GetPage(name: medications, page: () => const MedicationsView()),
    GetPage(name: pharmacies, page: () => const PharmacieView()),


  ];
}
