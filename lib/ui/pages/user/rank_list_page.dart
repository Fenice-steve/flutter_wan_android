import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wanandroidflutter/provider/provider_widget.dart';
import 'package:wanandroidflutter/routers/fluro_navigator.dart';
import 'package:wanandroidflutter/view_model/coin_model.dart';
import 'package:wanandroidflutter/view_model/user_model.dart';

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
          } else if (model.isError && model.isEmpty) {
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
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                  onTap: () {
                    /// 跳转显示每个用户的详情
                  },
                  leading: Text('${index + 1}'),
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
