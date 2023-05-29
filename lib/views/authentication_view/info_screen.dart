import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:prep50/models/exam_board.dart';
import 'package:prep50/models/subject.dart';
import 'package:prep50/utils/color.dart';
import 'package:prep50/utils/exceptions.dart';
import 'package:prep50/utils/text.dart';
import 'package:prep50/view-models/info-screen-view-model.dart';
import 'package:prep50/views/authentication_view/welcome_screen.dart';
import 'package:prep50/widgets/app_button.dart';
import 'package:prep50/widgets/examboard_bottom_sheet.dart';
import 'package:prep50/widgets/info_subject.dart';
import 'package:provider/provider.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

import '../../widgets/app_toast.dart';

class InfoScreen extends StatefulWidget {
  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  AppToast? appToast;
  final GlobalKey<TooltipState> tooltipkey = GlobalKey<TooltipState>();


  @override
  void initState() {
    super.initState();
     appToast = AppToast(context: context);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      InfoScreenViewModel infoScreenViewModel = Provider.of<InfoScreenViewModel>(context, listen: false);
      infoScreenViewModel.loadAllSubjects();
      ExamBoardsBottomSheet.showExamBoardBottomSheet(context).then((value){
        // List<ExamBoard> examBoardsList = infoScreenViewModel.getExamBoardList;
        // ExamBoard examBoard = examBoardsList.firstWhere((eb) => eb.name == value);
        //print(value.name);
        infoScreenViewModel.setSelectedExamBoard=value;
      });
    });
    
  }

  @override
  Widget build(BuildContext context) {
    InfoScreenViewModel infoScreenViewModel = Provider.of<InfoScreenViewModel>(context, listen: false);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              // padding: EdgeInsets.symmetric(horizontal: 20),
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10,),
                AppButton(
                    title: "Reselect ExamBoard",
                    color: true,
                  width: 200,
                  onTap: ()async{
                    ExamBoardsBottomSheet.showExamBoardBottomSheet(context).then((value){
                      // List<ExamBoard> examBoardsList = infoScreenViewModel.getExamBoardList;
                      // ExamBoard examBoard = examBoardsList.firstWhere((eb) => eb.name == value);
                      print(value.name);
                      infoScreenViewModel.setSelectedExamBoard=value;
                    });
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Consumer<InfoScreenViewModel>(
                    builder: (context,infoScreenVM,child) {
                      return Row(
                        children: [
                          Tooltip(
                            message: "we recommend that you select ${infoScreenVM.getSelectedExamboard?.subject_count} subjects only",
                            child: IconButton(
                              icon: Icon(Icons.info),
                              onPressed: (){
                                tooltipkey.currentState?.ensureTooltipVisible();
                              },
                            ),
                            showDuration: Duration(seconds: 10),
                            key: tooltipkey,
                            padding: EdgeInsets.symmetric(vertical: 15,horizontal: 15),
                            margin: EdgeInsets.symmetric(horizontal: 20.0),
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            textStyle: TextStyle(color: Colors.white),
                            triggerMode: TooltipTriggerMode.manual,
                          ),
                          SizedBox(width: 10,),
                          Expanded(
                            child: AppText.heading6( "Kindly select your ${infoScreenVM.getSelectedExamboard?.name ?? ""} subject combination",multiText: true,),
                            ),
                        ],
                      );
                    }
                ),
                SizedBox(
                  height: 40,
                ),
                Consumer<InfoScreenViewModel>(
                  builder: (context,infoScreenViewModel,child) {
                      if (infoScreenViewModel.errorMessage.isNotEmpty) {
                        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                          appToast?.showToast(message: "${infoScreenViewModel.errorMessage}");
                        });
                        log("${infoScreenViewModel.errorMessage}");
                         return AppButton(
                           title: "Load Subjects",
                           width: 197,
                           color: true,
                           onTap: () => {
                             infoScreenViewModel.loadAllSubjects()
                           },
                         );

                        //  return AppText.captionTextM("${snapshot.error}");
                      }

                      if(infoScreenViewModel.isLoadingSubjects==false && infoScreenViewModel.errorMessage.isEmpty) {
                        List<Subject> networkSubjects = infoScreenViewModel.subjectsList;
                        List<Subjects> subjects = networkSubjects.map((subject) {
                          if (subject.name == "English Language") {
                            infoScreenViewModel.addSelectedSubjectWithoutNotification = subject.id;
                           return Subjects(title: subject.name,
                              id: subject.id.toString(),
                              selected: infoScreenViewModel.getSelectedSubjectIds.contains(subject.id),
                              onSelected: (String subjectId,bool selected){
                                if(selected){
                                  infoScreenViewModel.addSelectedSubject = int.parse(subjectId);
                                }else{
                                  infoScreenViewModel.removeSelectedSubject = int.parse(subjectId);
                                }
                              },
                           );
                          } else {
                            return Subjects(title: subject.name,
                              id: subject.id.toString(),
                              selected: infoScreenViewModel.getSelectedSubjectIds.contains(subject.id),
                              onSelected: (String subjectId,bool selected){
                                if(selected){
                                  infoScreenViewModel.addSelectedSubject = int.parse(subjectId);
                                }else{
                                  infoScreenViewModel.removeSelectedSubject = int.parse(subjectId);
                                }
                              },);
                          }
                        }).toList();

                        return Column(
                          children: [
                              Wrap(
                                direction: Axis.horizontal,
                                // mainAxisAlignment: MainAxisAlignment.center,
                                children:subjects,
                              ),
                              SizedBox(
                                height: 80,
                              ),
                              infoScreenViewModel.currentExamBoardIndex==infoScreenViewModel.totalNumOfExamBoards?
                              _showContinueWithPrevBtnorOnlyContinueBtn(infoScreenViewModel):_showNextButton(infoScreenViewModel),
                            SizedBox(height: 20,)
                          ]
                        );
                      }
                    return CircularProgressIndicator(color: kPrimaryColor,);
                  }
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

 Widget _showContinueWithPrevBtnorOnlyContinueBtn(InfoScreenViewModel infoScreenViewModel) {
    if(infoScreenViewModel.examBoardIsBoth==false){
      return _buildContinueBtn(width:197,infoScreenViewModel:infoScreenViewModel);
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AppButton(
          title: "Previous",
          width: 120,
          color: true,
          onTap: () {
            infoScreenViewModel.previous();
          },
        ),
        Spacer(),
        _buildContinueBtn(width:120,infoScreenViewModel:infoScreenViewModel)
      ],
    );
 }

  Widget _buildContinueBtn({required double width,required InfoScreenViewModel infoScreenViewModel}) {
    final ProgressDialog progressDialog = ProgressDialog(context:context);
    return AppButton(
      title: "Continue",
      width: width,
      color: true,
      onTap: () async {
        if(infoScreenViewModel.getSelectedSubjectIds.length==infoScreenViewModel.getSelectedExamboard?.subject_count){
          progressDialog.show(
            max: 100,
            msg: 'Updating subjects...',
            msgColor: Colors.black,
            progressValueColor: kPrimaryColor,
            borderRadius: 10.0,
            backgroundColor: Colors.white,
            barrierDismissible: false,
            elevation: 10.0,
          );
          try{
            await infoScreenViewModel.updateUserSubjects();
            progressDialog.close();
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => WelcomeScreen()));
          }on LoginException catch(e){
            progressDialog.close();
            appToast?.showToast(message:e.message);
          }catch(e){
            progressDialog.close();
            appToast?.showToast(message: e.toString().substring(11));
            print(e.toString().substring(11));
          }
        }else{
          appToast = AppToast(context: context);
          appToast?.showToast(message: "Please select ${infoScreenViewModel.getSelectedExamboard?.subject_count} subjects from the list.");
        }
      },
    );
  }

 Widget _showNextButton(InfoScreenViewModel infoScreenViewModel) {
    return AppButton(
      title: "Next",
      width: 197,
      color: true,
      onTap: () {
      if(infoScreenViewModel.getSelectedSubjectIds.length==infoScreenViewModel.getSelectedExamboard?.subject_count){
        infoScreenViewModel.next();
      }else{
        appToast = AppToast(context: context);
        appToast?.showToast(message: "Please select ${infoScreenViewModel.getSelectedExamboard?.subject_count} subjects from the list.");
      }

      },
    );
 }


}
