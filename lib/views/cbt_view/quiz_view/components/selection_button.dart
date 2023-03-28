import 'package:flutter/material.dart';
import 'package:prep50/utils/color.dart';
import 'package:prep50/utils/text.dart';
import 'package:prep50/views/cbt_view/quiz_view/celebration_Screen.dart';
import 'package:prep50/widgets/app_button.dart';

class ExamSelectButton extends StatelessWidget {
  // const ExamSelectButton({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Container(
          height: 150,
          width: double.infinity,
          color: Color(0xfffffff),
        ),
        Container(
          height: 118,
          width: double.infinity,
          decoration: BoxDecoration(color: Color(0xffffffff)),
          child: Padding(
            padding: const EdgeInsets.only(top: 35, left: 15, right: 15),
            child: Row(
              children: [
                AppButton(
                  color: false,
                  title: "Previous",
                  width: 136,
                ),
                Expanded(
                  child: AppButton(
                    color: true,
                    title: "View",
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => CelebrationScreen())),
                    // width: 197,
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 7,
          left: 115,
          child: Container(
            height: 53,
            width: 144,
            decoration: BoxDecoration(
                border: Border.all(
                    color: Color(0xffADADAD).withOpacity(0.2),
                    style: BorderStyle.solid),
                color: Color(0xffffffff),
                borderRadius: BorderRadius.circular(80)),
            child: Center(
              child: AppText.heading6S(
                "Pick",
                color: kPrimaryColor[400],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
