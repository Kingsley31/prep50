import 'package:flutter/material.dart';
import 'package:prep50/utils/color.dart';

class AppBackIcon extends StatelessWidget {
  final Function()? onTap;
  final bool reverseColor;
  const AppBackIcon({Key? key,this.onTap,this.reverseColor=false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap??() => Navigator.pop(context),
      child: Container(
        height: 22,
        width: 22,
        decoration: BoxDecoration(shape: BoxShape.circle, color:reverseColor?Colors.white: kPrimaryColor),
        child: Icon(
          Icons.arrow_back_ios_rounded,
          color: reverseColor?kPrimaryColor:Color(0xffffffff),
          size: 15,
        ),
      ),
    );
  }
}
