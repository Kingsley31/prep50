import 'package:flutter/material.dart';
import 'package:prep50/utils/text.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
// import 'package:prep50/utils/text.dart';

class QuizScreenTimer extends StatelessWidget {
  // const QuizView2({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff000000),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 45),
            AppText.heading5S(
              "Weekly Quiz",
              color: Color(0xffffffff),
            ),
            SizedBox(
              height: 24,
            ),
            Container(
              height: 44,
              width: 228,
              decoration: BoxDecoration(
                  border: Border.all(
                      color: Color(0xffADADAD).withOpacity(0.5),
                      style: BorderStyle.solid),
                  borderRadius: BorderRadius.circular(8)),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: AppText.textFieldS(
                    "Subjects includes: English Language, "
                    "Government and Financial Accounting",
                    color: Color(0xffffffff),
                    multiText: true,
                  ),
                ),
              ),
            ),
            SizedBox(height: 104),
            AppText.heading2S(
              "Starts In",
              color: Color(0xffffffff),
            ),
            SizedBox(height: 10),
            Stack(
              children: [
                Container(
                  height: 388,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      // borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          image: AssetImage("assets/png/quiz_frame.png"))),
                ),
                Positioned(
                  top: 122,
                  left: 162,
                  child: Container(
                    height: 117,
                    width: 51,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/png/5.png")),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
