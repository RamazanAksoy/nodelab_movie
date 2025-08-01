import 'base_error.dart';

abstract class IResponseModel<T> {
  T? data;
  BaseError? error;
}

class ResponseModel<T> extends IResponseModel<T> {
  ResponseModel({this.data, this.error});
  @override
  final T? data;
  @override
  final BaseError? error;

  @override
  String toString() {
    return 'ResponseModel{data: $data, error: $error}';
  }
}
