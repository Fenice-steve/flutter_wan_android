import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wanandroidflutter/provider/provider_widget.dart';
import 'package:wanandroidflutter/view_model/home_model.dart';
import 'package:wanandroidflutter/view_model/scroll_controller_model.dart';
import 'package:wanandroidflutter/widget/search_bar.dart';

// 滚动最大距离
const APPBAR_SCROLL_OFFSET = 100;

const double kHomeRefreshHeight = 180.0;

double appBarAlpha = 0;
String resultString = "";
const SEARCH_BAR_DEFAULT_TEXT = '网红打卡地 景点 酒店 美食';

/// 玩安卓首页
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin{

  @override
  bool get wantKeepAlive => true;

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
    var bannerHeight = MediaQuery.of(context).size.width * 5 / 11;

    return ProviderWidget2<HomeModel, TapToTopModel>(
      model1: HomeModel(),
      model2: TapToTopModel(PrimaryScrollController.of(context),
          height: bannerHeight - kHomeRefreshHeight),
      onModelReady: (homeModel, tapToTopModel) {
        homeModel.initData();
        tapToTopModel.init();
      },
      builder: (context, homeModel, tapToTopModel, child) {
        return Scaffold(
            body:
//            Stack(
//          children: <Widget>[
            // 移除顶部的Padding边距
            MediaQuery.removePadding(
                removeTop: true,
                context: context,
                child: Builder(builder: (_) {
                  if (homeModel.isError && homeModel.list.isEmpty) {
                    return Container(
                      child: Text('无数据'),
                    );
                  }

                  return RefreshConfiguration.copyAncestor(
                      context:context,
                      // 下拉触发二楼距离
                      twiceTriggerDistance: kHomeRefreshHeight - 15,
                      //最大下拉距离,android默认为0,这里为了触发二楼
                      maxOverScrollExtent: kHomeRefreshHeight,
                      headerTriggerDistance:
                      80 + MediaQuery.of(context).padding.top / 3,

                      child: NotificationListener(
                          onNotification: (scrollNotification) {
                            // 判断是否是监听更新的对象
                            if (scrollNotification
                                    is ScrollUpdateNotification &&
                                // 从外层Widget开始向下遍历查找
                                scrollNotification.depth == 0) {
                              // 滚动且是列表滚动的时候
                              _onScroll(scrollNotification.metrics.pixels);
                            }
                            return false;
                          },
                          child: SmartRefresher(
                              controller: homeModel.refreshController,
                              header: WaterDropHeader(),
                              footer: ClassicFooter(),
                              enablePullDown: homeModel.list.isNotEmpty,
                              onRefresh: () async{
                                await homeModel.refresh();
                                homeModel.showErrorMessage(context);
                              },
                          onLoading: homeModel.loadMore,
                          enablePullUp: homeModel.list.isNotEmpty,
                            child: ListView(
                              children: <Widget>[
                                Banner(),
                                Container()
                              ],
                            ),
                          )
                      ));
                })

//                RefreshIndicator(
//                    child: NotificationListener(
//                        onNotification: (scrollNotification) {
//                          // 判断是否是监听更新的对象
//                          if (scrollNotification is ScrollUpdateNotification &&
//                              // 从最外层Widget开始向下遍历查找
//                              scrollNotification.depth == 0) {
//                            // 滚动且是列表滚动的时候
//                            _onScroll(scrollNotification.metrics.pixels);
//                          }
//                          return false;
//                        },
//                        child: _listView),
//                    onRefresh: _handleRefresh)

//                ),

//          ],
        ));
      },
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
          height: appBarAlpha > 0.2 ? 0.5 : 0,
          decoration: BoxDecoration(
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 0.5)]),
        )
      ],
    );
  }


}

/// 首页Banner
class Banner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(color: Theme.of(context).scaffoldBackgroundColor),
      child: Consumer<HomeModel>(builder: (context, model, child) {
        if (model.isBusy) {
          return CupertinoActivityIndicator();
        } else {
          var banners = model?.banners ?? [];
          return Swiper(
            itemCount: banners.length,
            loop: true,
            autoplay: true,
            pagination: SwiperPagination(),
            autoplayDelay: 5000,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {},
                child: Image.network(banners[index].imagePath),
              );
            },
          );
        }
      }),
    );
  }
}
