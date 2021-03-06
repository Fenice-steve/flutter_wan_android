import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:wanandroidflutter/routers/fluro_navigator.dart';
import 'package:wanandroidflutter/routers/router_manger.dart';
import 'package:wanandroidflutter/ui/pages/user/user_router.dart';
import 'package:wanandroidflutter/view_model/user_model.dart';

/// 我的页面
class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage>
    with AutomaticKeepAliveClientMixin {
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: MediaQuery.of(context).padding.top +
                ScreenUtil().setHeight(500),
            actions: <Widget>[
              GestureDetector(
                      child: Icon(Icons.equalizer),
                      onTap: () {
//                        NavigatorUtils.push(context, UserRouter.rankListPage);
                      Navigator.pushNamed(context, RouteName.rank);
                      }),
              SizedBox(
                width: ScreenUtil().setWidth(30),
              )
            ],
            pinned: false,
            flexibleSpace: UserHeaderWidget(),
          )
        ],
      ),
    );
  }
}

/// 用户页面头部
class UserHeaderWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserModel>(
        builder: (context, model, child) => GestureDetector(
              onTap: model.hasUser
                  ? null
                  : () {
                Navigator.pushNamed(context, RouteName.login);                    },
              child: Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(top: 60),
                child: Row(
                  children: <Widget>[
                    Container(
                        margin: EdgeInsets.symmetric(horizontal: 11.5),
//                decoration: BoxDecoration(
//                    border: Border.all(
//                        color: Colors.white,
//                        width: 1,
//                        style: BorderStyle.solid),
//                    borderRadius: BorderRadius.circular(2)),
                        child: Container(
//                  height: ScreenUtil().setHeight(168),
//                  width: ScreenUtil().setWidth(120),
                          child: ClipOval(
                            child: Image.asset('assets/images/user_avatar.png',
                                fit: BoxFit.cover,
                                width: 80,
                                height: 80,
                                color: Colors.yellow,
//                        model.hasUser ? Theme.of(context).accentColor.withAlpha(200) : Theme.of(context).accentColor
//                            .withAlpha(10),
                                // https://api.flutter.dev/flutter/dart-ui/BlendMode-class.html
                                colorBlendMode: BlendMode.colorDodge),
                          ),
                        )),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        // 响应区域为顶部全部
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Text(
                            model.hasUser ? model.user.username : '请登录',
                            style: TextStyle(
                                fontSize: ScreenUtil().setSp(56),
                                color: Colors.white),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(model.hasUser ? 'ID:${model.user.id}' : 'ID:请登录',
                              style: TextStyle(
                                  fontSize: ScreenUtil().setSp(50),
                                  color: Colors.white)),
                          SizedBox(
                            height: 3,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 11.5),
                      child: Icon(
                        Icons.arrow_forward_ios,
                        size: 15,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
            ));
  }
}
