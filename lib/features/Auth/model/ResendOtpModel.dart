class ResendOtpModel {
  final String email;

  const ResendOtpModel({required this.email});

  Map<String, dynamic> toJson() => {'email': email};
}

class ResendOtpResponse {
  final bool success;
  final String? message;

  const ResendOtpResponse({required this.success, this.message});

  factory ResendOtpResponse.fromJson(Map<String, dynamic> json) {
    final payload = _asMap(json['data']) ?? _asMap(json['result']) ?? json;
    final message =
        json['message'] as String? ?? payload['message'] as String?;

    return ResendOtpResponse(
      success: _readBool(json, payload, message),
      message: message,
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
    if (_looksLikeResendSuccess(message)) return true;
    return false;
  }

  static bool _isTruthy(String value) {
    final normalized = value.trim().toLowerCase();
    return normalized == 'true' ||
        normalized == 'success' ||
        normalized == 'succeeded' ||
        normalized == 'ok';
  }

  static bool _looksLikeResendSuccess(String? message) {
    if (message == null) return false;
    final normalized = message.trim().toLowerCase();
    return normalized.contains('otp sent') ||
        normalized.contains('otp resent') ||
        normalized.contains('code sent') ||
        normalized.contains('verification code');
  }
}
