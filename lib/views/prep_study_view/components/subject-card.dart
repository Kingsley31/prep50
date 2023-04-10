
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/color.dart';
import '../../../utils/text.dart';

class SubjectCard extends StatelessWidget {
  final String title;
  final String? time;
  final String subject;
  final String? subtitle;
  final String? passmark;
  final bool selected;
  final bool passColor;
  final Color color;
  final Function()? onTap;


  const SubjectCard({Key? key,
    required this.color,
    required this.title,
    required this.subject,
    this.passmark,
    this.passColor: false,
    this.subtitle,
    this.selected: false,
    this.time,
    this.onTap
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(15),
        height: 75,
        width: double.infinity,
        color: Color(0xffffffff),
        child:  Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 50.0,
              width: 50.0,
              decoration: BoxDecoration(
                  color: color, borderRadius: BorderRadius.circular(10)),
              child: Center(
                child: AppText.heading6(
                  title,
                  color: Color(0xffffffff),
                ),
              ),
            ),
            SizedBox(width: 10,),
            Expanded(
              flex: 2,
              child: Column(
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
            ),
            SizedBox(width: 10,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  width: 32,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color:
                      passColor ? kSuccessLight : kErrorLightColor),
                  child: Center(
                    child: Text(
                      passmark!,
                      style: GoogleFonts.sarabun(
                          color: passColor ? kSuccessColor : kErrorColor,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          letterSpacing: -0.04),
                    ),
                  ),
                ),
                Spacer(),
                Expanded(
                  flex: 2,
                    child:Container()
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
