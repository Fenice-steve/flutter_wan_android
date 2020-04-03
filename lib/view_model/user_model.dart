import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wanandroidflutter/config/storage_manager.dart';
import 'package:wanandroidflutter/model/user.dart';

/// 用户是否登录
class UserModel extends ChangeNotifier{
  static const String wanUser = 'wanUser';

  User _user;

  User get user => _user;

  bool get hasUser => user != null;

  UserModel(){
    var userMap = StorageManager.localStorage.getItem(wanUser);
    _user = userMap != null ? User.fromJsonMap(userMap) : null;
  }


  saveUser(User user){
    _user = user;
    notifyListeners();
    StorageManager.localStorage.setItem(wanUser, user);
  }

  clearUser(){
    _user = null;
    notifyListeners();
    StorageManager.localStorage.deleteItem(wanUser);
  }



}