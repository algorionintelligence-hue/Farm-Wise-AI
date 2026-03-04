// ============================================================
// MODEL — OTP ka data yahan store hoga
// ============================================================
class OtpModel {
  final String otp;       // User ka daala hua OTP
  final bool isLoading;   // API call chal rahi hai?
  final String? errorMessage; // Koi error aayi?
  final bool isSuccess;   // OTP sahi tha?

  const OtpModel({
    this.otp = '',
    this.isLoading = false,
    this.errorMessage,
    this.isSuccess = false,
  });

  // copyWith: sirf woh field badlo jo chahiye, baaki same rahein
  OtpModel copyWith({
    String? otp,
    bool? isLoading,
    String? errorMessage,
    bool? isSuccess,
  }) {
    return OtpModel(
      otp: otp ?? this.otp,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,   // null bhi ho sakta hai (error clear)
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }
}