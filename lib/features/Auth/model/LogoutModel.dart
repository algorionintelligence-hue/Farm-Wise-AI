class LogoutModel {
  final String refreshToken;

  const LogoutModel({required this.refreshToken});

  Map<String, dynamic> toJson() => {'refreshToken': refreshToken};
}

class LogoutResponse {
  final bool success;
  final String? message;

  const LogoutResponse({required this.success, this.message});

  factory LogoutResponse.fromJson(Map<String, dynamic> json) => LogoutResponse(
        success: json['success'] as bool? ?? true,
        message: json['message'] as String?,
      );
}
