import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prep50/utils/color.dart';
import 'package:prep50/utils/text.dart';
import 'package:prep50/views/prep_study_view/tutorial_view/study_screen.dart';

class TopicCard extends StatelessWidget {
  const TopicCard(
      {Key? key,
      this.showIcon: false,
      required this.topic,
      this.passmark,
      this.passcolor: false})
      : super(key: key);
  final String topic;
  final String? passmark;
  final bool passcolor;
  final bool showIcon;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap: () => Navigator.push(
      //     context, MaterialPageRoute(builder: (context) => StudyScreen())),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: AppText.heading6(
              topic,
              color: Color(0xff666666),
              multiText: true,
            ),
          ),
          SizedBox(width: 20,),
          Container(
            height: 25,
            width: 32,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: passcolor ? kSuccessLight : kErrorLightColor),
            child: Center(
              child: showIcon
                  ? Icon(Icons.play_arrow_outlined)
                  : Text(
                      passmark!,
                      style: GoogleFonts.sarabun(
                          color: passcolor ? kSuccessColor : kErrorColor,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          letterSpacing: -0.04),
                    ),
            ),
          )
        ],
      ),
    );
  }
}
