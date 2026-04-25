import 'package:dio/dio.dart';
import 'package:fix_hub/UI/auth/data/user_model.dart';
import 'package:fix_hub/UI/home/data/models/craftsmans_model.dart';
import 'package:fix_hub/core/network/api_error.dart';
import 'package:fix_hub/core/network/api_exceptions.dart';
import 'package:fix_hub/core/network/api_service.dart';
import 'package:fix_hub/core/utils/pref_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepo {
  final ApiService apiService = ApiService();

  // ================== LOGIN ==================
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
        // --- حفظ البيانات الأساسية محلياً ---
        if (user.token != null) await PrefHelper.saveToken(user.token!);
        if (user.role != null) await PrefHelper.saveRole(user.role!);
        if (user.name != null) await PrefHelper.saveUserName(user.name!);

        // 👈 التعديل المهم: حفظ الـ ID لاستخدامه في ربط التاسكات
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

  // ================== REGISTER ==================
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

        // --- حفظ البيانات الأساسية محلياً ---
        if (user.token != null) await PrefHelper.saveToken(user.token!);
        if (user.role != null) await PrefHelper.saveRole(user.role!);
        if (user.name != null) await PrefHelper.saveUserName(user.name!);

        // 👈 حفظ الـ ID عند التسجيل أيضاً لفلترة المهام لاحقاً
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('user_id', user.id.toString());

        return user;
      } else {
        throw ApiError(message: 'Unexpected response');
      }
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }

  // ================== LOGOUT ==================
  static Future<void> logout() async {
    try {
      await PrefHelper.clearAll();
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('user_id'); // حذف الـ ID عند تسجيل الخروج لضمان الأمان
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }

  // ================== GET PROFILE ==================
  Future<UserModel> getProfile() async {
    try {
      const endpoint = '/api/profile';
      final response = await apiService.get(endpoint);

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

        if (user.token != null) await PrefHelper.saveToken(user.token!);
        if (user.role != null) await PrefHelper.saveRole(user.role!);
        if (user.name != null) await PrefHelper.saveUserName(user.name!);

        // 👈 تحديث الـ ID المخزن لضمان دقته
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('user_id', user.id.toString());

        return user;
      } else {
        throw ApiError(message: 'Unexpected response');
      }
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }

  // ================== UPDATE PROFILE ==================
  Future<UserModel> updateProfile(Map<String, dynamic> body) async {
    try {
      const endpoint = '/api/profile/update';
      final response = await apiService.put(endpoint, body);

      print("UPDATE PROFILE RESPONSE => $response");
      if (response is ApiError) throw response;

      if (response is Map<String, dynamic>) {
        final success = response['success'];
        final message = response['message'];

        if (success == false) {
          throw ApiError(message: message ?? 'Update profile failed');
        }

        // جلب البيانات الجديدة بعد التحديث لضمان تحديث الـ SharedPreferences تلقائياً
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
