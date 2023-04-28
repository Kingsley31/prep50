import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:prep50/utils/color.dart';
import 'package:prep50/utils/text.dart';
import 'package:prep50/views/cbt_view/quiz_view/components/countdown_box.dart';
import 'package:prep50/views/weekly_quiz/weekly_quiz_question_screen.dart';
import 'package:prep50/widgets/app_button.dart';
import 'package:prep50/widgets/question_widget.dart';
import 'package:provider/provider.dart';

import '../../view-models/join_quiz_screen_viewmodel.dart';
import '../../widgets/app_toast.dart';



class JoinQuizScreen extends StatefulWidget {

  @override
  State<JoinQuizScreen> createState() => _JoinQuizScreenState();
}

class _JoinQuizScreenState extends State<JoinQuizScreen> {
  AppToast? appToast;


  @override
  void initState() {
    super.initState();
    appToast = AppToast(context: context);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      JoinQuizScreenViewModel joinQuizScreenViewModel = Provider.of<JoinQuizScreenViewModel>(context,listen: false);
      joinQuizScreenViewModel.loadWeekLyQuiz();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          top: 30,
          left: 23,
          right: 23,
        ),
        child: ListView(
          children: [
            Center(child: AppText.heading2("Weekly Quiz")),
            Container(
              padding: EdgeInsets.all(20),
              // height: 83,
              width: double.infinity,
              color: kLighterGreyShadeColour,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Consumer<JoinQuizScreenViewModel>(
                    builder: (context,joinQuizScreenViewModel,child) {
                      if(joinQuizScreenViewModel.errorMessage.isEmpty && joinQuizScreenViewModel.weeklyQuizNotice.isEmpty && joinQuizScreenViewModel.isLoadingWeeklyQuiz ==false){
                        return AppText.heading6S(
                          "🎯 Giveaway 🎯:",
                          color: kPrimaryColor,
                        );
                      }
                      return Container();
                    }
                  ),
                  Consumer<JoinQuizScreenViewModel>(
                    builder: (context,joinQuizScreenViewModel,child) {
                      if(joinQuizScreenViewModel.errorMessage.isNotEmpty){
                        return _buildErrorWidget(joinQuizScreenViewModel);
                      }else if(joinQuizScreenViewModel.weeklyQuizNotice.isNotEmpty){
                        return _buildWeeklyQuizNotice(joinQuizScreenViewModel);
                      }else if(joinQuizScreenViewModel.isLoadingWeeklyQuiz){
                        return _buildLoadingWidget();
                      }
                      return AppText.heading6M(joinQuizScreenViewModel.weeklyQuiz.message,
                        centered: true,
                        color: kMidBlackColor,
                        multiText: true,
                      );
                    }
                  ),
                ],
              ),
            ),
            SizedBox(height: 25),
            Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                // borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                      image: AssetImage("assets/png/quiz_countdown.png"))),
            ),
            SizedBox(height: 30),
            Consumer<JoinQuizScreenViewModel>(
                builder: (context,joinQuizScreenViewModel,child){
                  if(joinQuizScreenViewModel.errorMessage.isEmpty && joinQuizScreenViewModel.weeklyQuizNotice.isEmpty && joinQuizScreenViewModel.isLoadingWeeklyQuiz ==false){
                    return Center(child: AppText.heading2S("Starting in"));
                  }
                  return Container();
                }
            ),
            SizedBox(height: 25),
            Consumer<JoinQuizScreenViewModel>(
                builder: (context,joinQuizScreenViewModel,child){
                  if(joinQuizScreenViewModel.errorMessage.isEmpty && joinQuizScreenViewModel.weeklyQuizNotice.isEmpty && joinQuizScreenViewModel.isLoadingWeeklyQuiz ==false){
                    return CountdownBox(countDown:joinQuizScreenViewModel.countDown ,);
                  }
                  return _buildLoadWeeklyQuizButton(joinQuizScreenViewModel);

                }
            ),
            SizedBox(height: 15),
            Consumer<JoinQuizScreenViewModel>(
              builder: (context,joinQuizScreenViewModel,child) {
                if(joinQuizScreenViewModel.showJoinQuizButton){
                  return Center(
                      child: AppButton(
                        title: "Join Quiz",
                        width: 196,
                        color: true,
                        onTap: () {
                          PersistentNavBarNavigator.pushNewScreen(
                            context,
                            screen: WeeklyQuizQuestionScreen(weeklyQuiz: joinQuizScreenViewModel.weeklyQuiz),
                            withNavBar: false, // OPTIONAL VALUE. True by default.
                          );

                        },
                      ));
                }
                return Container();
              }
            ),
            SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorWidget(JoinQuizScreenViewModel joinQuizScreenViewModel) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      appToast?.showToast(message: joinQuizScreenViewModel.errorMessage);
    });

    print(joinQuizScreenViewModel.errorMessage);
    return Container();
  }

  Widget _buildLoadingWidget() {
    return Center(
      child: SizedBox(
        height: 30,
        width: 30,
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _buildWeeklyQuizNotice(JoinQuizScreenViewModel joinQuizScreenViewModel) {
    return Container(
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: kPrimaryColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child:AppText.heading6M(joinQuizScreenViewModel.weeklyQuizNotice,
        centered: true,
        color: Colors.white,
        multiText: true,
      ) ,
    );
  }

  Widget _buildLoadWeeklyQuizButton(JoinQuizScreenViewModel joinQuizScreenViewModel) {
    return Center(
            child: AppButton(
              title: "Load Quiz",
              width: 197,
              color: true,
              onTap: () => {
                joinQuizScreenViewModel.loadWeekLyQuiz()
              },
            ),
        );
  }



}
