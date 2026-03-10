import 'package:dio/dio.dart';
import 'package:fix_hub/core/network/api_exceptions.dart';
import 'package:fix_hub/core/network/dio_client.dart';

class ApiService {
  final DioClient _dioClient = DioClient();
  // todo CRUD METHODS///////
  // todo Get
  Future<dynamic> get(String endPoint) async {
    try {
      final response = await _dioClient.dio.get(endPoint);
      return response.data;
    } on DioError catch (error) {
      return ApiExceptions.handleError(error);
    }
  }
// todo post
  Future<dynamic> post(String endPoint, Map<String, dynamic> body) async {
    try {
      final response = await _dioClient.dio.post(endPoint, data: body);
      return response.data;
    } on DioError catch (error) {
      return ApiExceptions.handleError(error);
    }
  }

// todo put / Updata
  Future<dynamic> put(String endPoint, Map<String, dynamic> body) async {
    try {
      final response = await _dioClient.dio.put(endPoint, data: body);
      return response.data;
    } on DioError catch (error) {
      return ApiExceptions.handleError(error);
    }
  }
// todo delete
  Future<dynamic> delete(String endPoint, Map<String, dynamic> body) async {
    try {
      final response = await _dioClient.dio.delete(endPoint, data: body);
      return response.data;
    } on DioError catch (error) {
      return ApiExceptions.handleError(error);
    }
  }
}
