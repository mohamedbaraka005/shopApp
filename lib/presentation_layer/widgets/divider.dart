import 'package:flutter/material.dart';
class AppDivider extends StatelessWidget {
  Color color = Colors.grey[500];
   AppDivider({Key key , this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      height: 0.5,
      width: double.infinity,
    );
  }
}
