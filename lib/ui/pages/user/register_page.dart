import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wanandroidflutter/provider/provider_widget.dart';
import 'package:wanandroidflutter/routers/fluro_navigator.dart';
import 'package:wanandroidflutter/widget/button_progress_indicator.dart';
import 'package:wanandroidflutter/widget/diy_textfield.dart';
import 'package:wanandroidflutter/view_model/register_model.dart';
import 'package:wanandroidflutter/widget/login_widget.dart';

/// 注册页面
class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _rePasswordController = TextEditingController();
  final _pwdFocus = FocusNode();
  final _pwdNextFocus = FocusNode();

  @override
  void dispose() {
    _nameController.dispose();
    _passwordController.dispose();
    _rePasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            '注册',
            style: TextStyle(
                color: Theme.of(context).cardColor,
                fontSize: ScreenUtil().setSp(54)),
          ),
          brightness: Theme.of(context).brightness,
          centerTitle: true,
          primary: true,
          leading: IconButton(
            icon: Icon(
              Icons.close,
              size: 25,
              color: Theme.of(context).cardColor,
            ),
            onPressed: () {
              NavigatorUtils.goBack(context);
            },
          ),
        ),
        body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: ProviderWidget<RegisterModel>(
              model: RegisterModel(),
              builder: (context, model, child) => Form(
                onWillPop: () async {
                  return !model.isBusy;
                },
                child: Container(
                  child: Column(
                    children: <Widget>[
                      DiyTextField(
                        leading: '用户名',
                        label: '用户名',
                        controller: _nameController,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (text) {
                          FocusScope.of(context).requestFocus(_pwdFocus);
                        },
                      ),
                      DiyTextField(
                        leading: '密码',
                        controller: _passwordController,
                        obscureText: true,
                        label: '密码',
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (text) {
                          FocusScope.of(context).requestFocus(_pwdNextFocus);
                        },
                        focusNode: _pwdFocus,
                      ),
                      DiyTextField(
                        leading: '确认密码',
                        obscureText: true,
                        controller: _rePasswordController,
                        label: '确认密码',
                        textInputAction: TextInputAction.done,
                        focusNode: _pwdNextFocus,
                        validator: (value){
                          return value != _passwordController.text ? '两次密码输入不相同':null;
                        },
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 12, top: 12),
                        alignment: Alignment.centerLeft,
                        child: Text.rich(TextSpan(children: [
                          TextSpan(
                              text: '注册即表明同意玩安卓的',
                              style:
                                  TextStyle(fontSize: ScreenUtil().setSp(30))),
                          TextSpan(
                              text: '服务及隐私条款',
                              recognizer: TapGestureRecognizer()
                                ..onTap = () async {
                                  // 点击跳转
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> ProvisionsPage()));
                                },
                              style: TextStyle(
                                  fontSize: ScreenUtil().setSp(30),
                                  decoration: TextDecoration.underline)),
                        ])),
                      ),
                      RegisterButton(_nameController, _passwordController,
                          _rePasswordController, model),
                      Container(
                        margin: EdgeInsets.only(right: 15, top: 15),
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () {
                            NavigatorUtils.goBack(context);
                          },
                          child: Text.rich(TextSpan(text: '已有账号？', children: [
                            TextSpan(
                                text: '去登录',
                                style: TextStyle(color: Theme.of(context).accentColor))
                          ])),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )),
      ),
    );
  }
}

class RegisterButton extends StatelessWidget {
  final nameController;
  final passwordController;
  final rePasswordController;
  final RegisterModel model;

  RegisterButton(this.nameController, this.passwordController,
      this.rePasswordController, this.model);

  @override
  Widget build(BuildContext context) {
    return LoginButtonWidget(
      child: model.isBusy
          ? ButtonProgressIndicator()
          : Text(
              '注册',
              style: Theme.of(context)
                  .accentTextTheme
                  .title
                  .copyWith(wordSpacing: 6),
            ),
      onPressed: model.isBusy
          ? null
          : () {
              if (Form.of(context).validate()) {
                model
                    .singUp(nameController.text, passwordController.text,
                        rePasswordController.text)
                    .then((value) {
                  if (value) {
                    NavigatorUtils.goBackWithParams(context, nameController.text);
                  } else {
                    model.showErrorMessage(context);
                  }
                });
              }
            },
    );
  }
}

/// 隐私及服务条款
class ProvisionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
          appBar: AppBar(
            title: Text(
              '服务及隐私条款',
              style: TextStyle(
                  color: Theme.of(context).cardColor,
                  fontSize: ScreenUtil().setSp(54)),
            ),
            brightness: Theme.of(context).brightness,
            centerTitle: true,
            primary: true,
            leading: IconButton(
              icon: Icon(
                Icons.close,
                size: 25,
                color: Theme.of(context).cardColor,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          body: ListView(
            children: <Widget>[
              Container(padding: EdgeInsets.only(left: 20,right: 20,top: 12),child: Text(_provisions)),],
          )
      ),
    );
  }
}

String _provisions = '''        本应用深知个人信息对您的重要性，并会尽全力保护您的个人信息安全可靠。我们致力于维持您对我们的信任，恪守以下原则，保护您的个人信息：权责一致原则、目的明确原则、选择同意原则、最少够用原则、确保安全原则、主体参与原则、公开透明原则等。同时，我们承诺，我们将按业界成熟的安全标准，采取相应的安全保护措施来保护您的个人信息。 请在使用我们的产品（或服务）前，仔细阅读并了解本《隐私权政策》。

一、我们如何收集和使用您的个人信息

个人信息是指以电子或者其他方式记录的能够单独或者与其他信息结合识别特定自然人身份或者反映特定自然人活动情况的各种信息。 我们仅会出于本政策所述的以下目的，收集和使用您的个人信息：

（一）我们不出售任何商品，同时也不展示任何商品

（二）开展内部数据分析和研究，第三方SDK统计服务，改善我们的产品或服务

我们收集数据是根据您与我们的互动和您所做出的选择，包括您的隐私设置以及您使用的产品和功能。我们收集的数据可能包括SDK/API/JS代码版本、浏览器、互联网服务提供商、IP地址、平台、时间戳、应用标识符、应用程序版本、应用分发渠道、独立设备标识符、iOS广告标识符（IDFA)、安卓广告主标识符、网卡（MAC）地址、国际移动设备识别码（IMEI）、设备型号、终端制造厂商、终端设备操作系统版本、会话启动/停止时间、语言所在地、时区和网络状态（WiFi等）、硬盘、CPU和电池使用情况等。

当我们要将信息用于本策略未载明的其它用途时，会事先征求您的同意。

当我们要将基于特定目的收集而来的信息用于其他目的时，会事先征求您的同意。

二、我们如何使用 Cookie 和同类技术

（一）Cookie

为确保网站正常运转，我们会在您的计算机或移动设备上存储名为 Cookie 的小数据文件。Cookie 通常包含标识符、站点名称以及一些号码和字符。借助于 Cookie，网站能够存储您的偏好或购物篮内的商品等数据。

我们不会将 Cookie 用于本政策所述目的之外的任何用途。您可根据自己的偏好管理或删除 Cookie。您可以清除计算机上保存的所有 Cookie，大部分网络浏览器都设有阻止 Cookie 的功能。但如果您这么做，则需要在每一次访问我们的网站时亲自更改用户设置。

（二）网站信标和像素标签

除 Cookie 外，我们还会在网站上使用网站信标和像素标签等其他同类技术。例如，我们向您发送的电子邮件可能含有链接至我们网站内容的点击 URL。如果您点击该链接，我们则会跟踪此次点击，帮助我们了解您的产品或服务偏好并改善客户服务。网站信标通常是一种嵌入到网站或电子邮件中的透明图像。借助于电子邮件中的像素标签，我们能够获知电子邮件是否被打开。如果您不希望自己的活动以这种方式被追踪，则可以随时从我们的寄信名单中退订。

（三）Do Not Track（请勿追踪）

很多网络浏览器均设有 Do Not Track 功能，该功能可向网站发布 Do Not Track 请求。目前，主要互联网标准组织尚未设立相关政策来规定网站应如何应对此类请求。但如果您的浏览器启用了 Do Not Track，那么我们的所有网站都会尊重您的选择。

三、我们如何共享、转让、公开披露您的个人信息

（一）共享

我们不会向其他任何公司、组织和个人分享您的个人信息，但以下情况除外：

1、在获取明确同意的情况下共享：获得您的明确同意后，我们会与其他方共享您的个人信息。

2、我们可能会根据法律法规规定，或按政府主管部门的强制性要求，对外共享您的个人信息。

3、与我们的关联公司共享：您的个人信息可能会与我们关联公司共享。我们只会共享必要的个人信息，且受本隐私政策中所声明目的的约束。关联公司如要改变个人信息的处理目的，将再次征求您的授权同意。

我们的关联公司包括:【无】。

4、与授权合作伙伴共享：仅为实现本隐私权政策中声明的目的，我们的某些服务将由授权合作伙伴提供。我们可能会与合作伙伴共享您的某些个人信息，以提供更好的客户服务和用户体验。例如，我们聘请来提供第三方数据统计和分析服务的公司可能需要采集和访问个人数据以进行数据统计和分析。在这种情况下，这些公司 必须遵守我们的数据隐私和安全要求。我们仅会出于合法、正当、必要、特定、明确的目的共享您的个人信息，并且只会共享提供服务所必要的个人信息。

（二）转让

我们不会将您的个人信息转让给任何公司、组织和个人，但以下情况除外：

1、在获取明确同意的情况下转让：获得您的明确同意后，我们会向其他方转让您的个人信息；

2、在涉及合并、收购或破产清算时，如涉及到个人信息转让，我们会在要求新的持有您个人信息的公司、组织继续受此隐私政策的约束，否则我们将要求该公司、组织重新向您征求授权同意。

（三）公开披露

我们仅会在以下情况下，公开披露您的个人信息：

1、获得您明确同意后；

2、基于法律的披露：在法律、法律程序、诉讼或政府主管部门强制性要求的情况下，我们可能会公开披露您的个人信息。

四、我们如何保护您的个人信息

（一）我们已使用符合业界标准的安全防护措施保护您提供的个人信息，防止数据遭到未经授权访问、公开披露、使用、修改、损坏或丢失。我们会采取一切合理可行的措施，保护您的个人信息。例如，在您的浏览器与“服务”之间交换数据（如信用卡信息）时受 SSL 加密保护；我们同时对我们网站提供 https 安全浏览方式；我们会使用加密技术确保数据的保密性；我们会使用受信赖的保护机制防止数据遭到恶意攻击；我们会部署访问控制机制，确保只有授权人员才可访问个人信息；以及我们会举办安全和隐私保护培训课程，加强员工对于保护个人信息重要性的认识。

（二）我们会采取一切合理可行的措施，确保未收集无关的个人信息。我们只会在达成本政策所述目的所需的期限内保留您的个人信息，除非需要延长保留期或受到法律的允许。

（三）互联网并非绝对安全的环境，而且电子邮件、即时通讯、及与其他我们用户的交流方式并未加密，我们强烈建议您不要通过此类方式发送个人信息。请使用复杂密码，协助我们保证您的账号安全。

（四）互联网环境并非百分之百安全，我们将尽力确保或担保您发送给我们的任何信息的安全性。如果我们的物理、技术、或管理防护设施遭到破坏，导致信息被非授权访问、公开披露、篡改、或毁坏，导致您的合法权益受损，我们将承担相应的法律责任。

（五）在不幸发生个人信息安全事件后，我们将按照法律法规的要求，及时向您告知：安全事件的基本情况和可能的影响、我们已采取或将要采取的处置措施、您可自主防范和降低风险的建议、对您的补救措施等。我们将及时将事件相关情况以邮件、信函、电话、推送通知等方式告知您，难以逐一告知个人信息主体时，我们会采取合理、有效的方式发布公告。

同时，我们还将按照监管部门要求，主动上报个人信息安全事件的处置情况。

五、您的权利

按照中国相关的法律、法规、标准，以及其他国家、地区的通行做法，我们保障您对自己的个人信息行使以下权利：

（一）访问您的个人信息

您有权访问您的个人信息，法律法规规定的例外情况除外。如果您想行使数据访问权，可以通过以下方式自行访问：

账户信息——如果您希望访问或编辑您的账户中的个人资料信息和支付信息、更改您的密码、添加安全信息或关闭您的账户等，您可以通过访问执行此类操作。

搜索信息——您可以在应用中访问或清除您的搜索历史记录、查看和修改兴趣以及管理其他数据。

六、本隐私权政策如何更新

我们可能适时会对本隐私权政策进行调整或变更，本隐私权政策的任何更新将以标注更新时间的方式公布在我们网站上，除法律法规或监管规定另有强制性规定外，经调整或变更的内容一经通知或公布后的7日后生效。如您在隐私权政策调整或变更后继续使用我们提供的任一服务或访问我们相关网站的，我们相信这代表您已充分阅读、理解并接受修改后的隐私权政策并受其约束。

''';