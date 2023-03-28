import 'package:flutter/material.dart';
import 'package:prep50/utils/color.dart';

class AppBackIcon extends StatelessWidget {
  const AppBackIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Container(
        height: 22,
        width: 22,
        decoration: BoxDecoration(shape: BoxShape.circle, color: kPrimaryColor),
        child: Icon(
          Icons.arrow_back_ios_rounded,
          color: Color(0xffffffff),
          size: 15,
        ),
      ),
    );
  }
}
