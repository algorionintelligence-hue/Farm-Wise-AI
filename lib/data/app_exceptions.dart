class AppExceptions implements Exception {
  AppExceptions([this.message, this.prefix]);

  final String? message;
  final String? prefix;

  @override
  String toString() {
    return '${prefix ?? ''}${message ?? ''}';
  }
}

class InternetException extends AppExceptions {
  InternetException([String? message]) : super(message, 'No internet. ');
}

class RequestTimeOut extends AppExceptions {
  RequestTimeOut([String? message]) : super(message, 'Request time out. ');
}

class ServerException extends AppExceptions {
  ServerException([String? message]) : super(message, 'Internal server error. ');
}

class InvalidUrlException extends AppExceptions {
  InvalidUrlException([String? message]) : super(message, 'Invalid url. ');
}

class FetchDataException extends AppExceptions {
  FetchDataException([String? message]) : super(message, '');
}
