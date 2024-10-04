import 'package:flutter/material.dart';

class TabBarController {
  late TabController _controller;

  TabController get controller => _controller;

  set controller(TabController value) {
    _controller = value;
  }
}