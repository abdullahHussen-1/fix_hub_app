import 'dart:convert';

import 'package:fix_hub/UI/addReview/data/reviewModel.dart';
import 'package:fix_hub/UI/home/data/models/craftsmans_model.dart';
import 'package:fix_hub/UI/tasks/data/task_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefHelper {
  static const String _tokenKey = 'auth_token';
  static const String _roleKey = 'user_role';
  static const String _userNameKey = 'user_name';
  static const String _techKey = 'technicians';
  static const String _reviewsKey = "reviews";
  static const String _userIdKey = 'user_id';

  // ================== AUTH & USER ==================

  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  static Future<void> saveRole(String role) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_roleKey, role);
  }

  static Future<String?> getRole() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_roleKey);
  }

  // حفظ اسم المستخدم (مهم جداً لصفحة Add Review)
  static Future<void> saveUserName(String name) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userNameKey, name);
  }

  static Future<String?> getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userNameKey);
  }

  static Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    //await prefs.clear(); // حذف كل البيانات عند تسجيل الخروج
    await prefs.remove(_tokenKey);
    await prefs.remove(_roleKey);
  }

  static Future<void> saveUserId(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userIdKey, userId);
    print("User ID saved to local storage: $userId");
  }

  static Future<String> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userIdKey) ?? '';
  }

  // ================== TECHNICIANS ==================

  static Future<void> saveTechnician(Technician tech) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> list = prefs.getStringList(_techKey) ?? [];

    List<Technician> all =
        list.map((e) => Technician.fromJson(jsonDecode(e))).toList();

    int index = all.indexWhere((t) => t.id == tech.id);
    if (index != -1) {
      all[index] = tech; // تحديث لو موجود
    } else {
      all.add(tech); // إضافة لو جديد
    }

    List<String> updated = all.map((e) => jsonEncode(e.toJson())).toList();
    await prefs.setStringList(_techKey, updated);
  }

  static Future<List<Technician>> getTechnicians() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> list = prefs.getStringList(_techKey) ?? [];
    return list.map((e) => Technician.fromJson(jsonDecode(e))).toList();
  }

  static Future<List<Technician>> getByCategory(String category) async {
    final all = await getTechnicians();
    return all.where((e) => e.specialty == category).toList();
  }

  // ================== REVIEWS ==================

  static Future<void> addReview(ReviewModel review) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> list = prefs.getStringList(_reviewsKey) ?? [];

    list.add(jsonEncode(review.toJson()));
    await prefs.setStringList(_reviewsKey, list);
  }

  static Future<List<ReviewModel>> getReviews() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> list = prefs.getStringList(_reviewsKey) ?? [];
    return list.map((e) => ReviewModel.fromJson(jsonDecode(e))).toList();
  }

  // جلب ريفيوهات فني معين فقط (مهمة جداً للـ ReviewsTab)
  static Future<List<ReviewModel>> getReviewsByTech(String techId) async {
    final all = await getReviews();
    return all.where((r) => r.technicianId == techId).toList();
  }

  static const String _tasksKey = "user_requests";

  static Future<void> saveTask(TaskModel task) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> list = prefs.getStringList(_tasksKey) ?? [];
    list.add(jsonEncode(task.toJson()));
    await prefs.setStringList(_tasksKey, list);
  }

  static Future<List<TaskModel>> getTasksByTech(String techId) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> list = prefs.getStringList(_tasksKey) ?? [];

    return list
        .map((e) => TaskModel.fromJson(jsonDecode(e)))
        .where((task) => task.technicianId == techId)
        .toList();
  }

// دالة لمسح ID الفني الحالي (مفيدة لمعرفة من هو الفني المسجل الآن)
  static Future<String?> getCurrentUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('user_id');
  }

  // أضف هذا الكود داخل كلاس PrefHelper
  static Future<void> deleteTask(String taskId) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> list = prefs.getStringList(_tasksKey) ?? [];

    // فلترة القائمة وحذف التاسك المطابق للـ id
    list.removeWhere((item) {
      final task = TaskModel.fromJson(jsonDecode(item));
      return task.id == taskId;
    });

    await prefs.setStringList(_tasksKey, list);
  }
}
