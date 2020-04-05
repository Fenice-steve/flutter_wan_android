import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:wanandroidflutter/model/article.dart';

/// 是否收藏
class GlobalFavouriteStateModel extends ChangeNotifier{
  /// 将页面列表中所有的收藏状态操作结果存储到集合中
  ///
  /// [key]为articleId，[value]为bool类型，代表是否收藏
  ///
  /// 设置static的目的是，列表更新时，刷新该map的值
  static final Map<int, bool> _map = Map();

  /// 列表刷新后，同步刷新该map数据
  ///
  /// 在其他终端(如pc端)收藏/取消收藏后，会导致状态不一致
  /// 列表页面刷新后，应该将新的收藏状态同步更新到map
  static refresh(List<Article> list){
    list.forEach((article){
      if(_map.containsKey(article.id)){
        _map[article.id] = article.collect;
      }
    });
  }

  addFavourite(int id){
    _map[id] = true;
    notifyListeners();
  }

  removeFavourite(int id){
    _map[id] = false;
    notifyListeners();
  }

  replaceAll(List ids){
    _map.clear();
    ids.forEach((id)=>_map[id] = true);
    notifyListeners();
  }

  contains(id){
    return _map.containsKey(id);
  }

  operator[](int id){
    return _map[id];
  }
}