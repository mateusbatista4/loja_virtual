import 'package:flutter/cupertino.dart';

class PageManager {
  final PageController _controller;

  PageManager(this._controller);

  int current = 0;

  void setPage(int next) {
    
    current = next;
    _controller.jumpToPage(next);
  }
}
