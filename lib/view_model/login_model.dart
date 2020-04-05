import 'package:wanandroidflutter/config/storage_manager.dart';
import 'package:wanandroidflutter/provider/view_state_model.dart';
import 'package:wanandroidflutter/service/wan_android_repository.dart';
import 'package:wanandroidflutter/view_model/user_model.dart';


const String WanLoginName = 'WanLoginName';

class LoginModel extends ViewStateModel{
  final UserModel userModel;

  LoginModel(this.userModel) : assert(userModel!=null);

  String getLoginName(){
    return StorageManager.sharedPreferences.getString(WanLoginName);
  }

  Future<bool> login(loginName, password) async{
    setBusy();
    try{
      var user = await WanAndroidRepository.login(loginName, password);
      userModel.saveUser(user);
      StorageManager.sharedPreferences.setString(WanLoginName, userModel.user.username);
      setIdle();
      return true;
    }catch(e, s){
      setError(e, s);
      return false;
    }
  }

  Future logout() async{
    if(!userModel.hasUser){
      return false;
    }
    setBusy();
    try{
      await WanAndroidRepository.logout();
      userModel.clearUser();
      setIdle();
      return true;
    }catch(e, s){
      setError(e, s){
        return false;
      }
    }
  }


}