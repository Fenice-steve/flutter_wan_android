import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

/// LoginPage 按钮样式封装
class LoginButtonWidget extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;

  LoginButtonWidget({this.child, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return  Container(
      decoration:
      BoxDecoration(borderRadius: BorderRadius.circular(3), boxShadow: [
        BoxShadow(
            color: Theme.of(context).primaryColor,
            blurRadius: 12.5,
            offset: Offset(0, 1))
      ]),
      margin: EdgeInsets.only(top: 40),
      width: ScreenUtil().setWidth(1000),
      height: ScreenUtil().setHeight(150),
      child: FlatButton(
          color: Theme.of(context).primaryColor,
          onPressed: onPressed,
          child: child),
    );
  }
}