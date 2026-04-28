class VerifyOtpModel {
  final String email;
  final String otpCode;

  const VerifyOtpModel({required this.email, required this.otpCode});

  Map<String, dynamic> toJson() => {
        'email': email,
        'otpCode': otpCode,
      };
}

class VerifyOtpResponse {
  final bool success;
  final String? message;
  final String? userId;
  final String? token;

  const VerifyOtpResponse({
    required this.success,
    this.message,
    this.userId,
    this.token,
  });

  factory VerifyOtpResponse.fromJson(Map<String, dynamic> json) {
    final payload = _asMap(json['data']) ?? _asMap(json['result']) ?? json;
    final message =
        json['message'] as String? ?? payload['message'] as String?;

    return VerifyOtpResponse(
      success: _readBool(json, payload, message),
      message: message,
      userId: _read(payload, ['userId', 'userID', 'UserId', 'UserID']),
      token: _read(payload, ['token', 'Token', 'resetToken', 'ResetToken']),
    );
  }

  static Map<String, dynamic>? _asMap(dynamic value) {
    if (value is Map<String, dynamic>) return value;
    return null;
  }

  static bool _readBool(
    Map<String, dynamic> root,
    Map<String, dynamic> payload,
    String? message,
  ) {
    final rootValue = root['success'] ?? root['isSuccess'] ?? root['status'];
    final payloadValue =
        payload['success'] ?? payload['isSuccess'] ?? payload['status'];

    if (rootValue is bool) return rootValue;
    if (payloadValue is bool) return payloadValue;
    if (rootValue is String) return _isTruthy(rootValue);
    if (payloadValue is String) return _isTruthy(payloadValue);
    if (_looksLikeVerifySuccess(message)) return true;
    return false;
  }

  static bool _isTruthy(String value) {
    final normalized = value.trim().toLowerCase();
    return normalized == 'true' ||
        normalized == 'success' ||
        normalized == 'succeeded' ||
        normalized == 'ok';
  }

  static bool _looksLikeVerifySuccess(String? message) {
    if (message == null) return false;
    final normalized = message.trim().toLowerCase();
    return normalized.contains('verified') ||
        normalized.contains('successfully verified') ||
        normalized.contains('otp verified');
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
