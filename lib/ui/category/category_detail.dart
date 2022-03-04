import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryDetail extends StatelessWidget {
  CategoryDetail({Key? key}) : super(key: key);

  List<String> test = [
    'a',
    'b',
    'c',
    'd',
    'e',
    'f',
    'g',
    'h',
    'a!',
    'b',
    'c',
    'd',
    'e',
    'f',
    'g',
    'h',
    'a',
    'b',
    'c',
    'd',
    'e',
    'f',
    'g!',
    'h',
    'a',
    'b',
    'c',
    'd',
    'e',
    'f',
    'g',
    'h',
    'a!',
    'b',
    'c',
    'd',
    'e',
    'f',
    'g',
    'h',
    'a',
    'b',
    'c',
    'd',
    'e',
    'f',
    'g!',
    'h'
  ];


  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: test.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
              padding: EdgeInsets.all(5),
              margin: EdgeInsets.all(5),
              child: Text(test[index]));
        },
      ),
    );
    return Expanded(
      child: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return Container(
            color: index.isOdd ? Colors.white : Colors.black12,
            height: 100.0,
            child: Center(
              child: Text('$index', textScaleFactor: 5),
            ),
          );
        },
      ),
    );
  }
}
