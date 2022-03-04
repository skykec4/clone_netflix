import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Category extends StatelessWidget {
  final String? selected;

  Category({Key? key, this.selected}) : super(key: key);

  final List<String> _categoryList = [
    '한국',
    '외국',
    '아시아',
    '액션',
    '코미디',
    '어린이 & 가족',
    '로맨스',
    '드라마 장르',
    '호러',
    '스릴러',
    'SF',
    '판타지'
        '버라이어이 / 예능',
    '애니메이션',
    '다큐멘터리',
    '평론가 호평',
    '할리우드',
    '음악 & 뮤지컬',
    '음성 지원'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(.7),
      body: Stack(
        children: [
          ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.only(top: 100,bottom: 100),
            physics: BouncingScrollPhysics(),
            itemCount: _categoryList.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(vertical: 15),
                  child: Text(
                    _categoryList[index],
                    style: TextStyle(
                        color: selected == _categoryList[index]
                            ? Colors.white
                            : Colors.white70),
                  ));
            },
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: InkWell(
              onTap: () {
                Get.back();
              },
              borderRadius: BorderRadius.circular(50),
              focusColor: Colors.red,
              highlightColor: Colors.blue,
              hoverColor: Colors.amber,
              child: Container(
                width: 50,
                height: 50,
                margin: EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(

                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50)),
                child: Icon(Icons.close),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
