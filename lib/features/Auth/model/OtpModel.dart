const _unset = Object();

class OtpModel {
  final String otp;
  final bool isLoading;
  final bool isSuccess;
  final String? errorMessage;
  final int resendCountdown;
  final String? verifiedUserId;
  final String? verifiedToken;

  const OtpModel({
    this.otp = '',
    this.isLoading = false,
    this.isSuccess = false,
    this.errorMessage,
    this.resendCountdown = 10,
    this.verifiedUserId,
    this.verifiedToken,
  });

  OtpModel copyWith({
    String? otp,
    bool? isLoading,
    bool? isSuccess,
    Object? errorMessage = _unset,
    int? resendCountdown,
    Object? verifiedUserId = _unset,
    Object? verifiedToken = _unset,
  }) {
    return OtpModel(
      otp: otp ?? this.otp,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage == _unset
          ? this.errorMessage
          : errorMessage as String?,
      resendCountdown: resendCountdown ?? this.resendCountdown,
      verifiedUserId: verifiedUserId == _unset
          ? this.verifiedUserId
          : verifiedUserId as String?,
      verifiedToken: verifiedToken == _unset
          ? this.verifiedToken
          : verifiedToken as String?,
    );
  }
}
