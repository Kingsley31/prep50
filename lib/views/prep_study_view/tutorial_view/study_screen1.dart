import 'package:flutter/material.dart';
import 'package:prep50/utils/color.dart';
import 'package:prep50/utils/text.dart';
import 'package:prep50/views/prep_study_view/tutorial_view/study_widget.dart';
import 'package:prep50/widgets/app_button.dart';

class StudyScreen1 extends StatelessWidget {
  // const StudyScreen1(
  //     {Key key,})
  //     : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      // floatingActionButton: FloatingActionButton(
      //   // onPressed: (),
      //   backgroundColor: Color(0xffffffff),
      //   child: Container(
      //       height: 35,
      //       width: 35,
      //       color: Color(0xfffff4f0),
      //       child: Row(
      //         mainAxisAlignment: MainAxisAlignment.center,
      //         children: [
      //           AppText.heading2S("T"),
      //           AppText.heading5S("T"),
      //         ],
      //       )),
      // ),
      backgroundColor: Color(0xffffffff),
      body: Column(
        children: [
          Container(
            height: 92,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(13.5),
                  child: Row(
                    children: [
                      Container(
                        height: 22,
                        width: 22,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: kPrimaryColor),
                        child: Icon(
                          Icons.arrow_back_ios_rounded,
                          color: Color(0xffffffff),
                          size: 15,
                        ),
                      ),
                      SizedBox(
                        width: 17,
                      ),
                      AppText.heading5M("Basics and concept of Government")
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Divider(
          //   color: Color(0xffE5E5E5),
          // ),
          SizedBox(height: 2),
          Expanded(child: StudyWidget()),
          Row(
            children: [
              Expanded(
                  child: AppButton(
                title: "Previous",
                width: 101,
                color: false,
              )),
              Expanded(
                  child:
                      AppButton(title: "Next Page", width: 197, color: true)),
            ],
          ),
          SizedBox(
            height: 3,
          ),
        ],
      ),
    );
  }
}
