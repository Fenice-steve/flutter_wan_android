import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:share/share.dart';
import 'package:wanandroidflutter/model/article.dart';
import 'package:wanandroidflutter/utils/string_utils.dart';
import 'package:wanandroidflutter/widget/app_bar.dart';
import 'package:wanandroidflutter/widget/third_app_utils.dart';
import 'package:webview_flutter/webview_flutter.dart';

/// 文章详情
class ArticleDetailPage extends StatefulWidget {
  final Article article;

  ArticleDetailPage(this.article);

  @override
  _ArticleDetailPageState createState() => _ArticleDetailPageState();
}

class _ArticleDetailPageState extends State<ArticleDetailPage> {
  WebViewController _webViewController;
  Completer<bool> _finishedCompleter = Completer();

  ValueNotifier canGoBack = ValueNotifier(false);
  ValueNotifier canGoForward = ValueNotifier(false);

  /// 打开第三方app
  Future canOpenAppFuture;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: WebViewTitle(
          title: widget.article.title,
          future: _finishedCompleter.future,
        ),
        actions: <Widget>[
          IconButton(
              tooltip: '打开浏览器',
              icon: Icon(Icons.language),
              onPressed: () {
                /// 打开浏览器
                ///
              }),
          WebViewPopupMenu(_webViewController, widget.article)
        ],
      ),
      body: SafeArea(
          bottom: false,
          child: WebView(
            // 初始化加载的url
            initialUrl: widget.article.link,
            // 加载js
            javascriptMode: JavascriptMode.disabled,
            navigationDelegate: (NavigationRequest request) {
              /// TODO isForMainFrame为false，页面不跳转，导致网页内很多链接点击没效果
              debugPrint('导航$request');
              if(!request.url.startsWith('http')){
                ThirdAppUtils.openAppByUrl(request.url);
                return NavigationDecision.prevent;
              }else{
                return NavigationDecision.navigate;
              }
            },
            onWebViewCreated: (WebViewController controller){
              _webViewController = controller;
              _webViewController.currentUrl().then((url){
                debugPrint('返回当前$url');
              });
            },
            onPageFinished: (String value) async{
              debugPrint('加载完成: $value');
              if(!_finishedCompleter.isCompleted){
                _finishedCompleter.complete(true);
              }
              refreshNavigator();
            },
          )),
      /// 待续
      bottomNavigationBar: BottomAppBar(


      ),
    );
  }

  /// 刷新导航按钮
  ///
  /// 目前主要用来控制 '前进','后退'按钮是否可以点击
  /// 但是目前该方法没有合适的调用时机.
  /// 在[onPageFinished]中,会遗漏正在加载中的状态
  /// 在[navigationDelegate]中,会存在页面还没有加载就已经判断过了.
  void refreshNavigator(){
    /// 是否可以后退
    _webViewController.canGoBack().then((value){
      debugPrint('canGoBack--->$value');
      return canGoBack.value = value;
    });

    /// 是否可以前进
    _webViewController.canGoForward().then((value){
      debugPrint('canGoForward--->$value');
      return canGoForward.value = value;
    });
  }
}

/// 分享按钮
class WebViewPopupMenu extends StatelessWidget {
  final WebViewController controller;
  final Article article;

  WebViewPopupMenu(this.controller, this.article);

  @override
  Widget build(BuildContext context) {
    /// 右侧弹出按钮
    return PopupMenuButton(
        itemBuilder: (context) => <PopupMenuEntry<int>>[
              PopupMenuItem(
                child: WebViewPopupMenuItem(Icons.share, '分享'),
                value: 2,
              )
            ],
        onSelected: (value) async {
          switch (value) {
            case 0:
              break;
            case 1:
              break;
            case 2:
              Share.share(article.title + ' ' + article.link);
              break;
          }
        });
  }
}

/// webView标题
class WebViewTitle extends StatelessWidget {
  final String title;
  final Future<bool> future;

  WebViewTitle({this.title, this.future});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        FutureBuilder(
            future: future,
            initialData: false,
            builder: (context, snapshot) => snapshot.data
                ? SizedBox.shrink()
                : Padding(
                    padding: EdgeInsets.only(right: 5),
                    child: AppBarIndicator(),
                  )),
        Expanded(
            child: Text(
          // 移除html标签
          StringUtils.removeHtmlLabel(title),
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontSize: 16),
        ))
      ],
    );
  }
}

/// webView弹出子项
class WebViewPopupMenuItem<T> extends StatelessWidget {
  final IconData iconData;
  final Color color;
  final String text;

  WebViewPopupMenuItem(this.iconData, this.text, {this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Icon(
          iconData,
          size: 20,
          color: Color ?? Theme.of(context).textTheme.body1.color,
        ),
        SizedBox(
          width: 20,
        ),
        Text(text)
      ],
    );
  }
}
