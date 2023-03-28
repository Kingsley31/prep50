import 'package:flutter/material.dart';
import 'package:prep50/utils/color.dart';
import 'package:prep50/utils/text.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    Key? key,
    required this.title,
    this.width,
    required this.color,
    this.onTap,
  }) : super(key: key);
  final String title;
  final double? width;
  final bool color;
  final Function? onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: InkWell(
        onTap: onTap as void Function()?,
        child: Container(
          height: 53,
          width: width,
          decoration: BoxDecoration(
              color: color ? kPrimaryColor : kPrimaryColor[300],
              borderRadius: BorderRadius.circular(10)),
          child: Center(
            child: AppText.heading6S(
              title,
              color: color ? Color(0xffffffff) : kPrimaryColor,
            ),
          ),
        ),
      ),
    );
  }
}

class AppButtonMain extends StatelessWidget {
  const AppButtonMain({
    Key? key,
    required this.title,
    this.width,
    this.color,
    this.onTap,
    this.textColor,
  }) : super(key: key);
  final String title;
  final double? width;
  final Color? color;
  final Color? textColor;
  final Function? onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: InkWell(
        onTap: onTap as void Function()?,
        child: Container(
          height: 53,
          width: width,
          decoration: BoxDecoration(
              color: color ?? kPrimaryColor,
              borderRadius: BorderRadius.circular(10)),
          child: Center(
            child: AppText.heading6S(
              title,
              color: textColor ?? Color(0xffffffff),
            ),
          ),
        ),
      ),
    );
  }
}
