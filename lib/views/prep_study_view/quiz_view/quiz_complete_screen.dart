import 'package:flutter/material.dart';
import 'package:prep50/utils/color.dart';
import 'package:prep50/utils/text.dart';
import 'package:prep50/view-models/quiz-question-screen-viewmodel.dart';
import 'package:prep50/views/prep_study_view/quiz_view/quiz_result_screen.dart';
import 'package:prep50/widgets/app_button.dart';
import 'package:provider/provider.dart';

import '../../../constants/text_style.dart';
import '../../../models/objective.dart';
import '../../../models/user.dart';
import '../../../view-models/home_screen_view_model.dart';

class QuizCompleteScreen extends StatefulWidget {
  final Objective currentObjective;

  QuizCompleteScreen({Key? key,required this.currentObjective}):super(key:key);

  @override
  State<QuizCompleteScreen> createState() => _QuizCompleteScreenState();
}

class _QuizCompleteScreenState extends State<QuizCompleteScreen> {
// const QuizCompleteScreen ({ Key? key }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    HomeScreenViewModel homeScreenViewModel = Provider.of<HomeScreenViewModel>(context,listen: false);
    QuizQuestionScreenViewModel quizQuestionScreenViewModel = Provider.of<QuizQuestionScreenViewModel>(context,listen: false);
    return Scaffold(
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(flex: 2,child: Container(),),
          Container(
            width: double.infinity,
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 144,
                ),
                Positioned(
                  child: Image.asset(
                    "assets/png/image1.png",
                    width: 150,
                    height: 100,
                    fit: BoxFit.fill,
                  ),
                  left: 2,
                  bottom: 0,
                  top: 0,
                ),
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      height: 140,
                      width: 140,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xfffff4f0),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 118.4,
                    width: 118.4,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xffFFE8E0),
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 88.8,
                    width: 88.8,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: AssetImage("assets/png/success.png"))),
                  ),
                ),

              ],
            ),
          ),
          SizedBox(height: 10,),
          AppText.heading6S(
            "Quiz Completed",
            color: kPrimaryColor,
            bold:true
          ),
          SizedBox(height: 8),
          FutureBuilder<User>(
              future: homeScreenViewModel.getLoggedInUser(),
              builder: (context,snapshot) {
                if(snapshot.hasData){
                  return Padding(
                    padding:const EdgeInsets.only(left: 20,right: 20),
                    child:RichText(
                      textAlign: TextAlign.center,
                      text:  TextSpan(
                        style: textFieldRegularStyle.copyWith(color: Colors.black),
                        children: [
                          TextSpan(
                              text: "👋yoo!!! ${snapshot.data?.username}, you just completed the quick quiz. From your answers so far your understanding over the topic ",
                              style: textFieldRegularStyle,
                          ),
                          TextSpan(
                            text: "\"${widget.currentObjective.title}\"",
                            style: textFieldRegularStyle.copyWith(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: " was really ",
                            style: textFieldRegularStyle,
                          ),
                          TextSpan(
                            text: _getScoreText(quizQuestionScreenViewModel.percentageScore),
                            style: textFieldRegularStyle.copyWith(color: kPrimaryColor),
                          ),
                          TextSpan(
                            text: ",\nKeep it going. We love to see it😍",
                            style: textFieldRegularStyle,
                          ),
                        ],
                      ),
                    ),
                  );
                }

                return SizedBox(
                  height: 15.0,
                  width: 15.0,
                  child: CircularProgressIndicator(
                    color: kPrimaryColor,
                  ),
                );

              }
          ),
          Expanded(
            flex: 3,
              child: Stack(
                children: [
                  Positioned(
                      child: Image.asset("assets/png/image2.png"),
                      right: 0,
                      bottom: 0,
                  ),
                ],
              ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10,right: 10,bottom: 10),
            child: AppButton(
              title: "View Result",
              width: 343,
              color: true,
              onTap: (){
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => QUizResultScreen())
                );
              },
            ),
          ),
        ],
      ),
    );
  }

 String _getScoreText(int percentageScore) {
    if(percentageScore<=30){
      return "poor";
    }else if(percentageScore<=50){
      return "good";
    }else if(percentageScore<=70){
      return "great";
    }

    return "outstanding";
 }
}
