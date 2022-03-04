import 'dart:math';

import 'package:decorated_text/decorated_text.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../get_controller/api_controller.dart';
import '../../get_controller/menu_controller.dart';
import '../../models/movie/now_palying_model.dart';
import '../../util/constant.dart';
import '../category/category.dart';
import '../category/category_detail.dart';
import 'movie_detail.dart';
import 'package:dio/dio.dart';

import 'movie_main.dart';

class MovieHome extends StatefulWidget {
  const MovieHome({Key? key}) : super(key: key);

  @override
  State<MovieHome> createState() => _MovieHomeState();
}

class _MovieHomeState extends State<MovieHome>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {

  late ApiController apiController;
  MenuController menuController = Get.find<MenuController>();
  NowPlayingModel? nowPlaying;

  late Animation<double> animation;

  // late AnimationController controller;

  int _movieId = -1;

  void setMovieId(int id) {
    setState(() {
      _movieId = id;
    });
  }

  void fetchNowPlaying() async {
    setState(() {
      nowPlaying = null;
    });

    try {
      var _nowPlaying = await apiController.api
          .getNowPlaying(Constant.apiKey, Constant.language, "1");
      nowPlaying = _nowPlaying;
      print("nowPlaying $_nowPlaying");
      // } catch (e) {
    } on DioError catch (e) {
      print('error data1 ${e.response?.data}');
      print('error data1 ${e.response?.data.runtimeType}');
      print('error data2 ${e.response}');
      print('error data2 ${e.response.runtimeType}');

      nowPlaying = NowPlayingModel.fromJson(e.response?.data);

      print("nowPlaying : $nowPlaying");
      // print('eeeee : ${e.response}');
      // print('eeeee statusCode: ${e.response?.statusCode}');
      // print("e.response?.data : ${e.response?.data}");
      // print("e.response?.headers :: ${e.response?.headers}");
      // print("e.response?.requestOptions : ${e.response?.requestOptions}");
    } finally {
      setState(() {});
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apiController = Get.find<ApiController>();

    menuController.setMenuAnimationController(AnimationController(
        duration: const Duration(milliseconds: 200), vsync: this));

    // controller = AnimationController(
    //     duration: const Duration(milliseconds: 200), vsync: this);

    animation = Tween<double>(begin: 30, end: 10).animate(CurvedAnimation(
        parent: menuController.menuController, curve: Curves.easeIn))
      ..addListener(() {
        setState(() {});
      });

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      fetchNowPlaying();
    });
  }

  Widget _top() {
    // print('random : ${Random().nextInt(10)}');
    // print('random : ${nowPlaying?.results?.length ?? 0}');
    int randomIndex = Random().nextInt(nowPlaying?.results?.length ?? 1);

    print(randomIndex);
    if (nowPlaying == null) {
      return Text('');
    }
    return Container(
        width: 1.sw,
        height: 1.2.sw,
        child: Stack(
          children: [
            Container(
              height: 0.9.sw,
              child: ExtendedImage.network(
                '${Constant.imageBaseUrl}${nowPlaying?.results?[randomIndex].posterPath}',
                width: 1.sw,
                fit: BoxFit.fill,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.only(bottom: 0.17.sw),
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: DecoratedText(
                  '${nowPlaying?.results?[randomIndex].title}',
                  borderColor: Color(0xff404040),
                  borderWidth: 3,
                  fontSize: 25.sp,
                  // fontWeight: FontWeight.w100,
                  shadows: [
                    Shadow(
                        color: Colors.black,
                        blurRadius: 1,
                        offset: Offset(4, 4))
                  ],
                  fillGradient:
                      LinearGradient(colors: [Color(0xffb3b3b3), Colors.white]),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 0.3.sw,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // Text('${nowPlaying?.results?[randomIndex].title}'),

                    Flex(
                      direction: Axis.horizontal,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: 0.25.sw,
                          child: Column(
                            children: [
                              Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 16.sp,
                              ),
                              Text(
                                '내가 찜한 콘텐츠',
                                style: TextStyle(
                                    fontSize: 10.sp, color: Colors.white70),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 0.25.sw,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.white,
                                  onPrimary: Colors.black),
                              onPressed: () {},
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.play_arrow,
                                    size: 18.sp,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    '재생',
                                    style: TextStyle(fontSize: 14.sp),
                                  ),
                                ],
                              )),
                        ),
                        Container(
                          width: 0.25.sw,
                          child: Column(
                            children: [
                              Icon(
                                Icons.info,
                                color: Colors.white,
                                size: 16.sp,
                              ),
                              Text(
                                '정보',
                                style: TextStyle(
                                    fontSize: 10.sp, color: Colors.white70),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ));
  }

  Widget _nowPlaying() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Text('현재 상영작')),
        Container(width: 1.sw, height: 150, child: _movieCard(nowPlaying)

            // Container(
            //         alignment: Alignment.center,
            //         child: CircularProgressIndicator(
            //           color: Colors.white,
            //         ))
            ),
      ],
    );
  }

  Widget _bottom(Results data) {
    return Container(
      padding: EdgeInsets.all(10),
      height: 230,
      decoration: BoxDecoration(
          color: Color(0xff262626),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15))),
      child: Stack(
        children: [
          Column(
            children: [
              Flex(
                direction: Axis.horizontal,
                children: [
                  Container(
                    width: 0.22.sw,
                    height: 120,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(4.0),
                        child: ExtendedImage.network(
                          '${Constant.imageBaseUrl}${data.posterPath}',
                        )),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: 0.65.sw,
                    height: 120,
                    child: Flex(
                      direction: Axis.vertical,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${data.title}',
                          textScaleFactor: .9,
                        ),
                        Row(
                          children: [
                            Text(
                              '${data.releaseDate}',
                              style: TextStyle(
                                  fontSize: 10.sp, color: Colors.grey),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Icon(Icons.star, color: Colors.amber, size: 14.sp),
                            Text('${data.voteAverage}',
                                style: TextStyle(
                                    fontSize: 10.sp, color: Colors.grey))
                          ],
                        ),
                        Flexible(
                            child: Text('${data.overview}',
                                maxLines: 5,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontSize: 11.sp)))
                      ],
                    ),
                  )
                  // Column(
                  //   children: [
                  //     // Text('${data.title}'),
                  //     // Text('${data.releaseDate}'),
                  //     // Text('${data.voteAverage}'),
                  //     // Flexible(child: Text('${data.overview}')),
                  //   ],
                  // )
                ],
              ),
              Row(
                children: [
                  Flexible(
                    flex: 2,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            onPrimary: Colors.black,
                            textStyle: TextStyle(color: Colors.black)),
                        // style: ButtonStyle(
                        //     // foregroundColor: MaterialStateProperty.all(Colors.white),
                        //     backgroundColor:
                        //         MaterialStateProperty.all(Colors.white),
                        //     textStyle: MaterialStateProperty.all(
                        //         TextStyle(color: Colors.black))),
                        onPressed: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.play_arrow),
                            SizedBox(
                              width: 10,
                            ),
                            Text('재생'),
                          ],
                        )),
                  ),
                  Flexible(
                    fit: FlexFit.tight,
                    child: Column(
                      children: [
                        Icon(
                          Icons.download_sharp,
                          color: Colors.white,
                          size: 20,
                        ),
                        Text(
                          '저장',
                          textScaleFactor: .8,
                        )
                      ],
                    ),
                  ),
                  Flexible(
                    fit: FlexFit.tight,
                    child: Column(
                      children: [
                        Icon(
                          Icons.play_arrow_outlined,
                          color: Colors.white,
                          size: 20,
                        ),
                        Text(
                          '미리보기',
                          textScaleFactor: .8,
                        )
                      ],
                    ),
                  )
                ],
              ),
              Divider(
                height: 15,
                color: Colors.white,
              ),
              GestureDetector(
                onTap: () {
                  Get.back();
                  menuController.setHomeIndex(4);
                  setMovieId(data.id!);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.info_outline,
                          size: 16.sp,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          '상세정보',
                          style: TextStyle(fontSize: 12.sp),
                        )
                      ],
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                      size: 14.sp,
                    )
                  ],
                ),
              )
            ],
          ),
          Align(
            alignment: Alignment.topRight,
            child: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Container(
                // margin: EdgeInsets.only(top: 10,right: 10),
                padding: EdgeInsets.all(2),
                decoration: BoxDecoration(
                    color: Color(0xff4d4d4d),
                    borderRadius: BorderRadius.circular(50)),
                child: Icon(
                  Icons.close,
                  color: Colors.white,
                  size: 18.sp,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _movieCard(NowPlayingModel? nowPlaying) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 10),
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      itemCount: nowPlaying?.results?.length ?? 10,
      itemBuilder: (BuildContext context, int index) {
        if (nowPlaying == null) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 5),
            width: 0.28.sw,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4.0),
              child: Shimmer.fromColors(
                baseColor: Colors.grey,
                highlightColor: Colors.white,
                child: Container(
                  color: Colors.grey,
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
            ),
          );
        }

        return GestureDetector(
          onTap: () {
            Get.bottomSheet(_bottom(nowPlaying.results![index]),
                barrierColor: Colors.transparent);
          },
          child: Container(
            width: 0.28.sw,
            margin: EdgeInsets.symmetric(horizontal: 5),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4.0),
              child: ExtendedImage.network(
                  '${Constant.imageBaseUrl}${nowPlaying.results?[index].posterPath}'),
            ),
          ),
        );
        // return Text('${nowPlaying?.results?[index].title}');
      },
    );
  }

  Widget main(int homeIndex) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 200),
      transitionBuilder: (Widget child, Animation<double> animation) {
        final mainMenuAnimation =
            Tween<Offset>(begin: Offset(-1.0, 0.0), end: Offset(0.0, 0.0))
                .animate(animation);

        return FadeTransition(
          opacity: animation,
          child: child,
        );
        // return SlideTransition(
        //   position: mainMenuAnimation,
        //   child: child,
        // );
      },
      child: homeIndex == 0
          ? SingleChildScrollView(
              child: Column(
                children: [
                  _top(),
                  _nowPlaying(),
                  _nowPlaying(),
                  _nowPlaying(),
                  _nowPlaying(),
                ],
              ),
            )
          : SizedBox(),
    );
  }

  Widget sub(int homeIndex) {

    return AnimatedSwitcher(
        duration: Duration(milliseconds: 200),
        transitionBuilder: (Widget child, Animation<double> animation) {
          final subMenuAnimation =
              Tween<Offset>(begin: Offset(1.0, 0.0), end: Offset(0.0, 0.0))
                  .animate(animation);
          return FadeTransition(
            opacity: animation,
            child: child,
          );
          // return SlideTransition(
          //   position: subMenuAnimation,
          //   child: child,
          // );
        },
        child: _homeSub(homeIndex));
  }

  Widget _homeSub(int homeIndex) {
    if (homeIndex == 1 || homeIndex == 2) {
      return CategoryDetail();
    } else if (homeIndex == 4) {
      return MovieDetail(
        movieId: _movieId.toString(),
      );
    } else {
      return SizedBox();
    }

    // return homeIndex != 0 ? CategoryDetail() : SizedBox();
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
    super.build(context);

    return Obx(() => NestedScrollView(
          physics: BouncingScrollPhysics(),
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverAppBar(
                automaticallyImplyLeading: false,
                pinned: true,
                snap: menuController.homeIndex < 4  ? true : false,
                floating: menuController.homeIndex < 4 ? true : false,
                backgroundColor: menuController.homeIndex < 4 ? Colors.black.withOpacity(.5) :Colors.black,
                expandedHeight: menuController.homeIndex < 4 ? 100: 0,
                leading: menuController.homeIndex != 0
                    ? IconButton(
                        onPressed: () {
                          menuController.setHomeIndex(0);
                          menuController.menuController.reverse();
                          // controller.reverse();
                        },
                        icon: Icon(Icons.arrow_back),
                      )
                    : null,
                title: menuController.homeIndex != 0
                    ? _appBarTitle(menuController.homeIndex)
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
                bottom: menuController.homeIndex < 4 ?  PreferredSize(
                  child: Container(
                    color: Colors.transparent,
                    child: Container(
                      height: 40,
                      padding: EdgeInsets.only(left: animation.value),
                      child: Row(
                        children: [
                          Offstage(
                            offstage: menuController.homeIndex == 0 ||
                                    menuController.homeIndex == 1
                                ? false
                                : true,
                            child: Container(
                              margin: EdgeInsets.only(right: 15),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(50),
                                onTap: () {
                                  menuController.setHomeIndex(1);
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //     builder: (context) => CategoryDetail(),
                                  //   ),
                                  // );
                                  menuController.menuController.forward();
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
                            offstage: menuController.homeIndex == 0 ||
                                    menuController.homeIndex == 2
                                ? false
                                : true,
                            child: Container(
                              margin: EdgeInsets.only(right: 15),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(50),
                                onTap: () {
                                  menuController.setHomeIndex(2);
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //     builder: (context) => CategoryDetail(),
                                  //   ),
                                  // );
                                  menuController.menuController.forward();
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
                                menuController.homeIndex == 0 ? false : true,
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
                                          style: TextStyle(fontSize: 12.sp)),
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
                ) : PreferredSize(
                  preferredSize: const Size(0, 200),
                  child: Container(
                    height: 200,
                    width: 1.sw,
                    child: Text('df'),
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
              ),
            ];
          },
          body: Stack(
            children: <Widget>[
              main(menuController.homeIndex),
              sub(menuController.homeIndex)
            ],
          ),
          // slivers: <Widget>[
          //   SliverAppBar(
          //       automaticallyImplyLeading: false,
          //       pinned: true,
          //       snap: true,
          //       floating: true,
          //       backgroundColor: Colors.black.withOpacity(.5),
          //       expandedHeight: 100,
          //       leading: _isCategory
          //           ? IconButton(
          //               onPressed: () {
          //                 setIsCategory(false);
          //                 controller.reverse();
          //               },
          //               icon: Icon(Icons.arrow_back),
          //             )
          //           : null,
          //       title: _isCategory
          //           ? Text('시리즈')
          //           : Image.asset(
          //               'assets/images/logo.png',
          //               height: 60,
          //             ),
          //       centerTitle: false,
          //       actions: [
          //         IconButton(onPressed: () {}, icon: Icon(Icons.search_sharp)),
          //         IconButton(onPressed: () {}, icon: Icon(Icons.filter_list_sharp)),
          //         IconButton(onPressed: () {}, icon: Icon(Icons.person)),
          //       ],
          //       bottom: PreferredSize(
          //         child: Container(
          //           color: Colors.transparent,
          //           child: Container(
          //             height: 40,
          //             padding: EdgeInsets.only(left: animation.value),
          //             child: Row(
          //               children: [
          //                 InkWell(
          //                   borderRadius: BorderRadius.circular(50),
          //                   onTap: () {
          //                     setIsCategory(true);
          //                     // Navigator.push(
          //                     //   context,
          //                     //   MaterialPageRoute(
          //                     //     builder: (context) => CategoryDetail(),
          //                     //   ),
          //                     // );
          //                     controller.forward();
          //                   },
          //                   child: CircleAvatar(
          //                     backgroundColor: Colors.transparent,
          //                     foregroundColor: Colors.white,
          //                     child: Text(
          //                       '시리즈',
          //                       style: TextStyle(fontSize: 12.sp),
          //                     ),
          //                   ),
          //                 ),
          //                 SizedBox(
          //                   width: 20,
          //                 ),
          //                 Container(
          //                     padding: const EdgeInsets.symmetric(
          //                         horizontal: 10, vertical: 5),
          //                     child: Text('영화', style: TextStyle(fontSize: 12.sp))),
          //                 SizedBox(
          //                   width: 20,
          //                 ),
          //                 GestureDetector(
          //                   onTap: () {
          //                     Get.dialog(Category());
          //                   },
          //                   child: Container(
          //                       padding: const EdgeInsets.symmetric(
          //                           horizontal: 10, vertical: 10),
          //                       child: Row(
          //                         children: [
          //                           Text('카테고리', style: TextStyle(fontSize: 12.sp)),
          //                           Icon(
          //                             Icons.arrow_drop_down_sharp,
          //                             color: Colors.white,
          //                           )
          //                         ],
          //                       )),
          //                 ),
          //               ],
          //             ),
          //           ),
          //         ),
          //         preferredSize: const Size(0, 40),
          //       ),
          //       // flexibleSpace: FlexibleSpaceBar(
          //       //   background : Container(
          //       //       color: Colors.red,
          //       //       width: double.infinity,
          //       //       child: ExtendedImage.network('https://picsum.photos/200/300',width: 1,fit: BoxFit.cover)),
          //       // )
          //
          //       ),
          //   //
          //   // SliverToBoxAdapter(
          //   //   child: _top(),
          //   // ),
          //
          //   // SliverFixedExtentList(
          //   //   itemExtent: 50.0,
          //   //   delegate: SliverChildBuilderDelegate(
          //   //         (BuildContext context, int index) {
          //   //       return Container(
          //   //         alignment: Alignment.center,
          //   //         color: Colors.lightBlue[100 * (index + 1 % 9)],
          //   //         child: Text('List Item $index'),
          //   //       );
          //   //     },
          //   //   ),
          //   // ),
          //
          //   SliverList(
          //           delegate: SliverChildBuilderDelegate(
          //             (BuildContext context, int index) {
          //
          //               return MovieMain(isCategory: _isCategory,);
          //               if (index == 0) {
          //                 return _top();
          //               }
          //
          //               if (index == 1) {
          //                 return _nowPlaying();
          //               }
          //
          //               return Container(
          //                 color: index.isOdd ? Colors.white : Colors.black12,
          //                 height: 100.0,
          //                 child: Center(
          //                   child: Text('$index', textScaleFactor: 5),
          //                 ),
          //               );
          //             },
          //             childCount: 1,
          //           ),
          //         ),
          // ],
        ));

    // return Scaffold(
    //   body: Column(
    //     children: [
    //       const Text('movie home'),
    //       ElevatedButton(
    //           onPressed: () {
    //             // Get.to(MovieDetail(),transition: Transition.rightToLeft);
    //             // Navigator.push(
    //             //   context,
    //             //   MaterialPageRoute(
    //             //     builder: (context) => MovieDetail(),
    //             //   ),
    //             // );
    //             Navigator.of(context).push(_createRoute());
    //           },
    //           child: Text('push'))
    //     ],
    //   ),
    // );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

// Route _createRoute() {
//   return PageRouteBuilder(
//     pageBuilder: (context, animation, secondaryAnimation) =>
//          MovieDetail(),
//     transitionsBuilder: (context, animation, secondaryAnimation, child) {
//       const begin = Offset(1.0, 0.0);
//       const end = Offset.zero;
//       const curve = Curves.easeIn;
//
//       var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
//
//       return FadeTransition(
//         opacity: animation,
//         child: child,
//       );
//       // return SlideTransition(
//       //   position: animation.drive(tween),
//       //   child: child,
//       // );
//     },
//   );
// }
