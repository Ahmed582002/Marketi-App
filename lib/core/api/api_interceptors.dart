import 'package:dio/dio.dart';
import 'package:store/features/Presentation/viewModel/cache/cache_helper.dart';
import 'end_ponits.dart';

class ApiInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = CacheHelper().getData(key: ApiKey.token);

    print("TOKEN => $token");

    options.headers.addAll({
      "Content-Type": "application/json",
      if (token != null) "Authorization": "Bearer $token",
    });

    super.onRequest(options, handler);
  }
}
