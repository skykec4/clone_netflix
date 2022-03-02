import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:netflix_clone/get_controller/api_controller.dart';

import '../../models/movie/now_palying_model.dart';
import '../../util/constant.dart';
import 'package:dio/dio.dart';

class SaveHome extends StatefulWidget {
  const SaveHome({Key? key}) : super(key: key);

  @override
  State<SaveHome> createState() => _SaveHomeState();
}

class _SaveHomeState extends State<SaveHome> {
  late ApiController apiController;

  NowPlayingModel? nowPlaying;

  // NowPlayingModel

  void test() async {
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
    test();

    //     .then((value) {
    //   print('getget $value');
    //   setState(() {
    //     nowPlaying = value;
    //   });
    // }).catchError((onError) {
    //   setState(() {
    //     nowPlaying = null;
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    print("nowPlaying !! : $nowPlaying");
    // print("nowPlaying !! : ${nowPlaying["results"]}");
    return Column(
      children: [const Text('SaveHome'), _nowPlaying()],
    );
  }

  Widget _nowPlaying() {
    if (nowPlaying == null) {
      return const CircularProgressIndicator();
    } else if (nowPlaying?.statusCode != null) {
      return Column(
        children: [
          Text('${nowPlaying?.statusCode}'),
          Text('${nowPlaying?.statusMessage}'),
          ElevatedButton(onPressed: () {
            test();
          }, child: Text('rerload'))
        ],
      );
    } else {
      return Expanded(
        child: ListView.builder(
            itemCount: nowPlaying?.results?.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Text('${nowPlaying?.results?[index].title}'),
                  Text('${nowPlaying?.results?[index].voteAverage}'),
                ],
              );
            }),
      );
    }
  }
}
