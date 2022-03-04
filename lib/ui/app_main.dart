import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:netflix_clone/get_controller/menu_controller.dart';
import 'package:netflix_clone/ui/movie/movie_home.dart';
import 'package:netflix_clone/ui/save/save_home.dart';
import 'package:netflix_clone/ui/settings/settings_home.dart';
import 'package:netflix_clone/ui/tv/tv_home.dart';

import '../get_controller/api_controller.dart';

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

  // Navigator key 생성
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();


  Future<bool> _onWillPop() async {

    if (c.homeIndex != 0) {
      c.setHomeIndex(0);
      c.menuController.reverse();
      return false;
    }

    return !await navigatorKey.currentState!.maybePop();
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      // onWillPop: _isExitDesired,
      child: Scaffold(
          // appBar: AppBar(
          //   // leading: _back(),
          //   title: Image.asset('assets/images/logo.png',height: 50,color: Colors.red,),
          //   actions: [
          //     IconButton(
          //       onPressed: () async {
          //         print('aa " ${navigatorKey.currentState?.canPop()}');
          //
          //         !await navigatorKey.currentState!.maybePop();
          //       },
          //       // onPressed: _onExitPressed,
          //       icon: const Icon(Icons.chevron_left),
          //     )
          //   ],
          // ),
          bottomNavigationBar: Theme(
            data: Theme.of(context).copyWith(
              // sets the background color of the `BottomNavigationBar`
              canvasColor: Colors.black,
              // sets the active color of the `BottomNavigationBar` if `Brightness` is light)
            ),
            child: Obx(() => BottomNavigationBar(
                  // selectedItemColor: Constant.colorMain,
                  // unselectedItemColor: Colors.grey.shade400,
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
                    BottomNavigationBarItem(icon: Icon(Icons.home), label: '홈'),
                    BottomNavigationBarItem(icon: Icon(Icons.tv), label: 'TV'),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.save_alt), label: 'save'),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.settings), label: 'settings'),
                  ],
                )),
          ),
          body: Obx(() => IndexedStack(
                index: c.mainMenuIndex,
                children: [
                  Navigator(
                      key: navigatorKey,
                      onGenerateRoute: (routeSettings) {
                        return MaterialPageRoute(
                            builder: (context) => _movieHome(c));
                      }),
                  _tvHome(c),
                  _saveHome(c),
                  _settingsHome(c),
                ],
              ))),
    );
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

  Future<void> _onExitPressed() async {
    final isConfirmed = await _isExitDesired();

    if (isConfirmed && mounted) {
      _exitSetup();
    }
  }

  Future<bool> _isExitDesired() async {
    return await showDialog<bool>(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Are you sure?'),
                content: const Text(
                    'If you exit device setup, your progress will be lost.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                    child: const Text('Leave'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                    child: const Text('Stay'),
                  ),
                ],
              );
            }) ??
        false;
  }

  void _exitSetup() {
    Navigator.of(context).pop();
  }
}
