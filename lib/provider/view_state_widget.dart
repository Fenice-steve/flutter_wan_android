import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:wanandroidflutter/config/resource_mananger.dart';
import 'view_state.dart';

///  加载中
class ViewStateBusyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}

/// 基础的Widget
class ViewStateWidget extends StatelessWidget {
  final String title;
  final String message;
  final Widget image;
  final Widget buttonText;
  final String buttonTextData;
  final VoidCallback onPressed;

  ViewStateWidget(
      {this.title,
      this.message,
      this.image,
      this.buttonText,
      this.buttonTextData,
      this.onPressed});

  @override
  Widget build(BuildContext context) {
    var titleStyle =
        Theme.of(context).textTheme.subhead.copyWith(color: Colors.grey);
    var messageStyle = titleStyle.copyWith(
        color: titleStyle.color.withOpacity(0.7), fontSize: 14);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        image ??
            Icon(
              IconFonts.pageError,
              size: 80,
              color: Colors.grey[500],
            ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
          child: Column(
            // 最大化主轴可用空间
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                title ?? '加载失败',
                style: titleStyle,
              ),
              SizedBox(
                height: 20,
              ),
              ConstrainedBox(
                constraints: BoxConstraints(maxHeight: 200, minHeight: 150),
                child: SingleChildScrollView(
                  child: Text(
                    message ?? '',
                    style: messageStyle,
                  ),
                ),
              )
            ],
          ),
        ),
        Center(
          child: ViewStateButton(
            onPressed: onPressed,
            child: buttonText,
            textData: buttonTextData,
          ),
        )
      ],
    );
  }
}

/// Error的Widget
class ViewStateErrorWidget extends StatelessWidget {
  final ViewStateError error;
  final String title;
  final String message;
  final Widget image;
  final Widget buttonText;
  final String buttonTextData;
  final VoidCallback onPressed;

  ViewStateErrorWidget(
      {@required this.error,
      this.title,
      this.message,
      this.image,
      this.buttonText,
      this.buttonTextData,
      @required this.onPressed});

  @override
  Widget build(BuildContext context) {
    var defaultImage;
    var defaultTitle;
    var errorMessage = error.message;
    String defaultTextData = '重试';
    switch (error.errorType) {
      case ViewStateErrorType.networkTimeOutError:
        defaultImage = Transform.translate(
          offset: Offset(-50, 0),
          child: const Icon(
            IconFonts.pageNetworkError,
            size: 100,
            color: Colors.grey,
          ),
        );
        defaultTitle = '加载失败，请检查网络';
        break;
      case ViewStateErrorType.defaultError:
        defaultImage = const Icon(
          IconFonts.pageError,
          size: 100,
          color: Colors.grey,
        );
        defaultTitle = '加载失败';
        break;
      case ViewStateErrorType.unauthorizedError:
        return ViewStateUnAuthWidget(
          onPressed: onPressed,
          buttonText: buttonText,
          message: message,
          image: image,
        );
        break;
    }
    return ViewStateWidget(
      onPressed: this.onPressed,
      image: image ?? defaultImage,
      title: title ?? defaultTitle,
      message: message ?? errorMessage,
      buttonTextData: buttonTextData ?? defaultTextData,
      buttonText: buttonText,
    );
  }
}

/// 页面无数据
class ViewStateEmptyWidget extends StatelessWidget {
  final String message;
  final Widget image;
  final Widget buttonText;
  final VoidCallback onPressed;

  const ViewStateEmptyWidget(
      {this.message, this.image, this.buttonText, @required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ViewStateWidget(
      onPressed: this.onPressed,
      image: image ??
          const Icon(
            IconFonts.pageEmpty,
            size: 100,
            color: Colors.grey,
          ),
      title: message ?? '找不到数据',
      buttonText: buttonText,
      buttonTextData: '重试',
    );
  }
}

/// 页面未授权
class ViewStateUnAuthWidget extends StatelessWidget {
  final String message;
  final Widget image;
  final Widget buttonText;
  final VoidCallback onPressed;

  const ViewStateUnAuthWidget(
      {this.message, this.image, this.buttonText, @required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ViewStateWidget(
      onPressed: this.onPressed,
      image: image ?? ViewStateUnAuthImage(),
      title: message ?? '尚未登录',
      buttonText: buttonText,
      buttonTextData: '登录',
    );
  }
}

/// 未授权图片
class ViewStateUnAuthImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Hero(
        tag: 'loginLogo',
        child: Image.asset(
          ImageHelper.wrapAssets('login_logo.png'),
          width: 130,
          height: 100,
          fit: BoxFit.fitWidth,
          color: Theme.of(context).accentColor,
          colorBlendMode: BlendMode.srcIn,
        ));
  }
}

/// ViewState公用Button
class ViewStateButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;
  final String textData;

  ViewStateButton({@required this.onPressed, this.child, this.textData})
      : assert(child == null || textData == null);

  @override
  Widget build(BuildContext context) {
    return OutlineButton(
      onPressed: onPressed,
      child: child ??
          Text(
            textData ?? '重试',
            style: TextStyle(wordSpacing: 5),
          ),
      textColor: Colors.grey,
      splashColor: Theme.of(context).splashColor,
      highlightedBorderColor: Theme.of(context).splashColor,
    );
  }
}
