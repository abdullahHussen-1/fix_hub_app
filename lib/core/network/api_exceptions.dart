import 'package:dio/dio.dart';
import 'package:fix_hub/core/network/api_error.dart';

class ApiExceptions {
  static ApiError handleError(DioException error) {
    final statusCode = error.response?.statusCode;
    final data = error.response?.data;
    if (data != null && data['message'] != null) {
      return ApiError(message: data['message']);
    }
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return ApiError(message: "bad connections");
      case DioExceptionType.badResponse:
        return ApiError(message: error.toString());
      default:
        return ApiError(message: 'something worng');
    }
  }
}
