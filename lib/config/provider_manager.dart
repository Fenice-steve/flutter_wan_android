import 'package:provider/provider.dart';
import 'package:wanandroidflutter/view_model/user_model.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> providers = [

];

/**
 * ChangeNotifierProxyProvider组合了两种功能：
    （1）它会自动订阅CartModel中的更改（如果您只想使用此功能，只需使用ChangeNotifierProvider）
    （2）它采用先前提供的对象的值（在本例中为CatalogModel，如上所述），并使用它来构建CartModel的值（如果您只需要此功能，只需使用ProxyProvider）
 */
///  UserModel依赖globalFavouriteStateModel
List<SingleChildWidget> dependentServices = [
  ChangeNotifierProxyProvider<UserModel>(create: null, update: null)
];