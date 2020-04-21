import 'package:flutter/material.dart'
    hide DropdownButton, DropdownMenuItem, DropdownButtonHideUnderline;
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wanandroidflutter/model/article.dart';
import 'package:wanandroidflutter/model/tree.dart';
import 'package:wanandroidflutter/provider/provider_widget.dart';
import 'package:wanandroidflutter/provider/view_state_widget.dart';
import 'package:wanandroidflutter/utils/status_bar_utils.dart';
import 'package:wanandroidflutter/view_model/wechat_account_model.dart';
import 'package:wanandroidflutter/widget/article_list_item.dart';
import 'package:wanandroidflutter/widget/category_dropdown_widget.dart';

/// 微信公众号页面
class WechatAccountPage extends StatefulWidget {
  @override
  _WechatAccountPageState createState() => _WechatAccountPageState();
}

class _WechatAccountPageState extends State<WechatAccountPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  ValueNotifier<int> valueNotifier = ValueNotifier(0);
  TabController tabController;

  @override
  void dispose() {
    valueNotifier.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: StatusBarUtils.systemUiOverlayStyle(context),
      child: ProviderWidget<WechatAccountCategoryModel>(
        model: WechatAccountCategoryModel(),
        onModelReady: (model) {
          model.initData();
        },
        builder: (context, model, child) {
          if (model.isBusy) {
            return ViewStateBusyWidget();
          } else if (model.isError && model.list.isEmpty) {
            return ViewStateErrorWidget(
                error: model.viewStateError, onPressed: model.initData);
          }
//          List<WechatTree> treeList = model.list;
          List<Tree> treeList = model.list;

          var primaryColor = Theme.of(context).primaryColor;

          return ValueListenableProvider<int>.value(
            value: valueNotifier,
            child: DefaultTabController(
                length: model.list.length,
                initialIndex: valueNotifier.value,
                child: Builder(builder: (context) {
                  if (tabController == null) {
                    tabController = DefaultTabController.of(context);
                    tabController.addListener(() {
                      valueNotifier.value = tabController.index;
                    });
                  }
                  return Scaffold(
                    appBar: AppBar(
                      title: Stack(
                        children: <Widget>[
                          CategoryDropdownWidget(
                              Provider.of<WechatAccountCategoryModel>(context)),
                          Container(
                            margin: const EdgeInsets.only(right: 25),
                            color: primaryColor.withOpacity(1),
                            child: TabBar(
                                isScrollable: true,
                                tabs: List.generate(
                                    treeList.length,
                                    (index) => Tab(
                                          text: treeList[index].name,
                                        ))),
                          )
                        ],
                      ),
                    ),
                    body: TabBarView(
                        children: List.generate(
                            treeList.length,

                            ///
                            (index) =>
                                WechatAccountArticleList(treeList[index].id))),
                  );
                })),
          );
        },
      ),
    );
  }
}

/// 微信公众号文章列表
class WechatAccountArticleList extends StatefulWidget {
  final int id;

  WechatAccountArticleList(this.id);

  @override
  _WechatAccountArticleListState createState() =>
      _WechatAccountArticleListState();
}

class _WechatAccountArticleListState extends State<WechatAccountArticleList>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<WechatArticleListModel>(
      model: WechatArticleListModel(widget.id),
      onModelReady: (model) => model.initData(),
      builder: (context, model, child) {
        if (model.isBusy) {
          /// 骨架
          return Container();
        } else if (model.isError) {
          return ViewStateErrorWidget(
              error: model.viewStateError, onPressed: model.initData);
        } else if (model.isEmpty) {
          return ViewStateEmptyWidget(onPressed: model.initData);
        }
        return SmartRefresher(
          controller: model.refreshController,
          header: WaterDropHeader(),
          footer: ClassicFooter(),
          onRefresh: model.refresh,
          onLoading: model.loadMore,
          enablePullUp: true,
          child: ListView.builder(
              itemCount: model.list.length,
              itemBuilder: (context, index) {
                Article item = model.list[index];
                return ArticleItemWidget(item);
              }),
        );
      },
    );
  }
}
