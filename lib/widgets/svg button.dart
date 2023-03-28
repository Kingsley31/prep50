import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:prep50/utils/color.dart';
import 'package:prep50/utils/text.dart';

class SvgButton extends StatelessWidget {
  const SvgButton({
    Key? key,
    required this.title,
    required this.width,
    required this.assets,
    this.color,
  }) : super(key: key);
  final String title;
  final double width;
  final String assets;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Container(
        height: 53,
        width: width,
        decoration: BoxDecoration(
          color: color != null
              ? color!.withOpacity(0.15)
              : kPrimaryColor.withOpacity(0.15),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(assets),
              SizedBox(width: 10),
              AppText.heading6S(
                title,
                color: color ?? kPrimaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
