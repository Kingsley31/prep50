import 'package:flutter/material.dart';
import 'package:prep50/utils/color.dart';
import 'package:prep50/utils/text.dart';

class SubjectWidget extends StatelessWidget {
  const SubjectWidget({
    Key? key,
    required this.color,
    required this.title,
    required this.subject,
    this.subtitle,
    this.selected: false,
  }) : super(key: key);
  final String title;
  final String subject;
  final String? subtitle;
  final bool selected;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 75,
          width: double.infinity,
          color: Color(0xffffffff),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      color: color, borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: AppText.heading6(
                      title,
                      color: Color(0xffffffff),
                    ),
                  ),
                ),
                SizedBox(
                  width: 12,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppText.heading6(
                      subject,
                      color: Color(0xff000000),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    subtitle == null
                        ? SizedBox()
                        : AppText.captionText(
                            "$subtitle",
                            color: kAccentColor[400],
                          ),
                  ],
                ),
                Spacer(),
                selected
                    ? Icon(
                        Icons.check_box_outlined,
                        size: 40,
                        color: kPrimaryColor,
                      )
                    : SizedBox(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
