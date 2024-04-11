import 'package:flutter/material.dart';

class ReusableContainerWidget extends StatelessWidget {
  final Widget child;

  ReusableContainerWidget({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.0),
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.black12,
        //     blurRadius: 1.0,
        //     spreadRadius: 6.0,
        //     offset: Offset(0, 1),
        //   ),
        // ],
      ),
      child: child,
    );
  }
}
