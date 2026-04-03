import 'package:dio/dio.dart';

import '../../../core/network/api_error.dart';
import '../../../core/network/api_exceptions.dart';
import '../../../core/network/api_service.dart';
import 'task_model.dart';

class TaskRepo {
  final ApiService apiService = ApiService();

  Future<List<TaskModel>> getTasks() async {
    try {
      final res = await apiService.get('tasks');// TODO: change to real endpoint

      final code = int.tryParse(res['code'].toString()) ?? 500; // TODO: change to real code key
      final data = res['data'];

      if (code != 200 && code != 201 || data == null) {
        throw ApiError(message: res['message']); // TODO: change to real message key
      }

      return List<TaskModel>.from(
        data.map((e) => TaskModel.fromJson(e)),
      );
    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }
}
