class ResetPasswordModel {
  final String userId;
  final String token;
  final String newPassword;
  final String confirmPassword;

  const ResetPasswordModel({
    required this.userId,
    required this.token,
    required this.newPassword,
    required this.confirmPassword,
  });

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'token': token,
        'newPassword': newPassword,
        'confirmPassword': confirmPassword,
      };
}

class ResetPasswordResponse {
  final bool success;
  final String? message;

  const ResetPasswordResponse({required this.success, this.message});

  factory ResetPasswordResponse.fromJson(Map<String, dynamic> json) =>
      ResetPasswordResponse(
        success: json['success'] as bool? ?? true,
        message: json['message'] as String?,
      );
}
