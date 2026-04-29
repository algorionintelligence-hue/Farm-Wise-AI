class AppUrl {
  AppUrl._();

  static const String baseUrl = 'http://farmwiseai.tech';

  // ── Auth ──
  static const String signupUrl         = '$baseUrl/api/UserAuth/signup';
  static const String verifyOtpUrl      = '$baseUrl/api/UserAuth/VerifyOTP';
  static const String resendOtpUrl      = '$baseUrl/api/UserAuth/resend-otp';
  static const String loginUrl          = '$baseUrl/api/UserAuth/login';
  static const String refreshTokenUrl   = '$baseUrl/api/UserAuth/refresh-token';
  static const String forgotPasswordUrl = '$baseUrl/api/UserAuth/forgot-password';
  static const String resetPasswordUrl  = '$baseUrl/api/UserAuth/reset-password';
  static const String changePasswordUrl = '$baseUrl/api/UserAuth/change-password';
  static const String logoutUrl         = '$baseUrl/api/UserAuth/logout';
}
