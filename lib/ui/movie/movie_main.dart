import 'package:flutter/material.dart';

import '../category/category_detail.dart';

class MovieMain extends StatelessWidget {
  final bool isCategory;
  const MovieMain({Key? key, required this.isCategory}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    print(isCategory);
    return Stack(
      children: <Widget>[main(), sub()],
    );
  }
  Widget main() {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 300),
      transitionBuilder: (Widget child, Animation<double> animation) {
        final mainMenuAnimation =
        Tween<Offset>(begin: Offset(-1.0, 0.0), end: Offset(0.0, 0.0))
            .animate(animation);
        return SlideTransition(
          position: mainMenuAnimation,
          child: child,
        );
      },
      child: isCategory
          ? SizedBox()
          : Text('hi'),
    );
  }

  Widget sub() {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 300),
      transitionBuilder: (Widget child, Animation<double> animation) {
        final subMenuAnimation =
        Tween<Offset>(begin: Offset(1.0, 0.0), end: Offset(0.0, 0.0))
            .animate(animation);
        return SlideTransition(
          position: subMenuAnimation,
          child: child,
        );
      },
      child: isCategory ? CategoryDetail() : SizedBox(),
    );
  }
}
