import 'package:flutter/material.dart';
import 'package:prep50/models/objective.dart';
import 'package:prep50/utils/color.dart';
import 'package:prep50/utils/text.dart';
import 'package:prep50/view-models/topic_screen_viewmodel.dart';
import 'package:prep50/views/prep_study_view/components/objective-card.dart';
import 'package:prep50/views/prep_study_view/components/topic-card.dart';
import 'package:prep50/views/prep_study_view/tutorial_view/study_screen.dart';
import 'package:prep50/widgets/app_back_icon.dart';
import 'package:provider/provider.dart';

import '../../../models/topic.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/app_text_field.dart';
import '../../../widgets/app_toast.dart';

class TopicScreen extends StatefulWidget {
  int subjectId;
  TopicScreen({required this.subjectId});

  @override
  State<TopicScreen> createState() => _TopicScreenState();
}

class _TopicScreenState extends State<TopicScreen> {
  AppToast? appToast;

  @override
  void initState() {
    super.initState();
    appToast = AppToast(context: context);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      TopicScreenViewModel topicScreenViewModel = Provider.of<TopicScreenViewModel>(context,listen: false);
      topicScreenViewModel.loadTopics(widget.subjectId);
    });

  }
  @override
  Widget build(BuildContext context) {
    TopicScreenViewModel topicScreenViewModel = Provider.of<TopicScreenViewModel>(context,listen: false);
    return Scaffold(
      backgroundColor: Color(0xffE5E5E5),
      body: Column(
        children: [
          Container(
            // height: 92,
            width: double.infinity,
            color: Color(0xffffffff),
            child: SafeArea(
              bottom: false,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(13.5),
                    child: Row(
                      children: [
                        AppBackIcon(),
                        SizedBox(
                          width: 24,
                        ),
                        AppText.heading6S("Choose a topic")
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 5,),
          Container(
            color: Colors.white,
            padding: EdgeInsets.all(10),
            child: AppTextField(
              hText: "Search topics",
              showPrefixIcon: true,
              onChanged: (value){
                topicScreenViewModel.searchTopic(value);
              },
            ),
          ),
          SizedBox(height: 10),
          Expanded(
              child: Consumer<TopicScreenViewModel>(
                builder:(context,topicScreenViewModel,child){
                  return topicScreenViewModel.hasError ? _buildErrorWidget(topicScreenViewModel) : topicScreenViewModel.isLoadingTopic? _buildLoadingWidget() : _buildTopicList(topicScreenViewModel.topicList);
                } ,
              ),
          )
        ],
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

  _buildTopicList(List<Topic> topicList) {
    return ListView.builder(
      padding: EdgeInsets.all(0),
      itemCount: topicList.length,
      itemBuilder: (context, index){
        return _buildTopicCard(topicList[index]);
      },
    );
  }

  Widget _buildErrorWidget(topicScreenViewModel) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      appToast?.showToast(message: topicScreenViewModel.errorMessage);
    });

    print(topicScreenViewModel.errorMessage);
    return Center(
      child: AppButton(
        title: "Load Topics",
        width: 197,
        color: true,
        onTap: () => {
          topicScreenViewModel.loadTopics(widget.subjectId)
        },
      ),
    );
  }

  Widget _buildTopicCard(Topic topic) {
    return TopicCard(
        topic: topic.title,
        children: _buildObjectives(topic),
    );
  }

 List<Widget> _buildObjectives(Topic topic) {
    List<Objective> objective = topic.objectives;
    List<ObjectiveCard> objectivesList = objective.map<ObjectiveCard>((objective) =>
      ObjectiveCard(
          objective: objective.title,
          passmark: objective.progress.toString()+"%",
          passColor: objective.progress>50,
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => StudyScreen(currentObjective: objective, currentTopic: topic)));
          },
      )
    ).toList();
    return objectivesList;
 }


}
