

import 'package:flutter/material.dart';
import 'package:prep50/view-models/weekly_quiz_question_screen_viewmodel.dart';
import 'package:prep50/widgets/app_back_icon.dart';
import 'package:provider/provider.dart';

import '../../utils/text.dart';
import '../../widgets/answer_card.dart';

class WeeklyQuizAnswerScreen extends StatelessWidget {
  const WeeklyQuizAnswerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WeeklyQuizQuestionScreenViewModel weeklyQuizQuestionScreenViewModel = Provider.of<WeeklyQuizQuestionScreenViewModel>(context,listen: false);
    return Scaffold(
      backgroundColor: Color(0xffE5E5E5),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              color: Color(0xffffffff),
              child: Padding(
                padding: const EdgeInsets.all(13.5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AppBackIcon(),
                    SizedBox(
                      width: 24,
                    ),
                    AppText.heading6S("Quiz Answers"),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10,),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: ListView.separated(
                    itemBuilder: (context,index){
                      return AnswerCard(
                        index: index+1,
                        question:weeklyQuizQuestionScreenViewModel.questions[index] ,
                      );
                    },
                    separatorBuilder:(context,index) => SizedBox(height: 10,),
                    itemCount: weeklyQuizQuestionScreenViewModel.questions.length
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
