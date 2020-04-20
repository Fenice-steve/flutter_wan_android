import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:wanandroidflutter/provider/view_state_list_model.dart';

/// 展示子类的抽屉
class CategoryDropdownWidget extends StatelessWidget {
  final ViewStateListModel model;

  CategoryDropdownWidget(this.model);

  @override
  Widget build(BuildContext context) {
    int currentIndex = Provider.of<int>(context);
    return Align(
      child: Theme(
          data: Theme.of(context)
              .copyWith(canvasColor: Theme.of(context).primaryColor),
          child: DropdownButtonHideUnderline(
              child: DropdownButton(
                  elevation: 0,
                  value: currentIndex,
                  style: Theme.of(context).primaryTextTheme.subhead,
                  items: List.generate(model.list.length, (index) {
                    var theme = Theme.of(context);
                    var subhead = theme.primaryTextTheme.subhead;
                    return DropdownMenuItem(
                        value: index,
                        child: Text(
                          model.list[index].name,
                          style: currentIndex == index
                              ? subhead.apply(
                                  fontSizeFactor: 1.15,
                                  color: theme.brightness == Brightness.light
                                      ? Colors.white
                                      : theme.accentColor)
                              : subhead.apply(
                                  color: subhead.color.withAlpha(200)),
                        ));
                  }),
                  onChanged: (value){
                    DefaultTabController.of(context).animateTo(value);
                  },
              isExpanded: true,
                icon: Container(
                  child: Icon(Icons.keyboard_arrow_down,color: Colors.white,),
                ),
              ))),
      alignment: Alignment(1.1, -1),
    );
  }
}
