import 'package:dio/dio.dart';
import 'package:flutter_ithome/app/common/log.dart';

class HttpClient {
  static HttpClient? _httpUtil;

  static HttpClient get instance {
    _httpUtil ??= HttpClient();
    return _httpUtil!;
  }

  late Dio dio;
  HttpClient() {
    dio = Dio(
      BaseOptions(),
    );
    dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      Log.i(
        "【发起HTTP请求】\nMethod：${options.method}\nURL：${options.uri}\nQuery：${options.queryParameters}\nData：${options.data}\nHeaders：\n${options.headers}",
      );
      options.extra["ts"] = DateTime.now().millisecondsSinceEpoch;
      return handler.next(options);
    }, onResponse: (response, handler) {
      var time = DateTime.now().millisecondsSinceEpoch -
          response.requestOptions.extra["ts"];
      Log.i(
        '''【HTTP请求响应】 耗时:${time}ms
Request Method：${response.requestOptions.method}
Request Code：${response.statusCode}
Request URL：${response.requestOptions.uri}
Request Query：${response.requestOptions.queryParameters}
Request Data：${response.requestOptions.data}
Request Headers：${response.requestOptions.headers}
Response Headers：${response.headers.map}
Response Data：${response.data}''',
      );
      return handler.next(response);
    }, onError: (DioError e, handler) {
      var time =
          DateTime.now().millisecondsSinceEpoch - e.requestOptions.extra["ts"];
      Log.e('''【HTTP请求错误】 耗时:${time}ms
Request Method：${e.requestOptions.method}
Request Code：${e.response?.statusCode}
Request URL：${e.requestOptions.uri}
Request Query：${e.requestOptions.queryParameters}
Request Data：${e.requestOptions.data}
Request Headers：${e.requestOptions.headers}
Response Headers：${e.response?.headers.map}
Response Data：${e.response?.data}''', e.stackTrace ?? StackTrace.current);

      return handler.next(e);
    }));
  }

  /// Get请求，返回Map
  /// * [url] 请求链接
  /// * [queryParameters] 请求参数
  /// * [cancel] 任务取消Token
  Future<dynamic> getJson(
    String path, {
    Map<String, dynamic>? queryParameters,
    String baseUrl = "",
    CancelToken? cancel,
  }) async {
    Map<String, dynamic> header = {};
    queryParameters ??= {};
    var result = await dio.get(
      baseUrl + path,
      queryParameters: queryParameters,
      options: Options(
        responseType: ResponseType.json,
        headers: header,
      ),
      cancelToken: cancel,
    );

    return result.data;
  }
}
