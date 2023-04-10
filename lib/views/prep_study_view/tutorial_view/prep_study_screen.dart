import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prep50/utils/exceptions.dart';
import 'package:prep50/utils/text.dart';
import 'package:prep50/views/prep_study_view/components/tutorial-podcast-nav.dart';
import 'package:prep50/views/prep_study_view/components/subject-card.dart';
import 'package:prep50/views/prep_study_view/podcast_view/podcast_prep_study_screen.dart';
import 'package:prep50/views/prep_study_view/tutorial_view/topics_screen.dart';
import 'package:provider/provider.dart';


import '../../../models/subject.dart';
import '../../../utils/preps_icons_icons.dart';
import '../../../view-models/prep-study-subjects-viewmodel.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/app_toast.dart';

class PrepStudyScreen extends StatefulWidget {
  @override
  State<PrepStudyScreen> createState() => _PrepStudyScreenState();
}

class _PrepStudyScreenState extends State<PrepStudyScreen> {
  AppToast? appToast;



  @override
  void initState() {
    super.initState();
    appToast = AppToast(context: context);
  }

  @override
  Widget build(BuildContext context) {
    PrepStudySubjectsViewModel prepStudySubjectsViewModel = Provider.of<PrepStudySubjectsViewModel>(context,listen: false);
    return Scaffold(
      backgroundColor: Color(0xffE5E5E5),
      body: Column(
        children: [
          Container(
            height: 152,
            width: double.infinity,
            color: Color(0xffffffff),
            child: Column(
              children: [
                SizedBox(height: 58),
                Padding(
                  padding: const EdgeInsets.all(13.5),
                  child: Row(
                    children: [
                      AppText.heading6S("Tutorials"),
                      Spacer(),
                      Icon(
                        PrepsIcons.half_star,
                        size: 20,
                        color: Color(0xffFB7C06),
                      ),
                      SizedBox(width: 5),
                      AppText.textField("26%"),
                    ],
                  ),
                ),
                // SizedBox(height: 15),
                TutorialPodcastNav(
                  activeScreen: ActiveScreen.TUTORIAL,
                  onActiveButtonTapped: (){
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => Scaffold(body: PodcastPrepStudyScreen())));
                  },
                ),
              ],
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Expanded(
              child: FutureBuilder<List<Subject>>(
                future: prepStudySubjectsViewModel.getStudentExamSubjects(),
                builder: (context,snapshot){
                  if(snapshot.connectionState == ConnectionState.done && snapshot.hasData){
                    return _buildSubjectList(snapshot.data ?? [] );
                  }

                  if(snapshot.connectionState == ConnectionState.done && snapshot.hasError){
                    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                      if(snapshot.error == ValidationException){
                        ValidationException error = snapshot.error as ValidationException;
                        appToast?.showToast(message: "${error.message}");
                      }else{
                        appToast?.showToast(message: "${snapshot.error}");
                      }
                    });

                    print("${snapshot.error}");
                    return Center(
                      child: AppButton(
                        title: "Load Subjects",
                        width: 197,
                        color: true,
                        onTap: () => {
                          setState(() {})
                        },
                      ),
                    );
                  }

                  return Center(
                    child: SizedBox(
                      height: 30,
                      width: 30,
                      child: CircularProgressIndicator(),
                    ),
                  );
                },

              ),
          ),
        ],
      ),
    );
  }

  _buildSubjectList(List<Subject> studentSubjects) {
    return ListView.separated(
      padding: EdgeInsets.all(15.0),
        itemCount: studentSubjects.length,
        itemBuilder: (context,index){
          return _buildSubjectCard(studentSubjects[index]);
        },
      separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 10,),
    );
  }

  _buildSubjectCard(Subject studentSubject) {

    return SubjectCard(
      color: _getRandomColor(),
      title: _getSubjectTile(studentSubject.name),
      subject: studentSubject.name,
      subtitle: "All topics for ${studentSubject.name} for all years",
      passColor: studentSubject.progress>50,
      passmark: studentSubject.progress.toString()+"%",
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => TopicScreen(subjectId:studentSubject.id)));
      },
    );
  }

  _getRandomColor() {
    List<Color> colors = [Colors.amber,Colors.red,Colors.blue,Colors.lime.shade800,Colors.blueGrey,Colors.greenAccent,Colors.deepPurple,Colors.brown,Colors.orange.shade400];
    return colors[Random().nextInt(colors.length)];
  }

  _getSubjectTile(String name) {
    if(name.contains(" ")){
       List<String> split = name.split(" ");
       return split.reduce((value, element) => value.substring(0,1) + element.substring(0,1));
    }

    return name.substring(0,2).toUpperCase();
  }
}
