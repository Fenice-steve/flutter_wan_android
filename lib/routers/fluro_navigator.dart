import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

import 'application.dart';

///// fluro路由跳转工具
/////
///// clearStack移除所有路由
//class NavigatorUtils {
//  static push(BuildContext context, String path,
//      {bool replace = false, bool clearStack = false}) {
//    FocusScope.of(context).unfocus();
//    Application.router.navigateTo(context, path,
//        replace: replace,
//        clearStack: clearStack,
//        transition: TransitionType.native);
//  }
//
//  static pushResult(BuildContext context, String path, Function(Object) function, {bool replace = false, bool clearStack = false}){
//    FocusScope.of(context).unfocus();
//    Application.router.navigateTo(context, path, replace: replace, clearStack: clearStack, transition: TransitionType.native).then((result){
//      // 页面返回result为null
//      if(result == null){
//        return;
//      }
//      function(result);
//    }).catchError((error){
//      print('$error');
//    });
//  }
//
//  /// 返回
//  static void goBack(BuildContext context){
//    FocusScope.of(context).unfocus();
//    Navigator.pop(context);
//  }
//
//  /// 带参数返回
//  static void goBackWithParams(BuildContext context, result){
//    FocusScope.of(context).unfocus();
//    Navigator.pop(context, result);
//  }
//
//
//}


/// fluro的路由跳转工具类
class NavigatorUtils {

  static push(BuildContext context, String path,
      {bool replace = false, bool clearStack = false}) {
    FocusScope.of(context).unfocus();
    Application.router.navigateTo(context, path, replace: replace, clearStack: clearStack, transition: TransitionType.native);
  }

  static pushResult(BuildContext context, String path, Function(Object) function,
      {bool replace = false, bool clearStack = false}) {
    FocusScope.of(context).unfocus();
    Application.router.navigateTo(context, path, replace: replace, clearStack: clearStack, transition: TransitionType.native).then((result) {
      // 页面返回result为null
      if (result == null) {
        return;
      }
      function(result);
    }).catchError((error) {
      print('$error');
    });
  }

  /// 返回
  static void goBack(BuildContext context) {
    FocusScope.of(context).unfocus();
    Navigator.pop(context);
  }

  /// 带参数返回
  static void goBackWithParams(BuildContext context, result) {
    FocusScope.of(context).unfocus();
    Navigator.pop(context, result);
  }

}