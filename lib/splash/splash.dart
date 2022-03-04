import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:netflix_clone/util/constant.dart';

import '../ui/profile/index_profile.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }

  void init() async {
    //로그인 체크 확인후 어디로 보낼지 분기

    await Future.delayed(const Duration(milliseconds: 500), () {
      Get.offAll(IndexProfile(),
          transition: Transition.fadeIn,
          duration: const Duration(milliseconds: 1000));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Constant.colorMain,
        body: Container(
            alignment: Alignment.center,
            child: Image.asset(
              'assets/images/logo2.png',
              color: Colors.red,
              width: 0.55.sw,
            )));
  }
}
