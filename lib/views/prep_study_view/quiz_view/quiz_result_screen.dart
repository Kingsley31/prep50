import 'package:flutter/material.dart';
import 'package:prep50/utils/color.dart';
import 'package:prep50/utils/text.dart';
import 'package:prep50/views/prep_study_view/quiz_view/quiz_answer_screen.dart';
import 'package:prep50/widgets/app_back_icon.dart';
import 'package:prep50/widgets/app_button.dart';
import 'package:provider/provider.dart';

import '../../../view-models/quiz-question-screen-viewmodel.dart';

class QUizResultScreen extends StatelessWidget {
  // const QuizResultScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    QuizQuestionScreenViewModel quizQuestionScreenViewModel = Provider.of<QuizQuestionScreenViewModel>(context,listen: false);
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
                    "You Answered ${quizQuestionScreenViewModel.totalCorrectAnswers} Questions Correctly",
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
                    "Total Number Of guesses is ${quizQuestionScreenViewModel.numberOfAttemptedQuestions}",
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
                    "Total topic score ${quizQuestionScreenViewModel.percentageScore}%",
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
                      image: AssetImage("assets/png/love_emoji_icon.png"))),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 48,
              width: 280,
              child: Column(
                children: [
                  AppText.textField(
                    "Keep Going, keep studying and we are so certain you would ace your nextr exams😇",
                    multiText: true,
                    centered: true,
                  ),
                ],
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
                      Navigator.pop(context);
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
                            MaterialPageRoute(builder: (context) => QuizAnswerScreen())
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
