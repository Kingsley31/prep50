




import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:prep50/utils/text.dart';
import 'package:prep50/widgets/app_back_icon.dart';
import 'package:provider/provider.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';

import '../utils/color.dart';
import '../view-models/subject_reselection_screen_viewmodel.dart';
import '../widgets/app_button.dart';
import '../widgets/app_toast.dart';
import '../widgets/info_subject.dart';

class SubjectsReselectScreen extends StatefulWidget {
  const SubjectsReselectScreen({Key? key}) : super(key: key);

  @override
  State<SubjectsReselectScreen> createState() => _SubjectsReselectScreenState();
}

class _SubjectsReselectScreenState extends State<SubjectsReselectScreen> {
  AppToast? appToast;
  final GlobalKey<TooltipState> tooltipkey = GlobalKey<TooltipState>();

  @override
  void initState() {
    super.initState();
    appToast = AppToast(context: context);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      SubjectReselectionScreenViewModel subjectReselectionScreenViewModel = Provider.of<SubjectReselectionScreenViewModel>(context, listen: false);
      subjectReselectionScreenViewModel.loadSubject();
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              color: Color(0xffffffff),
              child: SafeArea(
                bottom: false,
                child: Padding(
                  padding: const EdgeInsets.all(13.5),
                  child: Row(
                    children: [
                      AppBackIcon(),
                      SizedBox(
                        width: 24,
                      ),
                      AppText.heading6S("Subject Reselection"),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    // padding: EdgeInsets.symmetric(horizontal: 20),
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Consumer<SubjectReselectionScreenViewModel>(
                          builder: (context,subjectReselectionScreenViewModel,child) {
                            if(subjectReselectionScreenViewModel.isLoadingSubjects==false && subjectReselectionScreenViewModel.errorMessage.isEmpty){
                              return _buildSubjectSelectionNoticeWidget(subjectReselectionScreenViewModel);
                            }
                            return Container();
                          }
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Consumer<SubjectReselectionScreenViewModel>(
                          builder: (context,subjectReselectionScreenViewModel,child) {
                           return subjectReselectionScreenViewModel.errorMessage.isNotEmpty?
                                _buildErrorWidget(subjectReselectionScreenViewModel):
                                subjectReselectionScreenViewModel.isLoadingSubjects?
                                    _buildLoadingWidget():_buildSubjectListWidget(subjectReselectionScreenViewModel);

                          }
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubjectSelectionNoticeWidget(SubjectReselectionScreenViewModel subjectReselectionScreenViewModel) {
    return Row(
      children: [
        Tooltip(
          message: "we recommend that you select ${subjectReselectionScreenViewModel.selectedExamBoard.subject_count} subjects only",
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
          child: AppText.heading6( "Kindly select your ${subjectReselectionScreenViewModel.selectedExamBoard.name} subject combination",multiText: true,),
        ),
      ],
    );
  }

 Widget _buildErrorWidget(SubjectReselectionScreenViewModel subjectReselectionScreenViewModel) {
   WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
     appToast?.showToast(message: "${subjectReselectionScreenViewModel.errorMessage}");
   });
   log("${subjectReselectionScreenViewModel.errorMessage}");
   return AppButton(
     title: "Load Subjects",
     width: 197,
     color: true,
     onTap: () => {
       subjectReselectionScreenViewModel.loadSubject()
     },
   );
 }

  _buildLoadingWidget() {
    return Center(
      child: SizedBox(
        height: 30,
        width: 30,
        child: CircularProgressIndicator(
          color: kPrimaryColor,
        ),
      ),
    );
  }

 Widget _buildSubjectListWidget(SubjectReselectionScreenViewModel subjectReselectionScreenViewModel) {
   List<Subjects> subjects = subjectReselectionScreenViewModel.allSubjects.map((subject) {

       return Subjects(selected:subjectReselectionScreenViewModel.subjectIsUserSubject(subject),title: subject.name,
         id: subject.id.toString(),
         onSelected: (String subjectId,bool selected){
           if(selected){
             subjectReselectionScreenViewModel.addSubject(int.parse(subjectId));
           }else{
             subjectReselectionScreenViewModel.removeSubject(int.parse(subjectId));
           }
         },);

   }).toList();
   final ProgressDialog progressDialog = ProgressDialog(context:context);
   return Column(
       children: [
         Wrap(
           direction: Axis.horizontal,
           // mainAxisAlignment: MainAxisAlignment.center,
           children:subjects,
         ),
         SizedBox(
           height: 40,
         ),
         AppButton(
           title: "Save",
           width: 150,
           color: true,
           onTap: () async {
             if(subjectReselectionScreenViewModel.userSubjects.length==subjectReselectionScreenViewModel.selectedExamBoard.subject_count){
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
                 await subjectReselectionScreenViewModel.updateUserSubjects();
                 progressDialog.close();
                 appToast?.showToast(message:"Subjects Reselected Successfully");
               }catch(e){
                 progressDialog.close();
                 appToast?.showToast(message: e.toString().substring(11));
                 print(e.toString().substring(11));
               }
             }else{
               appToast?.showToast(message: "Please select ${subjectReselectionScreenViewModel.selectedExamBoard.subject_count} subjects from the list.");
             }
           },
         ),
         SizedBox(height: 20,),
       ]
   );
 }


}
