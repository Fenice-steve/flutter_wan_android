import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:wanandroidflutter/widget/search_bar.dart';


// 滚动最大距离
const APPBAR_SCROLL_OFFSET = 100;

double appBarAlpha = 0;
String resultString = "";
const SEARCH_BAR_DEFAULT_TEXT = '网红打卡地 景点 酒店 美食';



/// 玩安卓首页
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String city = '西安';

  _onScroll(offset) {
    // 滚动距离除以最大滚动距离
    double alpha = offset / APPBAR_SCROLL_OFFSET;
    // 处理滚动时的异常逻辑
    if (alpha < 0) {
      alpha = 0;
    } else if (alpha > 1) {
      alpha = 1;
    }
    setState(() {
      // appBar的透明度
      appBarAlpha = alpha;
    });
    print(appBarAlpha);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        // 移除顶部的Padding边距
        MediaQuery.removePadding(
            removeTop: true,
            context: context,
            child: RefreshIndicator(
                child: NotificationListener(
                    onNotification: (scrollNotification) {
                      // 判断是否是监听更新的对象
                      if (scrollNotification
                      is ScrollUpdateNotification &&
                          // 从最外层Widget开始向下遍历查找
                          scrollNotification.depth == 0) {
                        // 滚动且是列表滚动的时候
                        _onScroll(scrollNotification.metrics.pixels);
                      }
                      return false;
                    },
                    child: _listView),
                onRefresh: _handleRefresh
            )),
        _appBar
      ],
    );
  }


  /// 自定义appBar
  Widget get _appBar {
    return // 透明Widget，opacity是必要参数
      Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0x66000000), Colors.transparent],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter),
            ),
            child: Container(
              padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
              height: 80,
              decoration: BoxDecoration(
                  color:
                  Color.fromARGB((appBarAlpha * 255).toInt(), 255, 255, 255)),
              child: SearchBar(
                searchBarType: appBarAlpha > 0.2
                    ? SearchBarType.homeLight
                    : SearchBarType.home,
//                inputBoxClick: _jumpToSearch,
//                speakClick: _jumpToSpeak,
                defaultText: SEARCH_BAR_DEFAULT_TEXT,
//                leftButtonClick: _jumpToCity,
                city: city,
              ),
            ),
          ),

          Container(
            height: appBarAlpha > 0.2 ? 0.5:0,
            decoration: BoxDecoration(boxShadow: [BoxShadow(color: Colors.black12,blurRadius: 0.5)]),
          )
        ],
      );
  }


  /// 加载首页数据
  Future<Null> _handleRefresh() async {


    return null;
  }


  /// ListView列表
  Widget get _listView {
    return ListView(
      children: <Widget>[
        _banner,

       Container()
      ],
    );
  }


  /// banner轮播图
  Widget get _banner {
    return Container(
      height: 160,
      child: Text('测试')

//      Swiper(
//        itemCount: bannerList.length,
//        autoplay: true,
//        // Swiper指示器
//        pagination: SwiperPagination(),
//        itemBuilder: (BuildContext context, int index) {
//          return Image.network(
//            bannerList[index].icon,
//            fit: BoxFit.fill,
//          );
//        },
//        onTap: (index) {
//          Navigator.push(
//              context,
//              MaterialPageRoute(
//                  builder: (context) => WebView(
//                    url: bannerList[index].url,
//                    hideAppBar: bannerList[index].hideAppBar,
//                    title: bannerList[index].title,
//                  )));
//        },
//      ),
    );
  }
}
