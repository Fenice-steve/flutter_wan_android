import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:wanandroidflutter/model/article.dart';
import 'package:wanandroidflutter/ui/pages/article/article_detail_page.dart';
import 'package:wanandroidflutter/ui/pages/user/login_page.dart';
import 'package:wanandroidflutter/ui/pages/user/rank_list_page.dart';
import 'package:wanandroidflutter/ui/pages/user/register_page.dart';

class RouteName {
  static const String tab = '/';
  static const String login = 'login';
  static const String rank = 'rank';
  static const String register = 'register';
  static const String articleDetail = 'articleDetail';
}

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.login:
        return CupertinoPageRoute(builder: (_) => LoginPage());
      case RouteName.register:
        return CupertinoPageRoute(builder: (_) => RegisterPage());
      case RouteName.rank:
        return CupertinoPageRoute(builder: (_) => CoinRankListPage());
      case RouteName.articleDetail:
        var article = settings.arguments as Article;
        return CupertinoPageRoute(
            builder: (_) =>
                // 根据配置调用页面
                ArticleDetailPage(article));
      default:
        return CupertinoPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ));
    }
  }
}

/// Pop路由
class PopRoute extends PopupRoute {
  final Duration _duration = Duration(milliseconds: 300);
  Widget child;

  PopRoute({@required this.child});

  @override
  Color get barrierColor => null;

  @override
  bool get barrierDismissible => true;

  @override
  String get barrierLabel => null;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return child;
  }

  @override
  Duration get transitionDuration => _duration;
}
