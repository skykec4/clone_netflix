import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../get_controller/api_controller.dart';
import '../../models/movie/details_model.dart';
import '../../models/movie/error_model.dart';
import '../../util/constant.dart';
import 'package:dio/dio.dart';

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
  void fetchDetails() async {

    try {

      _detailResult = await apiController.api.getDetails(widget.movieId, Constant.apiKey, Constant.language);
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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apiController = Get.find<ApiController>();

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      fetchDetails();
    });
  }

  @override
  Widget build(BuildContext context) {
    print("movieId : ${widget.movieId}");
    print("_detailResult: $_detailResult");
    print("_fetchError: $_fetchError");
// return CustomScrollView(
//   slivers: _sliverList(50, 10),)
// ;

    if(_detailResult == null){
      return CircularProgressIndicator();
    }
    return SingleChildScrollView(
      child: Column(
        children: [
          Text('${_detailResult!.title}'),
          Text('${_detailResult!.title}'),
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
