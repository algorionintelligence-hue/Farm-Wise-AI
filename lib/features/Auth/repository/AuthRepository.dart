import '../../../core/network/BaseApiServices.dart';
import '../../../core/network/NetworkApiServices.dart';
import '../../../core/network/AppUrl.dart';
import '../model/LoginModel.dart';
import '../model/SignupModel.dart';
import '../model/VerifyOtpModel.dart';
import '../model/ResendOtpModel.dart';
import '../model/RefreshTokenModel.dart';
import '../model/ForgotPasswordModel.dart';
import '../model/ResetPasswordModel.dart';
import '../model/ChangePasswordModel.dart';
import '../model/LogoutModel.dart';

class AuthRepository {
  AuthRepository({BaseApiServices? apiServices})
      : _apiServices = apiServices ?? NetworkApiServices();

  final BaseApiServices _apiServices;

  Future<dynamic> _postPublic(dynamic data, String url) async {
    if (_apiServices is NetworkApiServices) {
      return (_apiServices as NetworkApiServices).postPublicApi(data, url);
    }
    return _apiServices.postApi(data, url);
  }

  // ── Login ──
  Future<LoginResponse> login(LoginModel request) async {
    final response = await _postPublic(request.toJson(), AppUrl.LOGIN_URL);
    return LoginResponse.fromJson(response as Map<String, dynamic>);
  }

  // ── SignUp ──
  Future<SignupResponse> signUp(SignupModel request) async {
    final response = await _postPublic(
      request.toJson(),
      AppUrl.SIGNUP_URL,
    );
    return SignupResponse.fromJson(response as Map<String, dynamic>);
  }

  // ── Verify OTP ──
  Future<VerifyOtpResponse> verifyOtp(VerifyOtpModel request) async {
    final response = await _postPublic(
      request.toJson(),
      AppUrl.VERIFY_OTP_URL,
    );
    return VerifyOtpResponse.fromJson(response as Map<String, dynamic>);
  }

  Future<VerifyOtpResponse> verifyResetOtp(VerifyOtpModel request) async {
    final response = await _postPublic(
      request.toJson(),
      AppUrl.verifyResetOtpUrl,
    );
    return VerifyOtpResponse.fromJson(response as Map<String, dynamic>);
  }

  // ── Resend OTP ──
  Future<ResendOtpResponse> resendOtp(ResendOtpModel request) async {
    final response = await _postPublic(
      request.toJson(),
      AppUrl.RESEND_OTP_URL,
    );
    return ResendOtpResponse.fromJson(response as Map<String, dynamic>);
  }

  // ── Refresh Token ──
  Future<RefreshTokenResponse> refreshToken(RefreshTokenModel request) async {
    final response = await _apiServices.postApi(
      request.toJson(),
      AppUrl.REFRESH_TOKEN_URL,
    );
    return RefreshTokenResponse.fromJson(response as Map<String, dynamic>);
  }

  // ── Forgot Password ──
  Future<ForgotPasswordResponse> forgotPassword(ForgotPasswordModel request) async {
    final response = await _postPublic(
      request.toJson(),
      AppUrl.FORGOT_PASSWORD_URL,
    );
    return ForgotPasswordResponse.fromJson(response as Map<String, dynamic>);
  }

  // ── Reset Password ──
  Future<ResetPasswordResponse> resetPassword(ResetPasswordModel request) async {
    final response = await _postPublic(
      request.toJson(),
      AppUrl.RESET_PASSWORD_URL,
    );
    return ResetPasswordResponse.fromJson(response as Map<String, dynamic>);
  }

  // ── Change Password ──
  Future<ChangePasswordResponse> changePassword(ChangePasswordModel request) async {
    final response = await _apiServices.postApi(
      request.toJson(),
      AppUrl.CHANGE_PASSWORD_URL,
    );
    return ChangePasswordResponse.fromJson(response as Map<String, dynamic>);
  }

  // ── Logout ──
  Future<LogoutResponse> logout(LogoutModel request) async {
    final response = await _apiServices.postApi(
      request.toJson(),
      AppUrl.LOGOUT_URL,
    );
    return LogoutResponse.fromJson(response as Map<String, dynamic>);
  }
}
