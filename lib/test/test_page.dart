import 'package:flutter/material.dart';

class TestPage extends StatefulWidget {
  final String content;

  TestPage({Key? key, required this.content}) : super(key: key);

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> with TickerProviderStateMixin {
  // late AnimationController _animationController;
  // late Animation<Offset> animation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _animationController = AnimationController(
    //     duration: const Duration(milliseconds: 300), vsync: this);
    //
    // // Tween<Offset>(begin: Offset(-1.0, 0.0), end: Offset(0.0, 0.0))
    // //     .animate(animation);
    // //
    // animation = Tween<Offset>(begin: Offset(1.0, 0.0), end: Offset(0.0, 0.0))
    //     .animate(
    //         CurvedAnimation(parent: _animationController, curve: Curves.easeIn))
    //   ..addListener(() {
    //     setState(() {
    //     });
    //   });

  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    print('bye');

    // _animationController.dispose();

  }
  void reverse(){
    // _animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.blue,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ElevatedButton(
              onPressed: () {
                print('click');
                // _animationController.forward();
              },
              child: Text('test11')),
          Container(
            color: Colors.red,
            width: 300,
            height: 300,
            child: ElevatedButton(
                onPressed: () {
                  // _animationController.reverse();

                },
                child: Text(widget.content)),
          ),
        ],
      ),
    );
  }
}
