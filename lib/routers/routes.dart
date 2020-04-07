import 'package:flutter/material.dart';
import 'package:wanandroidflutter/routers/404.dart';
import 'package:wanandroidflutter/routers/router_init.dart';
import 'package:wanandroidflutter/ui/pages/tab/tab_navigator.dart';
import 'package:fluro/fluro.dart';
import 'package:wanandroidflutter/ui/pages/user/user_router.dart';

class Routes{
  static String tab='/tab';

  static List<InitRouterProvider> _listRouter = [];

  static void configureRoutes(Router router){
    router.notFoundHandler= new Handler(
      handlerFunc: (BuildContext context,Map<String,List<String>> params){
        debugPrint('未找到目标页');
        return WidgetNotFound();
      }
    );

    router.define(tab,handler:Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) => TabNavigator()));

    _listRouter.clear();
    /// 各自路由由各自模块管理，同意再次添加
    _listRouter.add(UserRouter());

    /// 初始化路由
    _listRouter.forEach((routerProvider){
      routerProvider.initRouter(router);
    });
  }

}