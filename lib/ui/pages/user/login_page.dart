import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:wanandroidflutter/provider/provider_widget.dart';
import 'package:wanandroidflutter/ui/pages/user/login_field_widget.dart';

/// 登录页面
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _pwdFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Column(
              children: <Widget>[
                Container(
                  child: ProviderWidget(
                    builder: (context, child, caca){

                    },
                    model: null,
                    child: Column(
                      children: <Widget>[
                        LoginTextField(
                          label: '用户名',
                          icon: Icons.person,
                          controller: _nameController,
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (text) {
                            FocusScope.of(context).requestFocus(_pwdFocus);
                          },
                        ),
                        LoginTextField(
                          controller: _passwordController,
                          label: '密码',
                          icon: Icons.lock_outline,
                          obscureText: true,
                          focusNode: _pwdFocus,
                          textInputAction: TextInputAction.done,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    ));
  }
}
