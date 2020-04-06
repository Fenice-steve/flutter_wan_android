import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:wanandroidflutter/ui/pages/user/login_page.dart';
import 'package:wanandroidflutter/ui/pages/user/register_page.dart';


var loginHandler =Handler(
  handlerFunc: (BuildContext context,Map<String,List<String>> params){
    return LoginPage();
  }
);

var registerHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params){
    return RegisterPage();
  }
);