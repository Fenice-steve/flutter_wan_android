import 'package:wanandroidflutter/model/article.dart';
import 'package:wanandroidflutter/model/banner.dart';
import 'package:wanandroidflutter/provider/view_state_refresh_list_model.dart';
import 'package:wanandroidflutter/service/wan_android_repository.dart';

/// 首页model
class HomeModel extends ViewStateRefreshListModel {
  List<Banner> _banners;
  List<Article> _topArticles;

  List<Banner> get banners => _banners;
  List<Article> get topArticles => _topArticles;

  @override
  Future<List> loadData({int pageNum}) async {
    List<Future> futures = [];
    if (pageNum == ViewStateRefreshListModel.pageNumFirst) {
      futures
        ..add(WanAndroidRepository.fetchBanner())
        ..add(WanAndroidRepository.fetchTopArticles());
    }
    futures.add(WanAndroidRepository.fetchArticles(pageNum));

    var result = await Future.wait(futures);
    if (pageNum == ViewStateRefreshListModel.pageNumFirst) {
      _banners = result[0];
      _topArticles = result[1];
      return result[2];
    } else {
      return result[0];
    }
  }

}
