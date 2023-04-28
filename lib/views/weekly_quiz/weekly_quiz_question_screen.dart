import 'package:flutter/material.dart';
import 'package:prep50/constants/string_data.dart';
import 'package:prep50/models/weekly_quiz.dart';
import 'package:prep50/utils/color.dart';
import 'package:prep50/utils/exceptions.dart';
import 'package:prep50/utils/text.dart';
import 'package:prep50/view-models/home_screen_view_model.dart';
import 'package:prep50/views/weekly_quiz/weekly_quiz_completed_screen.dart';
import 'package:prep50/widgets/question_box.dart';
import 'package:provider/provider.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

import '../../../models/user.dart';
import '../../../widgets/app_back_icon.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/app_toast.dart';
import '../../view-models/weekly_quiz_question_screen_viewmodel.dart';
import 'components/close_question_screen_dialog.dart';

class WeeklyQuizQuestionScreen extends StatefulWidget {
  final WeeklyQuiz weeklyQuiz;

  WeeklyQuizQuestionScreen({Key? key,required this.weeklyQuiz}):super(key:key);

  @override
  State<WeeklyQuizQuestionScreen> createState() => _WeeklyQuizQuestionScreenState();
}

class _WeeklyQuizQuestionScreenState extends State<WeeklyQuizQuestionScreen> {
  final GlobalKey<TooltipState> tooltipKey = GlobalKey<TooltipState>();
  String currentOption = "option_1";
  AppToast? appToast;
  late WeeklyQuizQuestionScreenViewModel weeklyQuizQuestionScreenViewModel;

  @override
  void initState() {
    super.initState();
    appToast = AppToast(context: context);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      weeklyQuizQuestionScreenViewModel = Provider.of<WeeklyQuizQuestionScreenViewModel>(context,listen: false);
      weeklyQuizQuestionScreenViewModel.loadQuestions(widget.weeklyQuiz);
      _submitQuizOnTimeOut(weeklyQuizQuestionScreenViewModel);
    });

  }
  @override
  Widget build(BuildContext context) {
    final ProgressDialog progressDialog = ProgressDialog(context:context);
    HomeScreenViewModel homeScreenViewModel = Provider.of<HomeScreenViewModel>(context,listen: false);
    return WillPopScope(
      onWillPop: ()async{
        return await CloseQuestionScreenDialog.show(context)??false;
      },
      child: Scaffold(
        backgroundColor: Color(0xffffffff),
        body: SafeArea(
          child: Container(
            color: kpGrey,
            child: Column(
              children: [
                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.only(left: 20,right: 20,top: 20),
                  child: Row(
                    children: [
                      AppBackIcon(
                        onTap: ()async{
                          final bool close = await CloseQuestionScreenDialog.show(context)??false;
                          if(close){
                            Navigator.pop(context);
                          }
                        },
                      ),
                      SizedBox(
                        width: 26,
                      ),
                      Expanded(child: AppText.heading6S("Weekly Quiz"),),
                      Spacer(),
                      FutureBuilder<User>(
                          future: homeScreenViewModel.getLoggedInUser(),
                          builder: (context,snapshot) {
                            if(snapshot.hasData){
                              return Tooltip(
                                message: "👋Hello ${snapshot.data?.username}, you are desired to attempt all questions, this would help you and us trace your level of understanding over this topic.",
                                child: IconButton(
                                  icon: Icon(Icons.info_outline_rounded),
                                  onPressed: (){
                                    tooltipKey.currentState?.ensureTooltipVisible();
                                  },
                                ),
                                showDuration: Duration(seconds: 10),
                                key: tooltipKey,
                                padding: EdgeInsets.symmetric(vertical: 15,horizontal: 15),
                                margin: EdgeInsets.symmetric(horizontal: 20.0),
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                textStyle: TextStyle(color: Colors.white),
                                triggerMode: TooltipTriggerMode.manual,
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
                    ],
                  ),
                ),
                SizedBox(height: 8),
                Consumer<WeeklyQuizQuestionScreenViewModel>(
                    builder: (context,weeklyQuizQuestionScreenViewModel,child) {
                      if(weeklyQuizQuestionScreenViewModel.isLoadingQuestions==false && weeklyQuizQuestionScreenViewModel.errorMessage.isEmpty){
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            children: [
                              AppText.heading6("Question ${weeklyQuizQuestionScreenViewModel.currentQuestionIndex+1} of ${weeklyQuizQuestionScreenViewModel.lastQuestionIndex+1}"),
                              Spacer(),
                              Icon(Icons.timer_outlined,color: Colors.black,),
                              SizedBox(width: 5,),
                              AppText.captionText("${weeklyQuizQuestionScreenViewModel.quizCountDownTime.inMinutes>=10?weeklyQuizQuestionScreenViewModel.quizCountDownTime.inMinutes:"0${weeklyQuizQuestionScreenViewModel.quizCountDownTime.inMinutes}"} : ${weeklyQuizQuestionScreenViewModel.quizCountDownTime.inSeconds>=10?weeklyQuizQuestionScreenViewModel.quizCountDownTime.inSeconds:"0${weeklyQuizQuestionScreenViewModel.quizCountDownTime.inSeconds}"}")
                            ],
                          ),
                        );
                      }
                      return Container();
                    }
                ),
                SizedBox(height: 20),
                Expanded(
                  child: Consumer<WeeklyQuizQuestionScreenViewModel>(
                      builder: (context,weeklyQuizQuestionScreenViewModel,child) {
                        return weeklyQuizQuestionScreenViewModel.errorMessage.isNotEmpty?_buildErrorWidget(weeklyQuizQuestionScreenViewModel):weeklyQuizQuestionScreenViewModel.isLoadingQuestions?_buildLoadingWidget():_buildQuestionWidget(weeklyQuizQuestionScreenViewModel);
                      }
                  ),
                ),
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(10),
                  child: Consumer<WeeklyQuizQuestionScreenViewModel>(
                      builder: (context,weeklyQuizQuestionScreenViewModel,child) {
                        return weeklyQuizQuestionScreenViewModel.errorMessage.isNotEmpty?Container():weeklyQuizQuestionScreenViewModel.isLoadingQuestions?_buildLoadingWidget():_buildNextQuestionButton(weeklyQuizQuestionScreenViewModel,progressDialog);
                      }
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNextQuestionButton(WeeklyQuizQuestionScreenViewModel weeklyQuizQuestionScreenViewModel,ProgressDialog progressDialog) {
    return Center(
      child: AppButton(
        title: weeklyQuizQuestionScreenViewModel.completedQuiz?"View Result":"Next Question",
        width:200,
        color: true,
        onTap: ()async{
          if(weeklyQuizQuestionScreenViewModel.startScoreCalculation){
            progressDialog.show(
              max: 100,
              msg: 'Submitting Score...',
              msgColor: Colors.black,
              progressValueColor: kPrimaryColor,
              borderRadius: 10.0,
              backgroundColor: Colors.white,
              barrierDismissible: false,
              elevation: 10.0,
            );
            try{
              await weeklyQuizQuestionScreenViewModel.submitQuizScore();
              progressDialog.close();
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => WeeklyQuizCompletedScreen(weeklyQuiz: widget.weeklyQuiz,)));
            }on ValidationException catch(e){
              progressDialog.close();
              appToast?.showToast(message: e.message);
            }catch(e){
              progressDialog.close();
              appToast?.showToast(message: e.toString().substring(11));
            }
          }else{
            weeklyQuizQuestionScreenViewModel.trackCurrentQuestionAnswer(currentOption);
            weeklyQuizQuestionScreenViewModel.gotoNextQuestions();
          }

        },
      ),
    );
  }

  Widget _buildErrorWidget(WeeklyQuizQuestionScreenViewModel weeklyQuizQuestionScreenViewModel) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      appToast?.showToast(message: weeklyQuizQuestionScreenViewModel.errorMessage);
    });

    print(weeklyQuizQuestionScreenViewModel.errorMessage);
    return Center(
      child: AppButton(
        title: "Load Questions",
        width: 197,
        color: true,
        onTap: () => {
          weeklyQuizQuestionScreenViewModel.loadQuestions(widget.weeklyQuiz)
        },
      ),
    );
  }

  Widget _buildQuestionWidget(WeeklyQuizQuestionScreenViewModel weeklyQuizQuestionScreenViewModel) {
    print(weeklyQuizQuestionScreenViewModel.currentQuestion.questionImage);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    weeklyQuizQuestionScreenViewModel.currentQuestion.questionDetails.isNotEmpty?Center(
                      child: AppText.textFieldS(
                        "${weeklyQuizQuestionScreenViewModel.currentQuestion.questionDetails} \n\n",
                        centered: true,
                        multiText: true,
                        color: Colors.white,
                      ),
                    ):Container(),
                    Center(
                      child: AppText.textFieldS(
                        weeklyQuizQuestionScreenViewModel.currentQuestion.question,
                        centered: true,
                        multiText: true,
                        color: Colors.white,
                      ),
                    ),
                    weeklyQuizQuestionScreenViewModel.currentQuestion.questionImage.isNotEmpty?SizedBox(height: 20,):Container(),
                    weeklyQuizQuestionScreenViewModel.currentQuestion.questionImage.isNotEmpty?Center(
                      child: Image.network(
                        "$BASE_URL/${weeklyQuizQuestionScreenViewModel.currentQuestion.questionImage}",
                        height: 200,
                        fit: BoxFit.fill,
                        errorBuilder: (context,object,stackTrace){
                          return Container(
                            padding: EdgeInsets.all(20),
                            color: Colors.white,
                            child: Center(child: AppText.textFieldS("Error loading Image",centered: true,),),
                          );
                        },
                      ),
                    ):Container(),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            QuestionBox(
              value: "option_1",
              text:weeklyQuizQuestionScreenViewModel.currentQuestion.option1,
              groupValue: currentOption,
              onChanged: (String? value){
                setState(() {
                  currentOption = value!;
                });
              },
            ),
            SizedBox(height: 10),
            QuestionBox(
              value: "option_2",
              text:weeklyQuizQuestionScreenViewModel.currentQuestion.option2,
              groupValue: currentOption,
              onChanged: (String? value){
                setState(() {
                  currentOption = value!;
                });
              },
            ),
            SizedBox(height: 10),
            QuestionBox(
              value: "option_3",
              text:weeklyQuizQuestionScreenViewModel.currentQuestion.option3,
              groupValue: currentOption,
              onChanged: (String? value){
                setState(() {
                  currentOption = value!;
                });
              },
            ),
            SizedBox(height: 10),
            QuestionBox(
              value: "option_4",
              text:weeklyQuizQuestionScreenViewModel.currentQuestion.option4,
              groupValue: currentOption,
              onChanged: (String? value){
                setState(() {
                  currentOption = value!;
                });
              },
            ),
            SizedBox(height: 30,),
          ],
        ),
      ),
    );
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

  void _submitQuizOnTimeOut(WeeklyQuizQuestionScreenViewModel weeklyQuizQuestionScreenViewModel) {
    weeklyQuizQuestionScreenViewModel.addListener(() async{
      final ProgressDialog progressDialog = ProgressDialog(context:context);
      if(weeklyQuizQuestionScreenViewModel.quizIsTimedOut){
        progressDialog.show(
          max: 100,
          msg: 'Submitting Score...',
          msgColor: Colors.black,
          progressValueColor: kPrimaryColor,
          borderRadius: 10.0,
          backgroundColor: Colors.white,
          barrierDismissible: false,
          elevation: 10.0,
        );
        try{
          await weeklyQuizQuestionScreenViewModel.submitQuizScore();
          progressDialog.close();
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => WeeklyQuizCompletedScreen(weeklyQuiz: widget.weeklyQuiz,)));
        }on ValidationException catch(e){
          progressDialog.close();
          appToast?.showToast(message: e.message);
        }catch(e){
          progressDialog.close();
          appToast?.showToast(message: e.toString().substring(11));
        }
      }
    });
  }

  @override
  void dispose() {
    weeklyQuizQuestionScreenViewModel.stopTimer();
    super.dispose();

  }
}
