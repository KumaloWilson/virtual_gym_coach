import 'package:flutter/material.dart';
import 'package:virtual_gym_coach/global/global.dart';

class TextFieldContainer extends StatelessWidget {
  final Widget child;

  TextFieldContainer({
    required this.child,
  });
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 2),
      decoration: BoxDecoration(
        color: secColor,
        borderRadius: BorderRadius.circular(29)
      ),
      child: child,
    );
  }
}
