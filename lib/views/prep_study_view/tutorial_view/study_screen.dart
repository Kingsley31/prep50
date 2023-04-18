import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:prep50/models/objective.dart';
import 'package:prep50/utils/color.dart';
import 'package:prep50/utils/text.dart';
import 'package:prep50/view-models/study-screen-viewmodel.dart';
import 'package:prep50/views/prep_study_view/quiz_view/quiz_question_screen.dart';
import 'package:prep50/views/prep_study_view/tutorial_view/components/take-quiz-bottom-sheet-dialog.dart';
import 'package:prep50/widgets/app_button.dart';
import 'package:provider/provider.dart';

import '../../../models/topic.dart';
import '../../../widgets/app_back_icon.dart';

class StudyScreen extends StatefulWidget {
  final Objective currentObjective;
  final Topic currentTopic;
  StudyScreen({required this.currentObjective,required this.currentTopic});
  @override
  State<StudyScreen> createState() => _StudyScreenState();
}

class _StudyScreenState extends State<StudyScreen> {
  late String selectedObjective;



  @override
  void initState() {
    super.initState();
    selectedObjective = widget.currentObjective.title;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      StudyScreenViewModel studyScreenViewModel = Provider.of<StudyScreenViewModel>(context,listen: false);
      studyScreenViewModel.currentTopic=widget.currentTopic;
      studyScreenViewModel.currentObjective = widget.currentObjective;
    });
  }

  @override
  Widget build(BuildContext context) {
    Set<String> objectiveStringList = widget.currentTopic.objectives.map((objective) => objective.title).toSet();
    return Scaffold(
      backgroundColor: Color(0xffffffff),
      body: Consumer<StudyScreenViewModel>(
        builder: (context,studyScreenViewModel,child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 92,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(13.5),
                      child: Row(
                        children: [
                          AppBackIcon(),
                          SizedBox(
                            width: 17,
                          ),
                          Expanded(
                            flex: 2,
                            child: AppText.heading5M(widget.currentTopic.title),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 2),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  height: 40,
                  width: 300,
                  decoration: BoxDecoration(
                      color: Color(0xfffff4f0),
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButton(
                      isExpanded: true,
                        icon: Icon(Icons.arrow_drop_down,color: kPrimaryColor,),
                        value: selectedObjective.trim(),
                        items: objectiveStringList.map<DropdownMenuItem<String>>((String objective) {
                          return DropdownMenuItem<String>(
                            value: objective,
                            child: AppText.heading6(objective,multiText: true,color: kPrimaryColor,),
                          );
                        }).toList(),
                        onChanged: (value){
                          setState((){
                            selectedObjective = value.toString();
                            Objective selectedObj = studyScreenViewModel.getSelectObjective(selectedObjective);
                            studyScreenViewModel.currentObjective=selectedObj;
                          });
                        }
                    ),
                  ),
                ),
              ),
              SizedBox(height: 5),
              Expanded(
                flex: 2,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: SelectableHtml(data: studyScreenViewModel.currentLesson.content.trim(),shrinkWrap: true,),
                    ),
                  ),
              ),

              Container(
                padding: EdgeInsets.all(10),
                child: studyScreenViewModel.showNextAndPrevButton ? _buildNextAndButtons(studyScreenViewModel): _buildOnlyNextButton(studyScreenViewModel),
              )
            ],
          );
        }
      ),
    );
  }

  Widget _buildNextAndButtons(StudyScreenViewModel studyScreenViewModel) {
    return Row(
      children: [
        AppButton(
          title: "Previous",
          width: 100,
          color: false,
          onTap: (){
            studyScreenViewModel.gotoPrevLesson();
          },
        ),
        Spacer(flex: 1,),
        Expanded(
          flex: 2,
          child: AppButton(
              title: studyScreenViewModel.completedLessons ? "Take a quick quiz":"Next Page",
              width:studyScreenViewModel.completedLessons? 250: 200,
              color: true,
              onTap: (){
                _gotoNextLesson(studyScreenViewModel);
              },
          ),
        ),
      ],
    );

  }

  Widget _buildOnlyNextButton(StudyScreenViewModel studyScreenViewModel) {
    print("Completed Lessons: ${studyScreenViewModel.completedLessons}");
    return Center(
      child: AppButton(
          title: studyScreenViewModel.completedLessons ? "Take a quick quiz":"Next Page",
          width:studyScreenViewModel.completedLessons? 250: 200,
          color: true,
          onTap: (){
            _gotoNextLesson(studyScreenViewModel);
          },
      ),
    );
  }

  void _gotoNextLesson(StudyScreenViewModel studyScreenViewModel)async {
    final bool lessonsNotCompleted = studyScreenViewModel.gotoNextLesson();
    if(lessonsNotCompleted == false){
      await TakeQuizBottomSheetDialog.showTakeQuizBottomSheetDialog(context);
      Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) => QuizQuestionScreen(currentObjective: studyScreenViewModel.currentObjective,)));
    }
  }
}
