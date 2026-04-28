class OtpModel {
  static const _unset = Object();

  final String otp;
  final bool isLoading;
  final bool isSuccess;
  final String? errorMessage;
  final String? userId;
  final String? token;
  final int resendCountdown;

  const OtpModel({
    this.otp = '',
    this.isLoading = false,
    this.isSuccess = false,
    this.errorMessage,
    this.userId,
    this.token,
    this.resendCountdown = 60,
  });

  OtpModel copyWith({
    String? otp,
    bool? isLoading,
    bool? isSuccess,
    Object? errorMessage = _unset,
    Object? userId = _unset,
    Object? token = _unset,
    int? resendCountdown,
  }) {
    return OtpModel(
      otp: otp ?? this.otp,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage:
          identical(errorMessage, _unset)
              ? this.errorMessage
              : errorMessage as String?,
      userId:
          identical(userId, _unset)
              ? this.userId
              : userId as String?,
      token:
          identical(token, _unset)
              ? this.token
              : token as String?,
      resendCountdown: resendCountdown ?? this.resendCountdown,
    );
  }
}
