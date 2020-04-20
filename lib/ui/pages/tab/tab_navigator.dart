import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wanandroidflutter/ui/pages/tab/home_page.dart';
import 'package:wanandroidflutter/ui/pages/tab/user_page.dart';
import 'package:wanandroidflutter/ui/pages/tab/wechat_account_page.dart';

/// 底部导航栏
class TabNavigator extends StatefulWidget {
  @override
  _TabNavigatorState createState() => _TabNavigatorState();
}

List<Widget> pages = <Widget>[HomePage(),WechatAccountPage(),UserPage()];

class _TabNavigatorState extends State<TabNavigator> {
  var _pageController = PageController();
  DateTime _lastPressed;
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {

    // 小米10全面屏尺寸
    ScreenUtil.init(context, width: 1080, height: 2340, allowFontScaling: true);

    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          if (_lastPressed == null ||
              DateTime.now().difference(_lastPressed) > Duration(seconds: 1)) {
            // 两次点击超过一秒则重新计时
            _lastPressed = DateTime.now();
            return false;
          }
          return true;
        },
        child: PageView.builder(
          itemCount: pages.length,
          itemBuilder: (context, index) => pages[index],
          controller: _pageController,
          physics: NeverScrollableScrollPhysics(),
          onPageChanged: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: _selectedIndex == 0 ? Container() : Text('首页'),
              activeIcon: Icon(
                Icons.vertical_align_top,
                size: 32,
              )),

          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text('公众号'),
              activeIcon: Icon(
                Icons.person,
//                size: 32,
              )),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text('我的'),
              activeIcon: Icon(
                Icons.person,
//                size: 32,
              )),
        ],
        currentIndex: _selectedIndex,
        onTap: (index) {
          _pageController.jumpToPage(index);
        },
      ),
    );
  }
}
