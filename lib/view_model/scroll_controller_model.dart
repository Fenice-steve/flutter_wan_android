import 'package:flutter/material.dart';

class TapToTopModel with ChangeNotifier {
  ScrollController _scrollController;

  double _height;

  bool _showTopButton = false;

  ScrollController get scrollController => _scrollController;

  double get height => _height;

  bool get showTopButton => _showTopButton;

  TapToTopModel(this._scrollController, {double height: 200}) {
    _height = height;
  }

  init() {
    _scrollController.addListener(() {
      if (_scrollController.offset > _height && _showTopButton) {
        _showTopButton = true;
        notifyListeners();
      } else if (_scrollController.offset < _height && _showTopButton) {
        _showTopButton = false;
        notifyListeners();
      }
    });
  }

  scrollToTop() {
    _scrollController.animateTo(0,
        duration: Duration(milliseconds: 300), curve: Curves.easeOutCubic);
  }
}
