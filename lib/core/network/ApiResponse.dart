import 'Status.dart';

class ApiResponse<T> {
  ApiResponse(this.status, this.data, this.message);

  ApiResponse.loading([this.message])
      : status = Status.loading,
        data = null;

  ApiResponse.completed(this.data)
      : status = Status.completed,
        message = null;

  ApiResponse.error([this.message])
      : status = Status.error,
        data = null;

  Status? status;
  T? data;
  String? message;

  @override
  String toString() {
    return 'Status: $status\nMessage: $message\nData: $data';
  }
}
