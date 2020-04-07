import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:wanandroidflutter/provider/provider_widget.dart';
import 'package:wanandroidflutter/routers/fluro_navigator.dart';
import 'package:wanandroidflutter/ui/pages/user/user_router.dart';
import 'package:wanandroidflutter/view_model/login_model.dart';
import 'package:wanandroidflutter/widget/diy_textfield.dart';
import 'package:wanandroidflutter/widget/login_widget.dart';

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
  void dispose() {
    _nameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '登录',
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
            NavigatorUtils.goBack(context);
          },
        ),
        actions: <Widget>[
//          Container(
//            margin: EdgeInsets.only(right: 12),
//            alignment: Alignment.centerLeft,
//            child: GestureDetector(
//                onTap: () {
////                      Navigator.of(context).pushNamed(RouteName.register);
//                  NavigatorUtils.push(context, UserRouter.registerPage);
//                },
//                child: Text(
//                  '注册',
//                  style: TextStyle(
//                    color: Theme.of(context).cardColor,
//                  ),
//                )),
//          ),
        ],
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Column(
              children: <Widget>[
                Container(
                  child: ProviderWidget<LoginModel>(
                    model: LoginModel(Provider.of(context)),
                    onModelReady: (model) {
                      _nameController.text = model.getLoginName();
                    },
                    builder: (context, model, child) {
                      return Form(
                        onWillPop: () async {
                          return !model.isBusy;
                        },
                        child: child,
                      );
                    },
                    child: Column(
                      children: <Widget>[
                        DiyTextField(
                          leading: '用户名',
                          label: '用户名',
                          controller: _nameController,
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (text) {
                            FocusScope.of(context).requestFocus(_pwdFocus);
                          },
                        ),
                        DiyTextField(
                          leading: '密码',
                          controller: _passwordController,
                          label: '密码',
                          obscureText: true,
                          focusNode: _pwdFocus,
                          textInputAction: TextInputAction.done,
                        ),
                        LoginButton(_nameController, _passwordController),
                        SingUpWidget(_nameController),
                        Container(
                          margin: EdgeInsets.only(top: 50),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
//

                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    color: Colors.black26,
                                    height: 0.6,
                                    width: 60,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Text(
                                      '第三方登录',
                                      style: TextStyle(
                                          fontSize: ScreenUtil().setSp(36)),
                                    ),
                                  ),
                                  Container(
                                    color: Colors.black26,
                                    height: 0.6,
                                    width: 60,
                                  ),
                                ],
                              ),

                              SizedBox(
                                height: 11.5,
                              ),
                              Container(
                                  margin: EdgeInsets.only(top: 30),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      GestureDetector(
                                        onTap: () {
                                          showToast('即将到来',
                                              position: ToastPosition.bottom);
                                        },
                                        child: Image.asset(
                                          'assets/images/icon_wechat.png',
//                                        color: Theme.of(context).cardColor,
                                          width: 30,
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          showToast('即将到来',
                                              position: ToastPosition.bottom);
                                        },
                                        child: Image.asset(
                                          'assets/images/alipay.png',
//                                        color: Theme.of(context).cardColor,
                                          width: 30,
                                        ),
                                      )
                                    ],
                                  )),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  final nameController;
  final passwordController;

  LoginButton(this.nameController, this.passwordController);

  @override
  Widget build(BuildContext context) {
    var model = Provider.of<LoginModel>(context);
    return LoginButtonWidget(
      child: model.isBusy
          ? CircularProgressIndicator()
          : Text(
              '登录',
              style: Theme.of(context)
                  .accentTextTheme
                  .title
                  .copyWith(wordSpacing: 6),
            ),
      onPressed: model.isBusy
          ? null
          : () {
              var formState = Form.of(context);
              if (formState.validate()) {
                model
                    .login(nameController.text, passwordController.text)
                    .then((value) {
                  if (value) {
                    Navigator.of(context).pop(true);
                  } else {
                    model.showErrorMessage(context);
                  }
                });
              }
            },
    );
  }
}

class SingUpWidget extends StatefulWidget {
  final nameController;

  SingUpWidget(this.nameController);

  @override
  _SingUpWidgetState createState() => _SingUpWidgetState();
}

class _SingUpWidgetState extends State<SingUpWidget> {
  TapGestureRecognizer _recognizerRegister;

  @override
  void initState() {
    _recognizerRegister = TapGestureRecognizer()
      ..onTap = () async {
        // 将注册成功的用户名,回填如登录框
        widget.nameController.text =
            await NavigatorUtils.push(context, UserRouter.registerPage);
      };
    super.initState();
  }

  @override
  void dispose() {
    _recognizerRegister.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 15, top: 15),
      alignment: Alignment.centerRight,
      child: Text.rich(TextSpan(text: '还没有账户？', children: [
        TextSpan(
            text: '去注册',
            recognizer: _recognizerRegister,
            style: TextStyle(color: Theme.of(context).accentColor))
      ])),
    );
  }
}
