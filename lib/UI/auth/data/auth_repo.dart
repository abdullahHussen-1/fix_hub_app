import 'package:dio/dio.dart';
import 'package:fix_hub/UI/auth/data/user_model.dart';
import 'package:fix_hub/core/network/api_error.dart';
import 'package:fix_hub/core/network/api_exceptions.dart';
import 'package:fix_hub/core/network/api_service.dart';
import 'package:fix_hub/core/utils/pref_helper.dart';

class AuthRepo {
  final ApiService apiService = ApiService();

  //todo=> login
  Future<UserModel> login(String phone, String password) async {
    try {
      final response = await apiService.post('/api/login', {
        'phone': phone,
        'password': password,
      });
      print("LOGIN RESPONSE => $response");
      if (response is ApiError) throw response;

      if (response is Map<String, dynamic>) {
        final success = response['success'];
        final message = response['message'];
        final data = response['data'];

        if (success == false || data == null) {
          throw ApiError(message: message ?? 'Login failed');
        }

        final user = UserModel.fromJson({
          ...data['user'],
          'token': data['token'],
        });
        if (user.token != null) {
          await PrefHelper.saveToken(user.token!);
        }

        if (user.role != null) {
          await PrefHelper.saveRole(user.role!);
        }

        return user;
      } else {
        throw ApiError(message: 'Unexpected response');
      }
    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }

  // todo=> Register
  Future<UserModel> register({
    required bool isTechnical,
    required String name,
    required String phone,
    required String nationalId,
    required String city,
    String? address,
    String? specialty,
    required String password,
    required String confirmPassword,
  }) async {
    try {
      final endpoint =
          isTechnical ? '/api/register/technical' : '/api/register/normal';

      final body = {
        'name': name,
        'phone': phone,
        'national_id': nationalId,
        'city': city,
        'password': password,
        'password_confirmation': confirmPassword,
      };

      if (isTechnical) {
        body['profession'] = specialty!;
      } else {
        body['address'] = address!;
      }

      final response = await apiService.post(endpoint, body);

      /// todo=> debug
      print("REGISTER RESPONSE => $response");

      if (response is ApiError) throw response;

      if (response is Map<String, dynamic>) {
        final success = response['success'];
        final message = response['message'];
        final data = response['data'];

        if (success == false || data == null) {
          throw ApiError(message: message ?? 'Register failed');
        }

        final userMap = Map<String, dynamic>.from(data['user']);

        final user = UserModel.fromJson({
          ...userMap,
          'token': data['token'],
        });

        if (user.token != null) {
          await PrefHelper.saveToken(user.token!);
        }

        if (user.role != null) {
          await PrefHelper.saveRole(user.role!);
        }

        return user;
      } else {
        throw ApiError(message: 'Unexpected response');
      }
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }

  // todo=> Logout clears token and role from shared preferences
  static Future<void> logout() async {
    try {
      ///todo remove token + role from shared preferences
      await PrefHelper.clearAll();
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }

  //todo=> get profile
  Future<UserModel> getProfile() async {
    try {
      final endpoint = '/api/profile';

      final response = await apiService.get(endpoint);

      /// todo=> debug
      print("PROFILE RESPONSE => $response");

      if (response is ApiError) throw response;

      if (response is Map<String, dynamic>) {
        final success = response['success'];
        final message = response['message'];
        final data = response['data'];

        if (success == false || data == null) {
          throw ApiError(message: message ?? 'Get profile failed');
        }

        final userMap = Map<String, dynamic>.from(data);

        // final user = UserModel.fromJson(userMap);
        final user = UserModel.fromJson({
          ...userMap,
          'token': data['token'],
        });

        if (user.token != null) {
          await PrefHelper.saveToken(user.token!);
        }

        if (user.role != null) {
          await PrefHelper.saveRole(user.role!);
        }
        return user;
      } else {
        throw ApiError(message: 'Unexpected response');
      }
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }

  //todo=> update profile
  Future<UserModel> updateProfile(Map<String, dynamic> body) async {
    try {
      final endpoint = '/api/profile/update';

      final response = await apiService.put(endpoint, body);

      /// todo=> debug
      print("UPDATE PROFILE RESPONSE => $response");

      if (response is ApiError) throw response;

      if (response is Map<String, dynamic>) {
        final success = response['success'];
        final message = response['message'];

        if (success == false) {
          throw ApiError(message: message ?? 'Update profile failed');
        }

        /// 🔥 أهم جزء: نعمل refresh للبروفايل بعد التحديث
        final updatedUser = await getProfile();

        return updatedUser;
      } else {
        throw ApiError(message: 'Unexpected response');
      }
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }

//todo=> update profile
/*Future<UserModel> updateProfile(
    Map<String, dynamic> body,
    File? image,
  ) async {
    try {
      final endpoint = '/api/profile/update';

      /// 🧠 نحول البيانات لـ FormData
      final formData = FormData.fromMap({
        ...body,

        /// 🔥 لو فيه صورة بس
        if (image != null)
          "image": await MultipartFile.fromFile(
            image.path,
            filename: image.path.split('/').last,
          ),
      });

      final response = await apiService.put2(endpoint, data: formData);

      /// todo=> debug
      print("UPDATE RESPONSE => $response");

      if (response is ApiError) throw response;

      if (response is Map<String, dynamic>) {
        final success = response['success'];
        final message = response['message'];
        final data = response['data'];

        if (success == false || data == null) {
          throw ApiError(message: message ?? 'Update profile failed');
        }

        return UserModel.fromJson(
          Map<String, dynamic>.from(data),
        );
      } else {
        throw ApiError(message: 'Unexpected response');
      }
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }*/
}
