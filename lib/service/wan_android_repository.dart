import 'package:wanandroidflutter/config/net/wan_android_api.dart';
import 'package:wanandroidflutter/model/user.dart';

class WanAndroidRepository{

  /// 登录
  /// [Http._init] 添加了拦截器 设置自动cookie
  static Future login(String username, String password)async{
    var response = await http.post<Map>('user/login', queryParameters: {'username':username, 'password':password});
    return User.fromJsonMap(response.data);
  }

  /// 注册
  static Future register(
      String username, String password, String rePassword) async {
    var response = await http.post<Map>('user/register', queryParameters: {
      'username': username,
      'password': password,
      'repassword': rePassword,
    });
    return User.fromJsonMap(response.data);
  }

  /// 登出
  static logout() async {
    /// 自动移除cookie
    await http.get('user/logout/json');
  }

}