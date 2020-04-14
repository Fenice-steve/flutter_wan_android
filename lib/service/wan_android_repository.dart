import 'package:wanandroidflutter/config/net/wan_android_api.dart';
import 'package:wanandroidflutter/model/article.dart';
import 'package:wanandroidflutter/model/user.dart';
import 'package:wanandroidflutter/model/banner.dart';

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


  /// 积分排行榜
  static Future fetchRankingList(int pageNum) async {
    var response = await http.get('coin/rank/$pageNum/json');
    return response.data['datas'];
  }
  
  /// 首页banner
  static Future fetchBanner() async{
    var response = await http.get('banner/json');
//    return Banner.fromJsonMap(response.data);
  return response.data.map<Banner>((item)=>Banner.fromJsonMap(item)).toList();
  }

  /// 置顶文章
  static Future fetchTopArticles() async{
    var response = await http.get('article/top/json');
//    return Article.fromJsonMap(response.data);
    response.data.map<Article>((item) => Article.fromJsonMap(item)).toList();
  }
  
  /// 文章
  static Future fetchArticles(int pageNum, {int cid})async{
    await Future.delayed(Duration(seconds: 1));// 增加动效
    var response = await http.get('article/list/$pageNum/json', queryParameters: (cid != null ? {'cid':cid}:null));
//    return Article.fromJsonMap(response.data);
    return response.data['datas']
        .map<Article>((item) => Article.fromJsonMap(item))
        .toList();
  }
}