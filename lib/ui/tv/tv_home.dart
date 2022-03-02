import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'tv_detail.dart';

class TvHome extends StatelessWidget {
  const TvHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('TvHome'),
        ElevatedButton(
            onPressed: () {
              // Get.to(TvDetail());
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TvDetail(),
                ),
              );
            },
            child: Text('push'))
      ],
    );
  }
}
