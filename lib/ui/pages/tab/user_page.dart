import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

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

          )
        ],
      ),
    );
  }
}
