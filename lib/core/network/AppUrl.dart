class AppUrl {
  AppUrl._();

  static const String BASE_URL = 'http://farmwiseai.tech';

  // ── Auth ──
  static const String SIGNUP_URL          = '$BASE_URL/api/UserAuth/signup';
  static const String VERIFY_OTP_URL      = '$BASE_URL/api/UserAuth/VerifyOTP';
  static const String RESEND_OTP_URL      = '$BASE_URL/api/UserAuth/resend-otp';
  static const String LOGIN_URL           = '$BASE_URL/api/UserAuth/login';
  static const String REFRESH_TOKEN_URL   = '$BASE_URL/api/UserAuth/refresh-token';
  static const String FORGOT_PASSWORD_URL = '$BASE_URL/api/UserAuth/forgot-password';
  static const String RESET_PASSWORD_URL  = '$BASE_URL/api/UserAuth/reset-password';
  static const String CHANGE_PASSWORD_URL = '$BASE_URL/api/UserAuth/change-password';
  static const String LOGOUT_URL          = '$BASE_URL/api/UserAuth/logout';
  static const String LOOKUP_CURRENCY_URL  = '$BASE_URL/api/lookups/currencies';
  static const String LOOKUP_BUSINESSTYPE_URL  = '$BASE_URL/api/lookups/business-types';
  static const String FARM_REGISTRATION_URL  = '$BASE_URL/api/farm';
  static const String FARM_BASE = '$BASE_URL/api/farm';
  static String addBreedUrl(String farmId) => '$FARM_BASE/$farmId/breeds';}