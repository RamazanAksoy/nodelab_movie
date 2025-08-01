// lib/core/logger/logger_service.dart
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class LoggerService {
  static final LoggerService _instance = LoggerService._internal();
  factory LoggerService() => _instance;

  late final Logger _logger;

  LoggerService._internal() {
    _logger = Logger(printer: PrettyPrinter(methodCount: 1, errorMethodCount: 5, lineLength: 100, colors: true, printEmojis: true, printTime: true));
  }

  void logRequest(String method, Uri uri, Map<String, dynamic>? headers, dynamic data, Map<String, dynamic>? query) {
    _logger.i('📤 REQUEST → $method $uri');
    _logger.d({'Headers': headers, 'Query': query, 'Body': data});
  }

  void logResponse(int? statusCode, Uri uri, dynamic data) {
    _logger.i('📥 RESPONSE ← $statusCode $uri');
    _logger.d({'Data': data});
  }

  void logError(String method, Uri uri, DioError error) {
    _logger.e('💥 ERROR ← $method $uri');
    _logger.e({'Type': error.type.toString(), 'Message': error.message, 'StatusCode': error.response?.statusCode, 'Data': error.response?.data});
  }
}
