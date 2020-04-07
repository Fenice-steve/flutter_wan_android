import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:wanandroidflutter/config/provider_manager.dart';
import 'package:wanandroidflutter/config/storage_manager.dart';
import 'package:wanandroidflutter/routers/routes.dart';
import 'package:wanandroidflutter/ui/pages/tab/tab_navigator.dart';
import 'package:fluro/fluro.dart';
import 'routers/application.dart';

main() async {
  Provider.debugCheckInvalidValueType = null;
  WidgetsFlutterBinding.ensureInitialized();
  await StorageManager.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // 创建一个Router对象
    final router = Router();
    // 配置Routes注册管理
    Routes.configureRoutes(router);
    // 将生成的router给全局化
    Application.router=router;

    return OKToast(
        child: MultiProvider(
      providers: providers,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: Application.router.generator,
        home: TabNavigator(),
      ),
    ));
  }
}
