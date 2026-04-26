class LoginModel {
  final String email;
  final String password;

  const LoginModel({required this.email, required this.password});

  Map<String, dynamic> toJson() => {
    'email': email,
    'password': password,
  };
}

class LoginResponse {
  final bool success;
  final String? accessToken;
  final String? refreshToken;
  final String? message;

  const LoginResponse({
    required this.success,
    this.accessToken,
    this.refreshToken,
    this.message,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    final payload = _asMap(json['data']) ?? _asMap(json['result']) ?? json;

    return LoginResponse(
      success: json['success'] as bool? ?? payload['success'] as bool? ?? true,
      accessToken: _read(payload, [
        'accessToken',
        'AccessToken',
        'token',
        'Token',
        'jwt',
        'jwtToken',
        'jwt_token',
      ]),
      refreshToken: _read(payload, [
        'refreshToken',
        'RefreshToken',
        'refresh_token',
      ]),
      message: json['message'] as String? ?? payload['message'] as String?,
    );
  }

  static Map<String, dynamic>? _asMap(dynamic value) {
    if (value is Map<String, dynamic>) return value;
    return null;
  }

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
