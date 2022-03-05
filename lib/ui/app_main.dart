import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:netflix_clone/get_controller/menu_controller.dart';
import 'package:netflix_clone/ui/movie/movie_home.dart';
import 'package:netflix_clone/ui/save/save_home.dart';
import 'package:netflix_clone/ui/settings/settings_home.dart';
import 'package:netflix_clone/ui/tv/tv_home.dart';

import '../get_controller/api_controller.dart';
import 'category/category.dart';

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
  Widget _appBarTitle(int index) {
    if (index == 1) {
      return Text('시리즈');
    } else if (index == 2) {
      return Text('영화');
    } else {
      return SizedBox();
    }
  }
  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: GetPlatform.isAndroid ? _onWillPop : null,
      // onWillPop: _isExitDesired,
      child: Obx(() => Scaffold(
        /*
          appBar: MyCustomAppBar(
            height: 100,
            c: c,
          ),*/

          appBar: c.homeIndex  < 4 ? null : AppBar(
            leading: c.homeIndex < 1 ? null : IconButton(onPressed: () async {


              c.setHomeIndex(0);

              print("${navigatorKey.currentState.toString()}");
              !await navigatorKey.currentState!.maybePop();
            },
              icon: Icon(Icons.arrow_back_ios),
            ),
              title: c.homeIndex != 0
                  ? _appBarTitle(c.homeIndex)
                  : Image.asset(
                'assets/images/logo.png',
                height: 60,
              ),
              actions: [
                IconButton(
                    onPressed: () {}, icon: Icon(Icons.search_sharp)),
                IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.filter_list_sharp)),
                IconButton(onPressed: () {}, icon: Icon(Icons.person)),
              ]
          ),


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
            child: BottomNavigationBar(
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
            ),
          ),
          body: IndexedStack(
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

class MyCustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final double height;
  final MenuController c;

  const MyCustomAppBar({
    Key? key,
    required this.height,
    required this.c,
  }) : super(key: key);

  @override
  State<MyCustomAppBar> createState() => _MyCustomAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(height);
}

class _MyCustomAppBarState extends State<MyCustomAppBar> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController.addListener(() {
      print('offset = ${_scrollController.offset}');
    });
    animation = Tween<double>(begin: 30, end: 10).animate(
        CurvedAnimation(parent: widget.c.menuController, curve: Curves.easeIn))
      ..addListener(() {
        setState(() {});
      });
  }

  Widget _appBarTitle(int index) {
    if (index == 1) {
      return Text('시리즈');
    } else if (index == 2) {
      return Text('영화');
    } else {
      return SizedBox();
    }
  }

  late Animation<double> animation;
  ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              automaticallyImplyLeading: false,
              pinned: true,
              snap: true,
              floating: true,
              // snap: menuController.homeIndex < 4 ? true : false,
              // floating: menuController.homeIndex < 4 ? true : false,
              backgroundColor: widget.c.homeIndex < 4
                  ? Colors.black.withOpacity(.5)
                  : Colors.black,
              expandedHeight: 100,
              // expandedHeight: menuController.homeIndex < 4 ? 100 : 0,
              leading: widget.c.homeIndex != 0
                  ? IconButton(
                      onPressed: () {
                        widget.c.setHomeIndex(0);
                        widget.c.menuController.reverse();
                        // _scrollController.animateTo(0.0,
                        //     duration: Duration(microseconds: 300),
                        //     curve: Curves.easeIn);

                        // controller.reverse();
                      },
                      icon: Icon(Icons.arrow_back),
                    )
                  : null,
              title: widget.c.homeIndex != 0
                  ? _appBarTitle(widget.c.homeIndex)
                  : Image.asset(
                      'assets/images/logo.png',
                      height: 60,
                    ),
              centerTitle: false,
              actions: [
                IconButton(onPressed: () {}, icon: Icon(Icons.search_sharp)),
                IconButton(
                    onPressed: () {}, icon: Icon(Icons.filter_list_sharp)),
                IconButton(onPressed: () {}, icon: Icon(Icons.person)),
              ],
              bottom: widget.c.homeIndex < 5
                  ? PreferredSize(
                      child: Container(
                        color: Colors.transparent,
                        child: Container(
                          height: 40,
                          padding: EdgeInsets.only(left: animation.value),
                          child: Row(
                            children: [
                              Offstage(
                                offstage: widget.c.homeIndex == 0 ||
                                        widget.c.homeIndex == 1
                                    ? false
                                    : true,
                                child: Container(
                                  margin: EdgeInsets.only(right: 15),
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(50),
                                    onTap: () {
                                      widget.c.setHomeIndex(1);
                                      _scrollController.animateTo(0.0,
                                          duration: Duration(microseconds: 300),
                                          curve: Curves.easeIn);
                                      // Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(
                                      //     builder: (context) => CategoryDetail(),
                                      //   ),
                                      // );
                                      widget.c.menuController.forward();
                                      // controller.forward();
                                    },
                                    child: CircleAvatar(
                                      backgroundColor: Colors.transparent,
                                      foregroundColor: Colors.white,
                                      child: Text(
                                        '시리즈',
                                        style: TextStyle(fontSize: 12.sp),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Offstage(
                                offstage: widget.c.homeIndex == 0 ||
                                        widget.c.homeIndex == 2
                                    ? false
                                    : true,
                                child: Container(
                                  margin: EdgeInsets.only(right: 15),
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(50),
                                    onTap: () {
                                      widget.c.setHomeIndex(2);
                                      _scrollController.animateTo(0.0,
                                          duration: Duration(microseconds: 300),
                                          curve: Curves.easeIn);
                                      // Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(
                                      //     builder: (context) => CategoryDetail(),
                                      //   ),
                                      // );
                                      widget.c.menuController.forward();
                                      // controller.forward();
                                    },
                                    child: CircleAvatar(
                                      backgroundColor: Colors.transparent,
                                      foregroundColor: Colors.white,
                                      child: Text(
                                        '영화',
                                        style: TextStyle(fontSize: 12.sp),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Offstage(
                                offstage:
                                    widget.c.homeIndex == 0 ? false : true,
                                child: GestureDetector(
                                  onTap: () {
                                    Get.dialog(Category());
                                  },
                                  child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 10),
                                      child: Row(
                                        children: [
                                          Text('카테고리',
                                              style:
                                                  TextStyle(fontSize: 12.sp)),
                                          Icon(
                                            Icons.arrow_drop_down_sharp,
                                            color: Colors.white,
                                          )
                                        ],
                                      )),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      preferredSize: const Size(0, 40),
                    )
                  : PreferredSize(
                      preferredSize: const Size(0, 200),
                      child: Container(
                        height: 200,
                        width: 1.sw,
                        child: Text('youtube'),
                      ),
                    ),
              // flexibleSpace: const FlexibleSpaceBar(
              // ),
              // flexibleSpace: FlexibleSpaceBar(
              //   background : Container(
              //     margin: EdgeInsets.only(top: 80),
              //       color: Colors.red,
              //       width: double.infinity,
              //       child: ExtendedImage.network('https://picsum.photos/200/300',width: 1,fit: BoxFit.cover)),
              // )
            )
          ];
        },
        body: Text(''),
      ),
    );
  }
}
