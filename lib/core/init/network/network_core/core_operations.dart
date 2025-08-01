part of '../core_dio.dart';

extension _CoreDioOperations on CoreDio {
  R? _responseParser<R, T>(BaseModel<T> model, dynamic data) {
    if (data is List) {
      return data.map((e) => model.fromJson(e)).toList().cast<T>() as R;
    } else if (data is Map) {
      return model.fromJson(data as Map<String, dynamic>) as R;
    }
    return data as R?;
  }
}

extension NetworkEror on CoreDio {
  Future<IResponseModel<R>> handleNetworkError<R, T>(
    String path, {
    required BaseModel<T> parseModel,
    required HttpTypes type,
    Map<String, dynamic>? queryParameters,
    dynamic data,
    required DioError e,
    required BuildContext context,
  }) async {
    bool isRetry = false;
    await NoNetworkManager(
      onRetry: () {
        isRetry = true;
      },
      isEnable: true,
    ).show(context);

    if (isRetry) {
      return await send(path, type: type, data: data, parseModel: parseModel, queryParameters: queryParameters);
    }

    return ResponseModel(
      error: BaseError(message: e.response != null ? e.response!.data.toString() : e.error.toString(), type: e.type),
    );
  }
}
