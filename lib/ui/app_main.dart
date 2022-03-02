import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:netflix_clone/get_controller/menu_controller.dart';
import 'package:netflix_clone/ui/movie/movie_home.dart';
import 'package:netflix_clone/ui/save/save_home.dart';
import 'package:netflix_clone/ui/settings/settings_home.dart';
import 'package:netflix_clone/ui/tv/tv_home.dart';

import '../get_controller/api_controller.dart';
import '../util/constant.dart';

class AppMain extends StatefulWidget {
  const AppMain({Key? key}) : super(key: key);

  @override
  State<AppMain> createState() => _AppMainState();
}

class _AppMainState extends State<AppMain> {
  late final MenuController c;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    c = Get.put(MenuController());
    Get.put(ApiController());
  }

  List<bool> initCheck = [true, false, false, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        bottomNavigationBar: Obx(() => BottomNavigationBar(
              selectedItemColor: Constant.colorMain,
              unselectedItemColor: Colors.grey.shade400,
              currentIndex: c.mainMenuIndex,
              onTap: (value) {
                if (!initCheck[value]) {
                  setState(() {
                    initCheck[value] = true;
                  });
                }
                c.setMainMenuIndex(value);
              },
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
                BottomNavigationBarItem(icon: Icon(Icons.tv), label: 'tv'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.save_alt), label: 'save'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.settings), label: 'settings'),
              ],
            )),
        body: Obx(() => IndexedStack(
              index: c.mainMenuIndex,
              children: [
                _movieHome(c),
                _tvHome(c),
                _saveHome(c),
                _settingsHome(c),
              ],
            )));
  }

  Widget _movieHome(MenuController c) {
    return initCheck[0] ? MovieHome() : SizedBox();
  }

  Widget _tvHome(MenuController c) {
    return initCheck[1] ? TvHome() : SizedBox();
  }

  Widget _saveHome(MenuController c) {

    return initCheck[2] ? SaveHome() : SizedBox();
  }

  Widget _settingsHome(MenuController c) {
    return initCheck[3] ? SettingsHome() : SizedBox();
  }
}
