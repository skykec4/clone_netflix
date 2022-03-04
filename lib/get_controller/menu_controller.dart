import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MenuController extends GetxController {
  final _mainMenuIndex = 0.obs;
  final _homeIndex = 0.obs;

  late final AnimationController _menuController;

  AnimationController get menuController => _menuController;

  setMenuAnimationController(AnimationController c) {
    _menuController = c;
  }

  final List<bool> _initPage = [true, false, false, false];

  final movieNavigatorKey = GlobalKey<NavigatorState>().obs;

  bool initPage(int index) => _initPage[index];

  int get mainMenuIndex => _mainMenuIndex.value;
  int get homeIndex => _homeIndex.value;

  setHomeIndex(int index) {
    _homeIndex.value = index;
  }

  setMainMenuIndex(int index) {
    if (!_initPage[index]) {
      _initPage[index] = true;
    }
    _mainMenuIndex.value = index;
  }
}
