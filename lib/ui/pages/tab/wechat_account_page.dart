import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:wanandroidflutter/model/wechat_tree.dart';
import 'package:wanandroidflutter/provider/provider_widget.dart';
import 'package:wanandroidflutter/provider/view_state_widget.dart';
import 'package:wanandroidflutter/utils/status_bar_utils.dart';
import 'package:wanandroidflutter/view_model/wechat_account_model.dart';

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
                error: model.viewStateError, onPressed: model.initData());
          }
          List<WechatTree> treeList = model.list;

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
                    // 待续
                  );
                })),
          );
        },
      ),
    );
  }
}
