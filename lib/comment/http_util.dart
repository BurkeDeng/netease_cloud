import 'package:bot_toast/bot_toast.dart';
import 'package:dio/dio.dart';

//http工具类   封装网络请求   单例模式

class HttpUtil {
  //服务根地址
  static final _baseUrl = ""; //接口地址

  //http接口跟地址
  static final _httpBaseUrl = "http://$_baseUrl";

  //单例模式
  static HttpUtil _instance;
  //dio实例
  static Dio _dio;
  //基础配置
  static BaseOptions _options;

  static HttpUtil getInstance() {
    if (HttpUtil._instance == null) {
      HttpUtil._instance = _httpUtil();
    }
    return HttpUtil._instance;
  }

  /*
   * 实例初始化配置
   */
  static _httpUtil() {
    //BaseOptions、Options、RequestOptions 都可以配置参数，优先级别依次递增，且可以根据优先级别覆盖参数
    HttpUtil._options = BaseOptions(
      //请求基地址
      baseUrl: _httpBaseUrl,
      //连接超时，单位--毫秒.
      connectTimeout: 10000,
      //响应流间隔时间，单位为毫秒。
      receiveTimeout: 5000,
      //请求的Content-Type，默认值"application/json; charset=utf-8",Headers.formUrlEncodedContentType自动编码请求体.
      contentType: Headers.formUrlEncodedContentType,
      //接受响应数据格式,四种类型 `json`, `stream`, `plain`, `bytes`. 默认值 `json`,
      responseType: ResponseType.json,
      //请求编码加密
      requestEncoder: null,
    );
    HttpUtil._dio = Dio(_options);
    //添加请求,响应,错误拦截器
    HttpUtil._dio.interceptors.add(InterceptorsWrapper(onRequest: _onRequest, onResponse: _onResponse, onError: _onError));
    return HttpUtil();
  }

  /*
   * get请求
   */
  Future<Response> get(String url, {Map<String, dynamic> data, Options options}) async {
    Response response;
    try {
      response = await _dio.get(url, queryParameters: data, options: options, cancelToken: CancelToken());
    } on DioError catch (e) {
      print("get erro---------$e");
    }
    return response;
  }

  /*
   * post请求
   */
  Future<Response> post(String url, {Map<String, dynamic> data, String plainData, Options options}) async {
    Response response;
    try {
      response = await _dio.post(url, data: plainData, queryParameters: data, options: options, cancelToken: CancelToken());
    } on DioError catch (e) {
      print("post erro---------$e");
    }
    return response;
  }

  /*
   *文件上传
   */
  Future<Response> uploadFile(url, {data, Options options}) async {
    Response response;
    try {
      response = await _dio.post(url, data: data, options: options, cancelToken: CancelToken());
    } on DioError catch (e) {
      print("post erro---------$e");
    }
    return response;
  }

  /*
   * 下载文件
   */
  Future<Response> downloadFile(urlPath, savePath) async {
    Response response;
    try {
      response = await _dio.download(
        urlPath,
        savePath,
        onReceiveProgress: (int count, int total) {
          //进度
          print("$count $total");
        },
        cancelToken: CancelToken(),
      );
    } on DioError catch (e) {
      print('downloadFile error---------$e');
    }
    return response.data;
  }

  //请求拦截器
  static _onRequest(RequestOptions options) async {
    //显示加载动画
  }

  //响应拦截
  static _onResponse(Response response) async {}

  //异常拦截
  static _onError(DioError e) {
    if (e.type == DioErrorType.CONNECT_TIMEOUT) {
      BotToast.showText(text: "连接超时");
    } else if (e.type == DioErrorType.SEND_TIMEOUT) {
      BotToast.showText(text: "请求超时");
    } else if (e.type == DioErrorType.RECEIVE_TIMEOUT) {
      BotToast.showText(text: "响应超时");
    } else if (e.type == DioErrorType.RESPONSE) {
      BotToast.showText(text: "出现异常");
    } else if (e.type == DioErrorType.CANCEL) {
      BotToast.showText(text: "取消请求");
    } else {
      BotToast.showText(text: "网络出错");
    }
  }
}
