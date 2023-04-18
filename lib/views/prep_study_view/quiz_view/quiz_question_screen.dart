import 'package:flutter/material.dart';
import 'package:prep50/models/objective.dart';
import 'package:prep50/utils/color.dart';
import 'package:prep50/utils/exceptions.dart';
import 'package:prep50/utils/text.dart';
import 'package:prep50/view-models/home_screen_view_model.dart';
import 'package:prep50/view-models/quiz-question-screen-viewmodel.dart';
import 'package:prep50/views/prep_study_view/quiz_view/quiz_complete_screen.dart';
import 'package:prep50/widgets/question_box.dart';
import 'package:provider/provider.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

import '../../../models/user.dart';
import '../../../widgets/app_back_icon.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/app_toast.dart';

class QuizQuestionScreen extends StatefulWidget {
  final Objective currentObjective;

  QuizQuestionScreen({Key? key,required this.currentObjective}):super(key:key);

  @override
  State<QuizQuestionScreen> createState() => _QuizQuestionScreenState();
}

class _QuizQuestionScreenState extends State<QuizQuestionScreen> {
  final GlobalKey<TooltipState> tooltipKey = GlobalKey<TooltipState>();
  String currentOption = "option_1";
  AppToast? appToast;

  @override
  void initState() {
    super.initState();
    appToast = AppToast(context: context);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      QuizQuestionScreenViewModel quizQuestionScreenViewModel = Provider.of<QuizQuestionScreenViewModel>(context,listen: false);
      quizQuestionScreenViewModel.loadQuestions(widget.currentObjective.id);
    });

  }
  @override
  Widget build(BuildContext context) {
    final ProgressDialog progressDialog = ProgressDialog(context:context);
    HomeScreenViewModel homeScreenViewModel = Provider.of<HomeScreenViewModel>(context,listen: false);
    return Scaffold(
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
                    AppBackIcon(),
                    SizedBox(
                      width: 26,
                    ),
                    Expanded(child: AppText.heading6S(widget.currentObjective.title),),
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
              Consumer<QuizQuestionScreenViewModel>(
                builder: (context,quizQuestionScreenViewModel,child) {
                  if(quizQuestionScreenViewModel.isLoadingQuestions==false && quizQuestionScreenViewModel.errorMessage.isEmpty){
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          AppText.heading6("Question ${quizQuestionScreenViewModel.currentQuestionIndex+1} of ${quizQuestionScreenViewModel.lastQuestionIndex+1}"),
                          Spacer(),
                        ],
                      ),
                    );
                  }
                  return Container();
                }
              ),
              SizedBox(height: 20),
              Expanded(
                child: Consumer<QuizQuestionScreenViewModel>(
                  builder: (context,quizQuestionScreenViewModel,child) {
                    return quizQuestionScreenViewModel.errorMessage.isNotEmpty?_buildErrorWidget(quizQuestionScreenViewModel):quizQuestionScreenViewModel.isLoadingQuestions?_buildLoadingWidget():_buildQuestionWidget(quizQuestionScreenViewModel);
                  }
                ),
              ),
             Container(
               color: Colors.white,
               padding: EdgeInsets.all(10),
               child: Consumer<QuizQuestionScreenViewModel>(
                 builder: (context,quizQuestionScreenViewModel,child) {
                   return quizQuestionScreenViewModel.errorMessage.isNotEmpty?Container():quizQuestionScreenViewModel.isLoadingQuestions?_buildLoadingWidget():_buildNextQuestionButton(quizQuestionScreenViewModel,progressDialog);
                 }
               ),
             )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNextQuestionButton(QuizQuestionScreenViewModel quizQuestionScreenViewModel,ProgressDialog progressDialog) {
    return Center(
      child: AppButton(
        title: quizQuestionScreenViewModel.completedQuiz?"View Result":"Next Question",
        width:200,
        color: true,
        onTap: ()async{
          if(quizQuestionScreenViewModel.startScoreCalculation){
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
              await quizQuestionScreenViewModel.submitQuizScore();
              progressDialog.close();
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => QuizCompleteScreen(currentObjective: widget.currentObjective,)));
            }on ValidationException catch(e){
              progressDialog.close();
              appToast?.showToast(message: e.message);
            }catch(e){
              progressDialog.close();
              appToast?.showToast(message: e.toString().substring(11));
            }
          }else{
            quizQuestionScreenViewModel.calculateScore(currentOption);
            quizQuestionScreenViewModel.gotoNextQuestions();
          }

        },
      ),
    );
  }

  Widget _buildErrorWidget(QuizQuestionScreenViewModel quizQuestionScreenViewModel) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      appToast?.showToast(message: quizQuestionScreenViewModel.errorMessage);
    });

    print(quizQuestionScreenViewModel.errorMessage);
    return Center(
      child: AppButton(
        title: "Load Questions",
        width: 197,
        color: true,
        onTap: () => {
          quizQuestionScreenViewModel.loadQuestions(widget.currentObjective.id)
        },
      ),
    );
  }

  Widget _buildQuestionWidget(QuizQuestionScreenViewModel quizQuestionScreenViewModel) {
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
                child: Center(
                  child: AppText.textFieldS(
                    quizQuestionScreenViewModel.currentQuestion.question,
                    centered: true,
                    multiText: true,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            QuestionBox(
              value: "option_1",
              text:quizQuestionScreenViewModel.currentQuestion.option1,
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
              text:quizQuestionScreenViewModel.currentQuestion.option2,
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
              text:quizQuestionScreenViewModel.currentQuestion.option3,
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
              text:quizQuestionScreenViewModel.currentQuestion.option4,
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
}
