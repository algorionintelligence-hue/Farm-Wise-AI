class ForgotPasswordResult {
  const ForgotPasswordResult({
    this.message,
    this.userId,
    this.token,
  });

  final String? message;
  final String? userId;
  final String? token;

  factory ForgotPasswordResult.fromResponse(dynamic data) {
    if (data is Map<String, dynamic>) {
      return ForgotPasswordResult(
        message: _readString(data, ['message', 'Message']),
        userId: _readString(data, ['userId', 'userID', 'UserId', 'UserID']),
        token: _readString(data, ['token', 'Token', 'resetToken', 'ResetToken']),
      );
    }

    return const ForgotPasswordResult();
  }

  static String? _readString(Map<String, dynamic> data, List<String> keys) {
    for (final key in keys) {
      final value = data[key];
      if (value != null && value.toString().trim().isNotEmpty) {
        return value.toString();
      }
    }
    return null;
  }
}
