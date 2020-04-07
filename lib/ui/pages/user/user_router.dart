import 'package:fluro/fluro.dart';
import 'package:wanandroidflutter/routers/router_init.dart';
import 'package:wanandroidflutter/ui/pages/user/login_page.dart';
import 'package:wanandroidflutter/ui/pages/user/rank_list_page.dart';
import 'package:wanandroidflutter/ui/pages/user/register_page.dart';

class UserRouter implements InitRouterProvider{

  static String loginPage = '/login';
  static String registerPage = 'login/register';
  static String rankListPage = 'coin/rank';

  @override
  void initRouter(Router router) {
    router.define(loginPage, handler: Handler(handlerFunc: (_, params) => LoginPage()));
    router.define(registerPage, handler: Handler(handlerFunc: (_, params) => RegisterPage()));
    router.define(rankListPage, handler: Handler(handlerFunc: (_, params) => CoinRankListPage()));
  }

}