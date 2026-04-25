import 'package:dio/dio.dart';
import 'package:fix_hub/UI/auth/data/user_model.dart';
import 'package:fix_hub/core/network/api_error.dart';
import 'package:fix_hub/core/network/api_exceptions.dart';
import 'package:fix_hub/core/network/api_service.dart';
import 'package:fix_hub/core/utils/pref_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/network/chat_services.dart';
import '../../home/data/models/craftsmans_model.dart';

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
        if (user.role == 'technical') {
          await PrefHelper.saveTechnician(
            Technician(
              id: user.id.toString(),
              name: user.name ?? '',
              phone: user.phone ?? '',
              city: user.city ?? '',
              specialty: user.profession ?? '',
            ),
          );
        }
        try {
          await ChatService().saveUserToFirebase(
            uid: user.id.toString(),
            name: user.name ?? "User",
            role: user.role ?? "normal",
            imageUrl: user.image,
          );
        } catch (e) {
          print("Firebase Login Sync Error: $e");
        }
        if (user.token != null) await PrefHelper.saveToken(user.token!);
        if (user.role != null) await PrefHelper.saveRole(user.role!);
        if (user.name != null) await PrefHelper.saveUserName(user.name!);
        if (user.id != null) {
          await PrefHelper.saveUserId(user.id.toString());
        }

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('user_id', user.id.toString());

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
        try {
          await ChatService().saveUserToFirebase(
            uid: user.id.toString(),
            // تأكد إن الـ ID موجود في الـ UserModel
            name: user.name ?? name,
            role: user.role ?? "null",
            imageUrl: user.image,
            // تأكد إن الـ UserModel فيه حقل للصورة
            email: "null", // اختياري
          );
        } catch (e) {
          print("Firebase Sync Error: $e");
          // مش بنعمل throw هنا عشان لو الفايربيز فشل لسبب ما، اليوزر يكمل دخول عادي
        }

        if (user.token != null) {
          await PrefHelper.saveToken(user.token!);
        }

        if (user.role != null) {
          await PrefHelper.saveRole(user.role!);
        }
        if (user.id != null) {
          await PrefHelper.saveUserId(user.id.toString());
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

        /// todo=> refresh=> getProfile
        final updatedUser = await getProfile();

        return updatedUser;
      } else {
        throw ApiError(message: 'Unexpected response');
      }
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }
}
