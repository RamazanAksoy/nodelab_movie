import 'package:dio/dio.dart';

class BaseError<T> {
  BaseError({required this.message, this.type});
  final String message;
  final DioErrorType? type;

  @override
  String toString() {
    return 'BaseError{message: $message}';
  }
}
