import 'package:flutter/material.dart';
import 'package:prep50/utils/color.dart';
import 'package:prep50/utils/text.dart';
import 'package:prep50/views/cbt_view/components/subject_widget.dart';

class ExamScreen extends StatelessWidget {
  // const ExamScreen ({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kAccentColor[200],
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 48,
            width: double.infinity,
            color: Color(0xffffffff),
          ),
          Container(
            height: 48,
            width: double.infinity,
            color: Color(0xffffffff),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  AppText.heading5M("Cbt Exam Practice"),
                  Spacer(),
                  Icon(Icons.info_outline_rounded),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: AppText.captionText(
              "Kindly, select 3 more subjects to proceed with the exam.",
            ),
          ),
          SizedBox(height: 6),
          SubjectWidget(
            color: Colors.red,
            title: "ENG",
            subject: "English",
            subtitle: "This is a compulsory selected subject",
            selected: true,
          )
        ],
      ),
    );
  }
}
