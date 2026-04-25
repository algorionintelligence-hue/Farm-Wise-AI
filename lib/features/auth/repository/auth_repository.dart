import '../../../core/network/base_api_services.dart';
import '../../../core/network/network_api_services.dart';
import '../../../core/network/app_url.dart';
import '../model/forgot_password_result.dart';

class AuthRepository {
  AuthRepository({BaseApiServices? apiServices})
      : _apiServices = apiServices ?? NetworkApiServices();

  final BaseApiServices _apiServices;

  // ── Login ──
  Future<bool> login(String email, String password) async {
    await _apiServices.postApi(
      {'email': email, 'password': password},
      AppUrl.loginUrl,
    );
    return true;
  }

  // ── SignUp ──
  Future<bool> signUp({
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
    required String password,
  }) async {
    await _apiServices.postApi(
      {
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'phoneNumber': phone,
        'password': password,
        'agreeToTerms': true,
      },
      AppUrl.signupUrl,
    );
    return true;
  }

  // ── Verify OTP ──
  Future<bool> verifyOtp({
    required String email,
    required String otpCode,
  }) async {
    await _apiServices.postApi(
      {'email': email, 'otpCode': otpCode},
      AppUrl.verifyOtpUrl,
    );
    return true;
  }

  // ── Resend OTP ──
  Future<bool> resendOtp(String email) async {
    await _apiServices.postApi(
      {'email': email},
      AppUrl.resendOtpUrl,
    );
    return true;
  }

  // ── Refresh Token ──
  Future<bool> refreshToken(String token) async {
    await _apiServices.postApi(
      {'refreshToken': token},
      AppUrl.refreshTokenUrl,
    );
    return true;
  }

  // ── Forgot Password ──
  Future<ForgotPasswordResult> forgotPassword(String email) async {
    final response = await _apiServices.postApi(
      {'email': email},
      AppUrl.forgotPasswordUrl,
    );
    return ForgotPasswordResult.fromResponse(response);
  }

  // ── Reset Password ──
  Future<bool> resetPassword({
    required String userId,
    required String token,
    required String newPassword,
    required String confirmPassword,
  }) async {
    await _apiServices.postApi(
      {
        'userId': userId,
        'token': token,
        'newPassword': newPassword,
        'confirmPassword': confirmPassword,
      },
      AppUrl.resetPasswordUrl,
    );
    return true;
  }

  // ── Change Password ──
  Future<bool> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    await _apiServices.postApi(
      {
        'currentPassword': currentPassword,
        'newPassword': newPassword,
        'confirmPassword': confirmPassword,
      },
      AppUrl.changePasswordUrl,
    );
    return true;
  }

  // ── Logout ──
  Future<bool> logout() async {
    await _apiServices.postApi({}, AppUrl.logoutUrl);
    return true;
  }
}
