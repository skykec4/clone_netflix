import 'package:flutter/material.dart';

import 'movie_detail.dart';

class MovieHome extends StatelessWidget {
  const MovieHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('movie home');
    return Scaffold(
      body: Column(
        children: [
          const Text('movie home'),
          ElevatedButton(
              onPressed: () {
                // Get.to(TvDetail());
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MovieDetail(),
                  ),
                );
              },
              child: Text('push'))
        ],
      ),
    );
  }
}
