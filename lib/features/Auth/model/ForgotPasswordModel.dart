class ForgotPasswordModel {
  final String email;

  const ForgotPasswordModel({required this.email});

  Map<String, dynamic> toJson() => {'email': email};
}

class ForgotPasswordResponse {
  final bool success;
  final String? message;
  final String? userId;
  final String? token;

  const ForgotPasswordResponse({
    required this.success,
    this.message,
    this.userId,
    this.token,
  });

  factory ForgotPasswordResponse.fromJson(Map<String, dynamic> json) =>
      ForgotPasswordResponse(
        success: json['success'] as bool? ?? true,
        message: json['message'] as String?,
        userId: _read(json, ['userId', 'userID', 'UserId', 'UserID']),
        token: _read(json, ['token', 'Token', 'resetToken', 'ResetToken']),
      );

  static String? _read(Map<String, dynamic> data, List<String> keys) {
    for (final key in keys) {
      final value = data[key];
      if (value != null && value.toString().trim().isNotEmpty) {
        return value.toString();
      }
    }
    return null;
  }
}
