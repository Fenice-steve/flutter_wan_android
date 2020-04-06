import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wanandroidflutter/widget/diy_textfield.dart';

/// 注册页面
class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _rePasswordController = TextEditingController();
  final _pwdFocus = FocusNode();
  final _pwdNextFocus = FocusNode();


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            '注册',
            style: TextStyle(
                color: Theme.of(context).cardColor,
                fontSize: ScreenUtil().setSp(54)),
          ),
          brightness: Theme.of(context).brightness,
          centerTitle: true,
          primary: true,
          leading: IconButton(
            icon: Icon(
              Icons.close,
              size: 25,
              color: Theme.of(context).cardColor,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            child: Column(
              children: <Widget>[
                DiyTextField(
                  leading: '用户名',
                  label: '用户名',
                  controller: _nameController,
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (text){
                    FocusScope.of(context).requestFocus(_pwdFocus);
                  },
                ),
                DiyTextField(
                  leading: '密码',
                  controller: _passwordController,
                  obscureText: true,
                  label: '密码',
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (text){
                    FocusScope.of(context).requestFocus(_pwdNextFocus);
                  },
                  focusNode: _pwdFocus,
                ),
                DiyTextField(
                  leading: '密码',
                  obscureText: true,

                  controller: _rePasswordController,
                  label: '密码',
                  textInputAction: TextInputAction.done,
                  focusNode: _pwdNextFocus,
                ),

                Container(
                  margin: EdgeInsets.only(left: 12,top: 12),
                  alignment: Alignment.centerLeft,
                  child:  Text.rich(TextSpan(children: [
                  TextSpan(
                      text: '注册即表明同意胡润百富的',
                      style:
                      TextStyle(fontSize: ScreenUtil().setSp(30))),
                  TextSpan(
                      text: '服务及隐私条款',
                      recognizer: TapGestureRecognizer()..onTap = ()async{
                        // 点击跳转
//                        Navigator.of(context).pushNamed(RouteName.provisions);
                      },
                      style: TextStyle(
                          fontSize: ScreenUtil().setSp(30),
                          decoration: TextDecoration.underline)),
                ])),),

//                LoginButton(
//                  onPressed: (){
//                      Navigator.of(context).pushNamed(RouteName.set_password);
//                  },
//                  child: Text('下一步'),),
                Container(
                  margin: EdgeInsets.only(right: 15, top: 15),
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
//                      Navigator.of(context).pushNamed(RouteName.login);
                    },
                    child: Text('已有账号？ 去登录'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
