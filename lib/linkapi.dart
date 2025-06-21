class AppLinks{

  static const String baseUrl = "http://192.168.100.4:8000/api";
  static const String imagesLink = "http://192.168.100.4:8000/storage";
  // ==========auth================
  static const String login = "$baseUrl/login";
  static const String register = "$baseUrl/register";
  static const String logout="$baseUrl/logout";
  
  // =============pharmacies=========
  static const String pharmacies = "$baseUrl/pharmacies";

  //========cart=========
  static const String cart = "$baseUrl/cart";
  static const String cartCount = "$baseUrl/cart/cart-count";

  //======order======
  static const String orders = "$baseUrl/orders";
}