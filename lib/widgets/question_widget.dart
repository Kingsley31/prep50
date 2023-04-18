import 'package:flutter/material.dart';
import 'package:prep50/utils/color.dart';
import 'package:prep50/utils/text.dart';
import 'package:prep50/views/cbt_view/quiz_view/components/selection_button.dart';
import 'package:prep50/widgets/app_back_icon.dart';
import 'package:prep50/widgets/question_box.dart';

class QuestionWidget extends StatelessWidget {
  // const QUestionWidget({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xeeeeeeee),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            width: double.infinity,
            color: Colors.white,
            child: Column(
              children: [
                SafeArea(
                  child: Row(
                    children: [
                      AppBackIcon(),
                      SizedBox(
                        width: 26,
                      ),
                      AppText.heading6S("Weekly Quiz"),
                      Spacer(),
                      Icon(Icons.info_outline_rounded),
                    ],
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    AppText.heading6("Question 1 of 20"),
                    Spacer(),
                    Icon(Icons.timelapse_outlined),
                    SizedBox(width: 2),
                    AppText.heading6("00:30")
                  ],
                ),
                SizedBox(height: 20),
                Container(
                  // height: 164,
                  // width: 343,
                  decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Center(
                          child: AppText.textFieldS(
                            "The concept and theory of government was"
                            " defined by which of the following lords "
                            "of monarchs and what year was the theory instituted.",
                            centered: true,
                            color: Colors.white,
                            multiText: true,
                          ),
                        ),
                        SizedBox(height: 24),
                        Container(
                            height: 38,
                            width: 155,
                            decoration: BoxDecoration(color: Color(0xffEB3C00)),
                            child: Center(
                              child: AppText.captionTextS(
                                "Read comprehension",
                                color: Colors.white,
                              ),
                            )),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          QuestionBox(value: "option_1",),
          QuestionBox(value: "option_2",),
          QuestionBox(value: "option_3",),
          QuestionBox(value: "option_4",),
          Expanded(child: ExamSelectButton())
        ],
      ),
    );
  }
}
