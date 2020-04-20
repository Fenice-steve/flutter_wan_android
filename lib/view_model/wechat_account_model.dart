import 'package:wanandroidflutter/model/article.dart';
import 'package:wanandroidflutter/model/wechat_tree.dart';
import 'package:wanandroidflutter/provider/view_state_list_model.dart';
import 'package:wanandroidflutter/service/wan_android_repository.dart';

/// 微信公众号
class WechatAccountCategoryModel extends ViewStateListModel<WechatTree>{
  @override
  Future<List<WechatTree>> loadData() async{
    return await WanAndroidRepository.fetchWechatAccounts();
  }

}