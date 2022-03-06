import 'package:flutter/material.dart';
import 'package:netflix_clone/test/test_page.dart';

class TestHome extends StatefulWidget {
  const TestHome({Key? key}) : super(key: key);

  @override
  State<TestHome> createState() => _TestHomeState();
}

class _TestHomeState extends State<TestHome> {
  List<Widget> _widgets = [];

  int page = 0;

  void _back() {}

  void callback() {
    print('callback home');
  }

  final GlobalKey<_TestHomeState> _myWidgetState = GlobalKey<_TestHomeState>();

  @override
  Widget build(BuildContext context) {
    print(page);
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return [
          SliverAppBar(
            pinned: true,
            title: Text('title'),
            actions: [
              IconButton(
                color: Colors.white,
                onPressed: () {
                  setState(() {
                    page++;
                    _widgets.add(TestPage(content: 'page $page'));
                  });
                },
                icon: Icon(Icons.add),
              ),
              IconButton(
                color: Colors.white,
                onPressed: () {
                  setState(() {
                    if (0 < page) {
                      page--;
                      _widgets.removeLast();
                      _back();
                    }
                  });
                },
                icon: Icon(Icons.exposure_minus_1),
              )
            ],
          )
        ];
      },
      body: Scaffold(
        body: Stack(
          // index: page,
          children: [
            page < 2
                ? TestPage(
                    content: 'default',
                  )
                : _widgets[page - 2],
            AnimatedSwitcher(
              duration: Duration(milliseconds: 500),
              transitionBuilder: (Widget child, Animation<double> animation) {
                final mainMenuAnimation = Tween<Offset>(
                        begin: Offset(1.0, 0.0), end: Offset(0.0, 0.0))
                    .animate(animation);
                return SlideTransition(
                  position: mainMenuAnimation,
                  child: child,
                );
              },
              child: page == 0
                  ? SizedBox()
                  : (page.isOdd
                      ? _widgets[page - 1]
                      : Container(
                          child: _widgets[page - 1],
                        )),
            )
          ],
          //   children : _widgets
        ),
      ),
    );
  }
}
