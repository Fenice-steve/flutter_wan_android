import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/foundation.dart';
import 'api.dart';
import 'package:wanandroidflutter/config/storage_manager.dart';

final Http http = Http();

class Http extends BaseHttp {
  @override
  void init() {
    options.baseUrl = 'https://www.wanandroid.com/';
    interceptors
      ..add(ApiInterceptor())
      ..add(CookieManager(
          PersistCookieJar(dir: StorageManager.temporaryDirectory.path)));
  }
}

/// 玩Android API
class ApiInterceptor extends InterceptorsWrapper {
  @override
  onRequest(RequestOptions options) async {
    debugPrint('---api-request--->url--> ${options.baseUrl}${options.path}' +
        ' queryParameters: ${options.queryParameters}');
    return options;
  }

  @override
  Future onResponse(Response response) {
    ResponseData responseData = ResponseData.fromJson(response.data);
    if(responseData.success){
      response.data = responseData.data;
      return http.resolve(response);
    }else{
      if(responseData.code == -1001){
        // 如果cookie过期,需要清除本地存储的登录信息
        // StorageManager.localStorage.deleteItem(UserModel.keyUser);
        throw const UnAuthorizedException(); // 需要登录
      }else{
        throw NotSuccessException.fromRespData(responseData);
      }
    }
    return super.onResponse(response);
  }
}

class ResponseData extends BaseResponseData{
  @override
  bool get success => 0 == code;

  ResponseData.fromJson(Map<String, dynamic> json){
    code = json['errorCode'];
    message = json['errorMsg'];
    data = json['data'];
  }

}
