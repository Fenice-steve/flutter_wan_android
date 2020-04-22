import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:quiver/strings.dart';
import 'package:wanandroidflutter/model/article.dart';
import 'package:wanandroidflutter/routers/router_manger.dart';
import 'package:wanandroidflutter/widget/image.dart';

/// 文章列表子Widget
class ArticleItemWidget extends StatelessWidget {
  final Article article;
  final int index;
  final GestureTapCallback onTap;

  /// 首页置顶
  final bool top;

  /// 隐藏收藏按钮
  final bool hideFavourite;

  ArticleItemWidget(this.article,
      {this.index, this.onTap, this.top: false, this.hideFavourite: false});

  @override
  Widget build(BuildContext context) {
    var backgroundColor = Theme.of(context).scaffoldBackgroundColor;

    return Stack(
      children: <Widget>[
        Material(
          color: top
              ? Theme.of(context).accentColor.withAlpha(10)
              : backgroundColor,
          child: InkWell(
            onTap: () {
              // 文章详情跳转
              Navigator.of(context)
                  .pushNamed(RouteName.articleDetail, arguments: article);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
              margin: const EdgeInsets.symmetric(horizontal: 20),
//              // 下滑线
//              decoration: BoxDecoration(
//                  border: Border(
//                      bottom: Divider.createBorderSide(context, width: 0.7))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      // 作者
                      Text(
                        isNotBlank(article.author)
                            ? article.author
                            : article.shareUser ?? '',
                        style: Theme.of(context).textTheme.caption,
                      ),
                      Expanded(child: SizedBox.shrink()),
                      // 更新日期
                      Text(
                        article.niceDate,
                        style: Theme.of(context).textTheme.caption,
                      )
                    ],
                  ),
                  if (article.envelopePic.isEmpty)
                    Padding(
                      padding: EdgeInsets.only(top: 7),
                      child: ArticleTitleWidget(article.title),
                    )
                  else
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              ArticleTitleWidget(article.title),
                              SizedBox(
                                height: 2,
                              ),
                              Text(
                                article.desc,
                                style: Theme.of(context).textTheme.caption,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        WrapperImage(
                            url: article.envelopePic, width: 60, height: 60)
                      ],
                    ),
                  Row(
                    children: <Widget>[
                      if (top) ArticleTag('置顶'),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 5),
                        child: Text(
                          (article.superChapterName != null
                                  ? article.superChapterName + ' · '
                                  : '') +
                              (article.chapterName ?? ''),
                          style: Theme.of(context).textTheme.overline,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}

class ArticleTitleWidget extends StatelessWidget {
  final String title;

  ArticleTitleWidget(this.title);

  @override
  Widget build(BuildContext context) {
    return Html(
      padding: EdgeInsets.symmetric(vertical: 5),
      useRichText: false,
      data: title,
      defaultTextStyle: Theme.of(context).textTheme.subtitle,
    );
  }
}

class ArticleTag extends StatelessWidget {
  final String text;
  final Color color;

  ArticleTag(this.text, {this.color});

  @override
  Widget build(BuildContext context) {
    var themeColor = color ?? Theme.of(context).accentColor;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 3,
        vertical: 0.5,
      ),
      margin: EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: color ?? themeColor)),
      child: Text(text,
          style: TextStyle(color: color ?? themeColor, fontSize: 10)),
    );
  }
}
