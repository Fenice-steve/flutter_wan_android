
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 我的页面
class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: MediaQuery.of(context).padding.top + ScreenUtil().setHeight(700),
            actions: <Widget>[
              GestureDetector(child: Icon(Icons.equalizer), onTap: (){}),
              SizedBox(width: ScreenUtil().setWidth(30),)
            ],
            pinned: true,
            flexibleSpace: UserHeaderWidget(),
          )
        ],
      ),
    );
  }
}

/// 我的页面头部
class UserHeaderWidget extends StatefulWidget {
  @override
  _UserHeaderWidgetState createState() => _UserHeaderWidgetState();
}

class _UserHeaderWidgetState extends State<UserHeaderWidget> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

