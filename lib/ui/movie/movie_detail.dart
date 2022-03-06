import 'package:dio/dio.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../get_controller/api_controller.dart';
import '../../models/movie/details_model.dart';
import '../../models/movie/error_model.dart';
import '../../models/movie/now_palying_model.dart';
import '../../util/constant.dart';

class MovieDetail extends StatefulWidget {
  final String movieId;

  MovieDetail({Key? key, required this.movieId}) : super(key: key);

  @override
  State<MovieDetail> createState() => _MovieDetailState();
}

class _MovieDetailState extends State<MovieDetail> {
  late ApiController apiController;
  DetailsModel? _detailResult;
  ErrorModel? _fetchError;

  NowPlayingModel? similar;

  void fetchDetails() async {
    try {
      _detailResult = await apiController.api
          .getDetails(widget.movieId, Constant.apiKey, Constant.language);
      print("nowPlaying $_detailResult");
    } on DioError catch (e) {
      _fetchError = ErrorModel.fromJson(e.response?.data);
      // print('eeeee : ${e.response}');
      // print('eeeee statusCode: ${e.response?.statusCode}');
      // print("e.response?.data : ${e.response?.data}");
      // print("e.response?.headers :: ${e.response?.headers}");
      // print("e.response?.requestOptions : ${e.response?.requestOptions}");
    } finally {
      setState(() {});
    }
  }

  void fetchSimilar() async {
    try {
      similar = await apiController.api
          .getSimilar(widget.movieId, Constant.apiKey, Constant.language, "1");
    } on DioError catch (e) {
      print('error fetch ${e.response?.data}');
      similar = NowPlayingModel.fromJson(e.response?.data);
    } finally {
      setState(() {});
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apiController = Get.find<ApiController>();

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      fetchDetails();
      fetchSimilar();
    });
  }
  //
  // @override
  // void dispose(){
  //   super.dispose();
  //
  //   print('dispose');
  // }


  String calRunTime(int runtime) {
    // int time = int.parse(runtime);

    int hour = runtime ~/ 60;
    int min = runtime % 60;

    return '$hour시간 $min분';
  }

  List<Widget> _genres(List<Genres>? genres) {
    List<Widget> _g = [];
    if (genres != null) {
      for (var i = 0; i < genres.length; i++) {
        _g.add(Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(vertical: 3, horizontal: 5),
            margin: EdgeInsets.only(right: 5),
            constraints: BoxConstraints(minWidth: 35),
            decoration: BoxDecoration(
                // color: Color(0xff404040),
                color: Colors.grey.shade900,
                borderRadius: BorderRadius.circular(50)),
            child: Text(
              '${genres[i].name}',
              style: TextStyle(fontSize: 12.sp, color: Colors.grey),
            )));
      }
    }
    return _g;
  }

  @override
  Widget build(BuildContext context) {
    // print("movieId : ${widget.movieId}");
    // print("_detailResult: $_detailResult");
    // print("_fetchError: $_fetchError");
// return CustomScrollView(
//   slivers: _sliverList(50, 10),)
// ;

    if (_detailResult == null) {
      return CircularProgressIndicator();
    }
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(child: ExtendedImage.network('${Constant.imageBaseUrl}${_detailResult?.posterPath}',width: 0.8.sw,height: 1.2.sw,)),
          SizedBox(
            height: 10,
          ),
          Text(
            '${_detailResult!.title}',
            style: TextStyle(fontSize: 20.sp),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Text(
                '${_detailResult?.releaseDate?.substring(0, 4)}',
                style: TextStyle(color: Colors.grey),
              ),
              SizedBox(
                width: 10,
              ),
              Text(calRunTime(_detailResult?.runtime ?? 0),
                  style: TextStyle(color: Colors.grey)),
              SizedBox(
                width: 10,
              ),
              Icon(
                Icons.star,
                color: Colors.grey,
                size: 14.sp,
              ),
              Text('${_detailResult?.voteAverage}',
                  style: TextStyle(color: Colors.grey)),
              // Text(
              //     '${_detailResult?.genres?.map((e) => e.name).toString().replaceAll('(', '').replaceAll(')', '')}',
              //     style: TextStyle(color: Colors.grey))
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(children: _genres(_detailResult?.genres)),
          SizedBox(
            height: 20,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              '${_detailResult!.tagline}',
              style: TextStyle(color: Colors.grey),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text('${_detailResult!.overview}'),
          Divider(
            color: Colors.grey,
            thickness: 1.5,
            height: 50,
          ),
          Text('비슷한 콘텐츠'),
          GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: similar?.results?.length ?? 1,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 20.0,
            ),
            itemBuilder: (BuildContext context, int index) {
              return ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: ExtendedImage.network(
                    '${Constant.imageBaseUrl}${similar?.results?[index].posterPath}',
                    width: 100,
                  ));
            },
          )
        ],
      ),
    );
    // return CustomScrollView(
    //   slivers: [
    //     SliverAppBar(
    //       pinned: true,
    //       snap: false,
    //       floating: false,
    //       expandedHeight: 160.0,
    //       bottom: PreferredSize(preferredSize: Size(0,100),
    //       child: Container('hi'),
    //
    //       ),
    //       flexibleSpace: const FlexibleSpaceBar(
    //         title: Text('SliverAppBar'),
    //         background: FlutterLogo(),
    //       ),
    //     ),
    //     const SliverToBoxAdapter(
    //       child: SizedBox(
    //         height: 20,
    //         child: Center(
    //           child: Text('Scroll to see the SliverAppBar in effect.'),
    //         ),
    //       ),
    //     ),
    //     SliverList(
    //       delegate: SliverChildBuilderDelegate(
    //             (BuildContext context, int index) {
    //           return Container(
    //             color: index.isOdd ? Colors.white : Colors.black12,
    //             height: 100.0,
    //             child: Center(
    //               child: Text('$index', textScaleFactor: 5),
    //             ),
    //           );
    //         },
    //         childCount: 20,
    //       ),
    //     )
    //   ],
    // );

    // return Scaffold(
    //   body: Stack(
    //     children: [
    //       Container(
    //       color: Colors.red,
    //         child: Text('movie detail'),
    //       ),
    //       ElevatedButton(onPressed: (){
    //         Navigator.push(
    //           context,
    //           MaterialPageRoute(
    //             builder: (context) => MovieDetail2(),
    //           ),
    //         );
    //       }, child: Text('gogo'))
    //     ],
    //   ),
    // );
  }
}
