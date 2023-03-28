import 'package:flutter/material.dart';
import 'package:prep50/utils/color.dart';
import 'package:prep50/utils/text.dart';

class TimeBox extends StatelessWidget {
  const TimeBox({Key? key, required this.item, required this.time})
      : super(key: key);
  final String item;
  final String time;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 34,
          width: 42,
          decoration: BoxDecoration(
            color: Color(0xffffE8E0),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: AppText.heading4S(
              item,
              color: kPrimaryColor,
            ),
          ),
        ),
        SizedBox(height: 16),
        AppText.heading6(time)
      ],
    );
  }
}
