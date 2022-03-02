import 'package:get/get.dart';

class MenuController extends GetxController {
  final _mainMenuIndex = 0.obs;

  final List<bool> _initPage = [true, false, false, false];

  bool initPage(int index) => _initPage[index];

  int get mainMenuIndex => _mainMenuIndex.value;

  setMainMenuIndex(int index) {
    if (!_initPage[index]) {
      _initPage[index] = true;
    }
    _mainMenuIndex.value = index;
  }
}
