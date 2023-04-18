import 'package:flutter/material.dart';
import 'package:prep50/models/question.dart';
import 'package:prep50/utils/color.dart';
import 'package:prep50/utils/text.dart';

class AnswerCard extends StatelessWidget {
  const AnswerCard({Key? key, this.index,required this.question}) : super(key: key);

  final int? index;
  final Question question;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10))
      ),
      child: ExpansionTile(
        initiallyExpanded: true,
        childrenPadding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
        title: AppText.heading6S("Question $index"),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText.textField(
                question.question,
                multiText: true,
              ),
              SizedBox(height: 20),
              AppText.textField("Correct Answer"),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.all(20),
                width: 313,
                decoration: BoxDecoration(color: Color(0xfffff4f0)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    AppText.heading6(
                      "${question.shortAnswer.replaceAll("_", " ")} :",
                      color: kPrimaryColor,
                    ),
                    SizedBox(width: 5),
                    Expanded(
                        child: AppText.heading6(
                          "${question.toJson()[question.shortAnswer]}",
                        ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
