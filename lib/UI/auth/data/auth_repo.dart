import 'package:dio/dio.dart';
import 'package:fix_hub/UI/auth/data/user_model.dart';
import 'package:fix_hub/core/network/api_error.dart';
import 'package:fix_hub/core/network/api_exceptions.dart';
import 'package:fix_hub/core/network/api_service.dart';
import 'package:fix_hub/core/utils/pref_helper.dart';

class AuthRepo {
  ApiService apiService = ApiService();
  // todo Login Method
  Future<UserModel> login(String email, String password) async {
    try {
      // todo call api service by end point with post method
      final response = await apiService
          .post('endPoint', {'email': email, 'password': password});
      if (response is ApiError) {
        // todo check if response is ApiError
        throw response;
      }
      // todo check if response is Map<String, dynamic> to detect error
      if (response is Map<String, dynamic>) {
        final msg = response['message'];
        final code = response['code'];
        final coder = int.parse(code);
        final data = response['data'];
        if (coder != 200 && coder != 201 && data == null) {
          // todo check if status code is not 200 to throw error msg
          throw ApiError(message: msg ?? 'UnExpected Error');
        }
        // todo if statues code is 200 and data is not null create user model from data
        final user = UserModel.fromJson(response['data']);
        if (user.tocken != null) {
          // todo if tocken is not null save it to local storage
          await PrefHelper.saveTocken(user.tocken!);
        }
        return user;
      } else {
        throw ApiError(message: 'UnExpected Error from server');
      }
    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }

  // todo Register Method
  Future<UserModel?> register(
      String name,
      String phone,
      String nationalId,
      String city,
      String address,
      String specialty,
      String password,
      String confrimPassword) async {
    try {
      // todo call api service by end point with post method
      final response = await apiService.post('endPoint', {
        'name': name,
        'phone': phone,
        'nationalId': nationalId,
        'city': city,
        'address': address,
        'specialty': specialty,
        'password': password,
        'confrimPassword': confrimPassword,
      });
      if (response is ApiError) {
        throw response;
      }
      if (response is Map<String, dynamic>) {
        final msg = response['message'];
        final code = response['code'];
        final coder = int.parse(code);
        final data = response['data'];
        if (coder != 200 && coder != 201 && data == null) {
          // todo check if status code is not 200 to throw error msg
          throw ApiError(message: msg ?? 'UnExpected Error');
        }
        final user = UserModel.fromJson(data);
        if (user.tocken != null) {
          await PrefHelper.saveTocken(user.tocken!);
        }
        return user;
      } else {
        throw ApiError(message: 'UnExpected Error from server');
      }
    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }
}
