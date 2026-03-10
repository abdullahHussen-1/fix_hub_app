import 'package:dio/dio.dart';
import 'package:fix_hub/core/utils/pref_helper.dart';

class DioClient {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: 'apilink',
    headers: {
      'Content-Type': "headername",
    },
  ));
  DioClient() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        // todo send tocken when request
        onRequest: (options, handler) async{
          final tocken = await PrefHelper.getTocken(); 
          //todo check tocken
          if (tocken != null && tocken.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer$tocken';
          }
          return handler.next(options);
        },
      ),
    );
  }
  // todo get funcions to acces class
  Dio get dio => _dio;
}
