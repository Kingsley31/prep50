import 'package:flutter/material.dart';
import 'package:prep50/utils/color.dart';
import 'package:prep50/utils/text.dart';

class AnswerCard extends StatelessWidget {
  const AnswerCard({Key? key, this.index}) : super(key: key);

  final int? index;
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 247,
      // width: 344,
      color: Color(0xffffffff),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.5, vertical: 10),
            child: Row(
              children: [
                AppText.heading6S("Question $index"),
                Spacer(),
                Icon(Icons.keyboard_arrow_up_rounded),
              ],
            ),
          ),
          Divider(
            color: Color(0xffE5E5E5),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.5, vertical: 10),
            child: Column(
              children: [
                Container(
                  child: Column(
                    children: [
                      AppText.textField(
                        "The concept and theory of government"
                        " was defined by which of the following lords "
                        "of monarch and what year was the theory instituted?",
                        multiText: true,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    AppText.textField("Correct Answer"),
                  ],
                ),
                SizedBox(height: 10),
                Container(
                  height: 67,
                  width: 313,
                  decoration: BoxDecoration(color: Color(0xfffff4f0)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppText.heading6(
                        "Option 2 :",
                        color: kPrimaryColor,
                      ),
                      SizedBox(width: 5),
                      AppText.heading6(
                        "Dr. Philaphlous David in 1880",
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
