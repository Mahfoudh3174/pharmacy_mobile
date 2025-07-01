class AppLinks {
  static const String baseUrl = "http://192.168.100.24:8000/api";
  static const String imagesLink = "http://192.168.100.24:8000/storage";
  static const String svgsLink = "http://192.168.100.24:8000/storage/categories";

  // ==========auth================
  static const String login = "$baseUrl/login";
  static const String register = "$baseUrl/register";
  static const String logout = "$baseUrl/logout";

  // ==========password reset================
  static const String sendOtp = "$baseUrl/password/send-otp";
  static const String verifyOtp = "$baseUrl/password/verify-otp";
  static const String resetPassword = "$baseUrl/password/reset";

  // =============pharmacies=========
  static const String pharmacies = "$baseUrl/pharmacies";

  //========cart=========
  static const String cart = "$baseUrl/cart";
  static const String cartCount = "$baseUrl/cart/cart-count";

  //======order======
  static const String orders = "$baseUrl/orders";
  //======categories======
  static const String categories = "$baseUrl/categories";
}
