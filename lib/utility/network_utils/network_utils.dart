import 'dart:developer';
  import 'dart:io';

import 'package:dio/dio.dart';

enum HttpMethod { get, post, put, delete, patch }

class NetworkUtils {
  static final NetworkUtils _instance = NetworkUtils._internal();

  factory NetworkUtils() {
    return _instance;
  }

  NetworkUtils._internal() {
    _dio = Dio(
      BaseOptions(
        baseUrl: 'https://mocki.io/v1', 
        connectTimeout: const Duration(seconds: 60),
        receiveTimeout: const Duration(seconds: 60),
        headers: {'Content-Type': 'application/json'},
      ),
    )..interceptors.add(_createInterceptor());
  }

  late final Dio _dio;

  Interceptor _createInterceptor() {
    return InterceptorsWrapper(
      onRequest: (options, handler) {
        log("Request: ${options.method} ${options.path}");
        return handler.next(options);
      },
      onResponse: (response, handler) {
        log("Response: ${response.statusCode} ${response.data}");
        return handler.next(response);
      },
      onError: ( e, handler) {
        log("Error: ${e.response?.statusCode} ${e.message}");
        return handler.next(e);
      },
    );
  }

  // Generic network request method
  Future<Response?> request<T>({
    required String endpoint,
    required HttpMethod method,
    Map<String, dynamic>? params,
    Map<String, dynamic>? data,
    Options? options,
  }) async {
    try {
      final response = await _dio.request<T>(
        endpoint,
        data: data,
        queryParameters: params,
        options: options ?? Options(method: method.name.toUpperCase()),
      );
      return response;
    }  on DioException catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  // Error handling
  void _handleError(DioException error) {
    switch (error.type) {
      case DioExceptionType.sendTimeout:
        log("Send Timeout Exception");
        break;
      case DioExceptionType.receiveTimeout:
        log("Receive Timeout Exception");
        break;
      
      case DioExceptionType.cancel:
        log("Request Cancelled");
        break;
      default:
        log("Unexpected Error: $error");
        break;
    }
  }


Future<bool> isNetworkAvailable() async {
  try {
    final result = await InternetAddress.lookup('example.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      return true;
    }
    return false;
  } catch (e) {
    return false;
  }
}

}
