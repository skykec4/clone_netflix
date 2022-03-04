import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:netflix_clone/ui/app_main.dart';

class IndexProfile extends StatelessWidget {
  IndexProfile({Key? key}) : super(key: key);

  final List<String> _profile = ['skykec4', '1234', 'test', 'gooood'];

  Widget _profileCard(String name, int index) {
    return Column(
      children: [
        GestureDetector(
          onTap: (){
            Get.offAll(const AppMain());
          },
          child: SizedBox(
              width: 0.3.sw,
              height: 0.3.sw,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4.0),
                child: ExtendedImage.network(
                  'https://picsum.photos/200?$index',
                  fit: BoxFit.cover,
                ),
              )
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(name)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Colors.black,
        appBar: AppBar(
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.edit,
                  size: 20,
                ))
          ],
          title: Image.asset(
            'assets/images/logo2.png',
            color: Colors.red,
            height: 50,
          ),
        ),
        body: SizedBox(
          width: 1.sw,
          height: 1.sh,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text('넷플릭스를 시청할 프로필을 선택하세요.'),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  padding: const EdgeInsets.all(30),
                  itemCount: _profile.length,
                  itemBuilder: (BuildContext context, int index) {
                    return _profileCard(_profile[index], index);
                  },
                ),
              )
            ],
          ),
        ));
  }
}
