import 'package:wanandroidflutter/model/article.dart';
import 'package:wanandroidflutter/model/tree.dart';
import 'package:wanandroidflutter/model/wechat_tree.dart';
import 'package:wanandroidflutter/provider/view_state_list_model.dart';
import 'package:wanandroidflutter/provider/view_state_refresh_list_model.dart';
import 'package:wanandroidflutter/service/wan_android_repository.dart';

/// 微信公众号
class WechatAccountCategoryModel extends ViewStateListModel<Tree> {
  @override
  Future<List<Tree>> loadData() async {
    return await WanAndroidRepository.fetchWechatAccounts();
  }
}

///// 微信公众号
//class WechatAccountCategoryModel extends ViewStateListModel<WechatTree>{
//  @override
//  Future<List<WechatTree>> loadData() async{
//    return await WanAndroidRepository.fetchWechatAccounts();
//  }
//}


///// 微信公众号文章
//class WechatAccountArticleListModel extends ViewStateRefreshListModel<Article>{
//
//  // 公众号id
//  final int id;
//
//  WechatAccountArticleListModel(this.id);
//
//  @override
//  Future<List<Article>> loadData({int pageNum}) async{
//    return await WanAndroidRepository.fetchWechatAccountArticles(pageNum, id);
//  }
//
//}

/// 微信公众号文章
class WechatArticleListModel extends ViewStateRefreshListModel<Article> {
  /// 公众号id
  final int id;

  WechatArticleListModel(this.id);

  @override
  Future<List<Article>> loadData({int pageNum}) async {
    return await WanAndroidRepository.fetchWechatAccountArticles(pageNum, id);
  }

//  @override
//  onCompleted(List data) {
//    GlobalFavouriteStateModel.refresh(data);
//  }
}