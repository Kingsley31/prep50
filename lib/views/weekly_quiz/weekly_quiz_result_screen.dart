


import 'package:flutter/material.dart';
import 'package:prep50/views/weekly_quiz/weekly_quiz_leader_board_screen.dart';
import 'package:prep50/views/weekly_quiz/weekly_quiz_answer_screen.dart';
import 'package:provider/provider.dart';

import '../../constants/text_style.dart';
import '../../utils/color.dart';
import '../../utils/text.dart';
import '../../view-models/weekly_quiz_question_screen_viewmodel.dart';
import '../../widgets/app_back_icon.dart';
import '../../widgets/app_button.dart';
import '../home_view/home_view.dart';

class WeeklyQuizResultScreen extends StatelessWidget {
  const WeeklyQuizResultScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WeeklyQuizQuestionScreenViewModel weeklyQuizQuestionScreenViewModel = Provider.of<WeeklyQuizQuestionScreenViewModel>(context,listen: false);
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10,right: 10,top: 15),
              child: Row(
                children: [
                  AppBackIcon(),
                  Expanded(
                    child: Center(
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical:10,horizontal: 30 ),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        child: AppText.heading6("Your Quiz Result"),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Container(
                    height: 23,
                    width: 23,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: AssetImage("assets/png/hot_emoji.png"))),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  AppText.captionText(
                    "You Answered ${weeklyQuizQuestionScreenViewModel.totalCorrectAnswers} Questions Correctly",
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Container(
                    height: 23,
                    width: 23,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: AssetImage("assets/png/confused_emoji.png"))),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  AppText.captionText(
                    "Total Number Of guesses is ${weeklyQuizQuestionScreenViewModel.numberOfAttemptedQuestions}",
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Container(
                    height: 23,
                    width: 23,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image:
                            AssetImage("assets/png/celebration_emoji.png"))),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  AppText.captionTextS(
                    "Total score= ${weeklyQuizQuestionScreenViewModel.score}%",
                    color: kPrimaryColor,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 35,
            ),
            Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: AssetImage("assets/png/medal.png"))),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: 280,
              child: Column(
                children: [
                  AppText.textField(
                    "You will be contacted by admin for your prize if you are ranked no.1 in the leader board after all participants are done with the quiz.",
                    multiText: true,
                    centered: true,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            InkWell(
              onTap: (){
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => WeeklyQuizLeaderBoardScreen())
                );
              },
              child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: "View leaderboard",
                    style: heading6MediumStyle.copyWith(color: kPrimaryColor,decoration: TextDecoration.underline),
                  ),
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  AppButton(
                    title: "Go Home",
                    width: 110,
                    color: false,
                    onTap: (){
                      Navigator.popUntil(context,ModalRoute.withName(HomeView.routeName));
                    },
                  ),
                  Spacer(),
                  AppButton(
                    title: "Show Answers",
                    width: 187,
                    color: true,
                    onTap: (){
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => WeeklyQuizAnswerScreen())
                      );
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
