import 'package:dio/dio.dart';
import '../config/env.dart';

class ApiClient {
  ApiClient._internal()
      : dio = Dio(
    BaseOptions(
      baseUrl: Env.baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      sendTimeout: const Duration(seconds: 10),
      headers: {'Accept': 'application/json'},
    ),
  );

  final Dio dio;

  static final ApiClient instance = ApiClient._internal();
}
