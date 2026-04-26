class ChangePasswordModel {
  final String currentPassword;
  final String newPassword;
  final String confirmPassword;

  const ChangePasswordModel({
    required this.currentPassword,
    required this.newPassword,
    required this.confirmPassword,
  });

  Map<String, dynamic> toJson() => {
        'currentPassword': currentPassword,
        'newPassword': newPassword,
        'confirmPassword': confirmPassword,
      };
}

class ChangePasswordResponse {
  final bool success;
  final String? message;

  const ChangePasswordResponse({required this.success, this.message});

  factory ChangePasswordResponse.fromJson(Map<String, dynamic> json) =>
      ChangePasswordResponse(
        success: json['success'] as bool? ?? true,
        message: json['message'] as String?,
      );
}
