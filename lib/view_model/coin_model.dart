import 'package:wanandroidflutter/provider/view_state_model.dart';
import 'package:wanandroidflutter/service/wan_android_repository.dart';
import 'package:wanandroidflutter/provider/view_state_refresh_list_model.dart';

/// 积分排行榜
class CoinRankingListModel extends ViewStateRefreshListModel{
  @override
  Future<List> loadData({int pageNum}) async {
    return await WanAndroidRepository.fetchRankingList(pageNum);
  }
}