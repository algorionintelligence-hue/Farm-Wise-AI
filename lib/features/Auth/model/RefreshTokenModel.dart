class RefreshTokenModel {
  final String refreshToken;

  const RefreshTokenModel({required this.refreshToken});

  Map<String, dynamic> toJson() => {'refreshToken': refreshToken};
}

class RefreshTokenResponse {
  final bool success;
  final String? accessToken;
  final String? refreshToken;
  final String? message;

  const RefreshTokenResponse({
    required this.success,
    this.accessToken,
    this.refreshToken,
    this.message,
  });

  factory RefreshTokenResponse.fromJson(Map<String, dynamic> json) =>
      RefreshTokenResponse(
        success: json['success'] as bool? ?? true,
        accessToken: json['accessToken'] as String?,
        refreshToken: json['refreshToken'] as String?,
        message: json['message'] as String?,
      );
}
