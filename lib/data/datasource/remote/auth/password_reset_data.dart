import 'package:ecommerce/core/class/crud.dart';
import 'package:ecommerce/linkapi.dart';

class PasswordResetData {
  Crud crud;

  PasswordResetData(this.crud);

  // Send OTP to email
  sendOtp(String email) async {
    var response = await crud.postJsonData(
      AppLinks.sendOtp,
      {"email": email},
      {"Content-Type": "application/json", "Accept": "application/json"},
    );
    return response.fold((l) => l, (r) => r);
  }

  // Verify OTP
  verifyOtp(String email, String otp) async {
    var response = await crud.postJsonData(
      AppLinks.verifyOtp,
      {"email": email, "otp": otp},
      {"Content-Type": "application/json", "Accept": "application/json"},
    );
    return response.fold((l) => l, (r) => r);
  }

  // Reset password
  resetPassword(
    String email,
    String otp,
    String password,
    String passwordConfirmation,
  ) async {
    var response = await crud.postJsonData(
      AppLinks.resetPassword,
      {
        "email": email,
        "otp": otp,
        "password": password,
        "password_confirmation": passwordConfirmation,
      },
      {"Content-Type": "application/json", "Accept": "application/json"},
    );
    return response.fold((l) => l, (r) => r);
  }
}
