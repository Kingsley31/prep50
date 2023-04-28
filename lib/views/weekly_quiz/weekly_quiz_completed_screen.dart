


import 'package:flutter/material.dart';
import 'package:prep50/models/weekly_quiz.dart';
import 'package:prep50/views/weekly_quiz/weekly_quiz_result_screen.dart';
import 'package:provider/provider.dart';

import '../../constants/text_style.dart';
import '../../models/user.dart';
import '../../utils/color.dart';
import '../../utils/text.dart';
import '../../view-models/home_screen_view_model.dart';
import '../../widgets/app_button.dart';

class WeeklyQuizCompletedScreen extends StatefulWidget {
  final WeeklyQuiz weeklyQuiz;
  const WeeklyQuizCompletedScreen({Key? key,required this.weeklyQuiz}) : super(key: key);

  @override
  State<WeeklyQuizCompletedScreen> createState() => _WeeklyQuizCompletedScreenState();
}

class _WeeklyQuizCompletedScreenState extends State<WeeklyQuizCompletedScreen> {
  @override
  Widget build(BuildContext context) {
    HomeScreenViewModel homeScreenViewModel = Provider.of<HomeScreenViewModel>(context,listen: false);
    //QuizQuestionScreenViewModel quizQuestionScreenViewModel = Provider.of<QuizQuestionScreenViewModel>(context,listen: false);
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
                            text: "👋yoo!!! ${snapshot.data?.username}, you just completed the weekly quiz, \nand you stand the chance of winning ${widget.weeklyQuiz.prize} naira \nprize.",
                            style: textFieldRegularStyle,
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
                    MaterialPageRoute(builder: (context) => WeeklyQuizResultScreen())
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
