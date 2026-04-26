class SignupModel {
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String password;
  final bool agreeToTerms;

  const SignupModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.password,
    required this.agreeToTerms,
  });

  Map<String, dynamic> toJson() => {
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'phoneNumber': phoneNumber,
        'password': password,
        'agreeToTerms': agreeToTerms,
      };
}

class SignupResponse {
  final bool success;
  final String? message;

  const SignupResponse({required this.success, this.message});

  factory SignupResponse.fromJson(Map<String, dynamic> json) {
    final payload = _asMap(json['data']) ?? _asMap(json['result']) ?? json;
    final message =
        json['message'] as String? ?? payload['message'] as String?;

    return SignupResponse(
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
    if (_looksLikeSignupSuccess(message)) return true;
    return false;
  }

  static bool _isTruthy(String value) {
    final normalized = value.trim().toLowerCase();
    return normalized == 'true' ||
        normalized == 'success' ||
        normalized == 'succeeded' ||
        normalized == 'ok';
  }

  static bool _looksLikeSignupSuccess(String? message) {
    if (message == null) return false;
    final normalized = message.trim().toLowerCase();
    return normalized.contains('account created') ||
        normalized.contains('verify your email') ||
        normalized.contains('otp sent');
  }
}
