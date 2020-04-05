import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:wanandroidflutter/provider/provider_widget.dart';
import 'package:wanandroidflutter/ui/pages/user/login_field_widget.dart';
import 'package:wanandroidflutter/view_model/login_model.dart';

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
                  child: ProviderWidget<LoginModel>(
                    model: LoginModel(Provider.of(context)),
                    onModelReady: (model){
                      _nameController.text = model.getLoginName();
                    },
                    builder: (context, model, child){
                        return Form(
                          onWillPop: () async{
                            return !model.isBusy;
                          },
                          child: child,
                        );
                    },

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
                        LoginButton(_nameController, _passwordController)
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

class LoginButton extends StatelessWidget {
  final nameController;
  final passwordController;

  LoginButton(this.nameController, this.passwordController);

  @override
  Widget build(BuildContext context) {
    var model = Provider.of<LoginModel>(context);
    return LoginButtonWidget(
      child: model.isBusy
          ? ButtonProgressIndicator()
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


class ButtonProgressIndicator extends StatelessWidget {

  final double size;
  final Color color;

  ButtonProgressIndicator(
      { this.size: 24, this.color: Colors.white});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: size,
        height: size,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation(color),
        ));
  }
}


/// LoginPage 按钮样式封装
class LoginButtonWidget extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;

  LoginButtonWidget({this.child, this.onPressed});

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context).primaryColor.withAlpha(180);
    return Padding(
        padding: const EdgeInsets.fromLTRB(15, 40, 15, 20),
        child: CupertinoButton(
          padding: EdgeInsets.all(0),
          color: color,
          disabledColor: color,
          borderRadius: BorderRadius.circular(110),
          pressedOpacity: 0.5,
          child: child,
          onPressed: onPressed,
        ));
  }
}

