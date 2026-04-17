import 'package:dio/dio.dart';
import 'package:fix_hub/core/utils/pref_helper.dart';

class DioClient {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: "https://web-production-82531.up.railway.app",
    headers: {
      'Content-Type': 'application/json',
    },
  ));

  DioClient() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        // todo send tocken when request
        onRequest: (options, handler) async {
          final token = await PrefHelper.getToken();
          //todo check tocken
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
      ),
    );
  }

  // todo get funcions to acces class
  Dio get dio => _dio;
}
