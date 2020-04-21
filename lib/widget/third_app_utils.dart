import 'package:url_launcher/url_launcher.dart';

class ThirdAppUtils {
  static Future<String> canOpenApp(url) async {
    Uri uri = Uri.parse(url);
    var scheme;
    switch (uri.host) {
      case 'www.jianshu.com': // 简书
        scheme = 'jianshu://${uri.pathSegments.join("/")}';
        break;
      case 'juejin.im': // 掘金
        scheme = 'juejin://${uri.pathSegments.join("/")}';
        break;
      default:
        break;
    }
    if(await canLaunch(scheme)){
      return scheme;
    }else{
      throw 'Could not launch $url';
    }
  }

  static openAppByUrl(url)async{
    await launch(url);
  }
}
