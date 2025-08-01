import 'dart:async';
import 'dart:io';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:logger/web.dart';

import '../../../product/app/application_item.dart';
import '../../base/model/IResponseModel.dart';
import '../../base/model/base_error.dart';
import '../../base/model/base_model.dart';
import '../../constants/enums/http_request_enum.dart';
import '../../extension/network_exntension.dart';
import '../logger/logger.dart';
import 'ICoreDio.dart';
import 'no_network.dart';

part './network_core/core_operations.dart';

class CoreDio with DioMixin implements Dio, ICoreDioNullSafety {
  CoreDio(this.options) {
    httpClientAdapter = DefaultHttpClientAdapter();

    interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          LoggerService().logRequest(options.method, options.uri, options.headers, options.data, options.queryParameters);
          handler.next(options);
        },
        onResponse: (response, handler) {
          LoggerService().logResponse(response.statusCode, response.requestOptions.uri, response.data);
          handler.next(response);
        },
        onError: (e, handler) {
          LoggerService().logError(e.requestOptions.method, e.requestOptions.uri, e);
          handler.next(e);
        },
      ),
    );
  }

  @override
  final BaseOptions options;

  @override
  Future<IResponseModel<R>> send<R, T>(
    String path, {
    required HttpTypes type,
    required BaseModel<T> parseModel,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    void Function(int, int)? onReceiveProgress,
  }) async {
    try {
      final response = await request<dynamic>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(method: type.rawValue, headers: headers),
      );

      switch (response.statusCode) {
        case HttpStatus.ok:
        case HttpStatus.accepted:
          final model = _responseParser<R, T>(parseModel, response.data);
          return ResponseModel<R>(data: model);
        default:
          return ResponseModel(error: BaseError(message: response.data.toString()));
      }
    } on DioError catch (e) {
      return handleNetworkError(path, parseModel: parseModel, type: type, e: e, context: ApplicationItem.instance.context);
    }
  }
}
