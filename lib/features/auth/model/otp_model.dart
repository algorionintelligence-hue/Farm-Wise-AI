class OtpModel {
  final String otp;
  final bool isLoading;
  final bool isSuccess;
  final String? errorMessage;
  final int resendCountdown; // ✅ add this

  const OtpModel({
    this.otp = '',
    this.isLoading = false,
    this.isSuccess = false,
    this.errorMessage,
    this.resendCountdown = 10, // ✅ starts at 10
  });

  OtpModel copyWith({
    String? otp,
    bool? isLoading,
    bool? isSuccess,
    String? errorMessage,
    int? resendCountdown,
  }) {
    return OtpModel(
      otp: otp ?? this.otp,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage ?? this.errorMessage,
      resendCountdown: resendCountdown ?? this.resendCountdown, // ✅
    );
  }
}