import 'package:ecommerce/controller/pharmacy/pharmacy_controller.dart';
import 'package:ecommerce/core/middleware/regitred_middleware.dart';
import 'package:ecommerce/view/screen/auth/forgetpassword/forgetpassword.dart';
import 'package:ecommerce/view/screen/auth/forgetpassword/success_reset_password.dart';
import 'package:ecommerce/view/screen/auth/login.dart';
import 'package:ecommerce/view/screen/auth/forgetpassword/resetpassword.dart';
import 'package:ecommerce/view/screen/auth/signup.dart';
import 'package:ecommerce/view/screen/auth/forgetpassword/verifycode.dart';
import 'package:ecommerce/view/screen/auth/success_signup.dart';
import 'package:ecommerce/view/screen/auth/verifycodesignup.dart';
import 'package:ecommerce/view/screen/cart_view.dart';
import 'package:ecommerce/view/screen/checkout.dart';
import 'package:ecommerce/view/screen/home_screen.dart';
import 'package:ecommerce/view/screen/medication/medication_datails_view.dart';
import 'package:ecommerce/view/screen/medication/medication_view.dart';
import 'package:ecommerce/view/screen/language.dart';
import 'package:ecommerce/view/screen/on_boarding.dart';
import 'package:ecommerce/view/screen/order/order_details.dart';
import 'package:ecommerce/view/screen/order/order_pending.dart';
import 'package:ecommerce/view/screen/order/order_valid.dart';

import 'package:ecommerce/view/screen/order/order_view.dart';
import 'package:ecommerce/view/screen/pharmacie_view.dart';
import 'package:ecommerce/view/screen/setting/setting_view.dart';

import 'package:get/get.dart';

import 'package:ecommerce/view/screen/map_screen.dart';

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
  static const String medications = "/medications";
  static const String medicationDetails = "/medicationDetails";
  static const String pharmacies = '/pharmacies';

  static const String settings = '/settings';

  static const String cart = '/cart';
  static const String checkout = '/checkout';
  static const String map = '/map';

  static const String orders = '/orders';
  static const String pending = '/pending';
  static const String validated = "/validated";
  static const String ordersdetails = '/ordersdetails';

  static List<GetPage> routes = [
    GetPage(name: onBoarding, page: () => const OnBoarding()),
    GetPage(name: login, page: () => const Login()),
    GetPage(
      name: language,
      page: () => const Language(),
      middlewares: [RegitredMiddleware()],
    ),
    GetPage(name: signUp, page: () => const SignUp()),
    GetPage(name: verifiercheckmail, page: () => const VerfiyCodeSignUp()),
    GetPage(name: verfiyCode, page: () => const VerfiyCode()),
    GetPage(name: forgetPassword, page: () => const ForgetPassword()),
    GetPage(name: resetPassword, page: () => const ResetPassword()),
    GetPage(
      name: successResetPassword,
      page: () => const SuccessResetPassword(),
    ),
    GetPage(name: successSignUp, page: () => const SuccessSignUp()),
    GetPage(name: home, page: () => const HomeScreen(),binding:BindingsBuilder(() {
      Get.lazyPut(() => PharmacyControllerImp());
    })) ,
    GetPage(name: medications, page: () => const MedicationsView()),
    GetPage(name: medicationDetails, page: () => const MedicationDatailsView()),
    GetPage(name: pharmacies, page: () => const PharmacieView()),
    GetPage(name: cart, page: () => const CartView()),
    GetPage(name: checkout, page: () => const CheckoutView()),
    GetPage(name: map, page: () => const MapScreen()),

    GetPage(name: settings, page: () => const SettingView()),

    GetPage(name: orders, page: () => const OrderView()),
    GetPage(name: pending, page: () => const OrdersPending()),
    GetPage(name: ordersdetails, page: () => const OrdersDetails()),
    GetPage(name: validated, page: () => const OrderValidated()),
  ];
}