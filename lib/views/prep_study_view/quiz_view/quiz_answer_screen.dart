import 'package:flutter/material.dart';
import 'package:prep50/utils/color.dart';
import 'package:prep50/utils/text.dart';
import 'package:prep50/widgets/answer_card.dart';
import 'package:prep50/widgets/app_back_icon.dart';
import 'package:provider/provider.dart';

import '../../../view-models/quiz-question-screen-viewmodel.dart';

class QuizAnswerScreen extends StatelessWidget {
  // const QuizAnswerScreen({Key key, @required this.title}) : super(key: key);
  // final String title;
  @override
  Widget build(BuildContext context) {
    QuizQuestionScreenViewModel quizQuestionScreenViewModel = Provider.of<QuizQuestionScreenViewModel>(context,listen: false);
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
                      question:quizQuestionScreenViewModel.questions[index] ,
                    );
                  },
                  separatorBuilder:(context,index) => SizedBox(height: 10,),
                  itemCount: quizQuestionScreenViewModel.questions.length
            ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
