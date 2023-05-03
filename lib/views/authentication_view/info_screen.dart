import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:prep50/models/exam_board.dart';
import 'package:prep50/models/subject.dart';
import 'package:prep50/utils/color.dart';
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
      ExamBoardsBottomSheet.showExamBoardBottomSheet(context).then((value){
        List<ExamBoard> examBoardsList = infoScreenViewModel.getExamBoardList;
        ExamBoard examBoard = examBoardsList.firstWhere((eb) => eb.name == value);
        infoScreenViewModel.setSelectedExamBoard=examBoard;
      });
    });
    
  }

  @override
  Widget build(BuildContext context) {
    InfoScreenViewModel infoScreenViewModel = Provider.of<InfoScreenViewModel>(context, listen: false);
    final ProgressDialog progressDialog = ProgressDialog(context:context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              // padding: EdgeInsets.symmetric(horizontal: 20),
              children: [
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
                FutureBuilder<List<Subject>>(
                  future:infoScreenViewModel.getAllSubjects(),
                  builder: (context,AsyncSnapshot<List<Subject>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasError) {
                        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                          appToast?.showToast(message: "${snapshot.error}");
                        });
                        log("${snapshot.error}");
                         return AppButton(
                           title: "Load Subjects",
                           width: 197,
                           color: true,
                           onTap: () => {
                             setState(() {})
                           },
                         );

                        //  return AppText.captionTextM("${snapshot.error}");
                      }

                      if(snapshot.hasData) {
                        List<Subject> networkSubjects = snapshot.data==null ? []:snapshot.data!;
                        List<Subjects> subjects = networkSubjects.map((subject) {
                          if (subject.name == "English Language") {
                            infoScreenViewModel.addSelectedSubject = subject.id;
                           return Subjects(title: subject.name,
                              id: subject.id.toString(),
                              selected: true,
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
                              AppButton(
                                title: "Continue",
                                width: 197,
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
                                      }catch(e){
                                        progressDialog.close();
                                        appToast?.showToast(message: e.toString().substring(11));
                                        print(e.toString().substring(11));
                                      }
                                  }else{
                                    appToast?.showToast(message: "Please select ${infoScreenViewModel.getSelectedExamboard?.subject_count} subjects from the list.");
                                  }
                                },
                              ),
                          ]
                        );
                      }
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


}
