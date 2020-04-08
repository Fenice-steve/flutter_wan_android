import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wanandroidflutter/provider/provider_widget.dart';
import 'package:wanandroidflutter/routers/fluro_navigator.dart';
import 'package:wanandroidflutter/view_model/coin_model.dart';
import 'package:wanandroidflutter/view_model/user_model.dart';

// 判断索引大小
isIndexSize(index) {
  if (index < 4) {
    return false;
  } else {
    return true;
  }
}

// 选择1，2，3名图片
selectRankImage(rankIndex){
  switch(rankIndex){
    case 1:
      return 'assets/images/rat.png';
    case 2:
      return 'assets/images/ox.png';
    case 3:
      return 'assets/images/tiger.png';
    default:
      return ' ';
  }
}

/// 积分排行榜
class CoinRankListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    UserModel userModel = Provider.of<UserModel>(context);
    String selfName = userModel.user.username.replaceRange(1, 3, '**');
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '积分排行榜',
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
      ),
      body: ProviderWidget<CoinRankingListModel>(
        model: CoinRankingListModel(),
        onModelReady: (model) => model.initData(),
        builder: (context, model, child) {
          if (model.isBusy) {
            return Container();
          } else if (model.isError && model.list.isEmpty) {
            return Container();
          } else if (model.isEmpty) {
            return Container();
          }
          return SmartRefresher(
            controller: model.refreshController,
            header: WaterDropHeader(),
            footer: ClassicFooter(),
            onRefresh: model.refresh,
            onLoading: model.loadMore,
            enablePullUp: true,
            child: ListView.separated(
              itemCount: model.list.length,
              separatorBuilder: (context, index) => Divider(
                indent: 10,
                endIndent: 10,
                height: 1,
              ),
              itemBuilder: (context, index) {
                Map item = model.list[index];
                String userName = item['username'];
                String coinCount = item['coinCount'].toString();
                return ListTile(
                  dense: true,
                  contentPadding: isIndexSize(index + 1)
                      ? EdgeInsets.symmetric(horizontal: 25, vertical: 10)
                      : EdgeInsets.only(
                          left: 8, right: 25, top: 10, bottom: 10),
                  onTap: () {
                    /// 跳转显示每个用户的详情
                  },
                  leading: isIndexSize(index + 1)
                      ? Text('${index + 1}')
                      :
                  Container(
                          child: Image.asset(selectRankImage(index + 1)),
                          margin: EdgeInsets.only(right: 10),
                        ),
                  title: Text(
                    userName,
                    style: TextStyle(
                        fontSize: 16,
                        color:
                            selfName == userName ? Colors.amberAccent : null),
                  ),
                  trailing: Text(
                    coinCount,
                    style: TextStyle(color: Theme.of(context).accentColor),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
