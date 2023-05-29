import 'package:flutter/material.dart';
import 'package:prep50/models/podcast_topic.dart';
import 'package:prep50/utils/text.dart';
import 'package:prep50/views/prep_study_view/components/favourite_icon.dart';
import 'package:prep50/views/prep_study_view/components/objective-card.dart';
import 'package:prep50/views/prep_study_view/components/topic-card.dart';
import 'package:prep50/views/prep_study_view/podcast_view/podcast_screen.dart';
import 'package:prep50/widgets/app_text_field.dart';
import 'package:provider/provider.dart';

import '../../../models/podcast.dart';
import '../../../view-models/podcast_topic_screen_viewmodel.dart';
import '../../../widgets/app_back_icon.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/app_toast.dart';
import '../components/favourite_podcast_playlist_bottomsheet.dart';

class PodcastTopicScreen extends StatefulWidget {

  final int subjectId;
  PodcastTopicScreen({required this.subjectId});

  @override
  State<PodcastTopicScreen> createState() => _PodcastTopicScreenState();
}

class _PodcastTopicScreenState extends State<PodcastTopicScreen> {
  AppToast? appToast;

  @override
  void initState() {
    super.initState();
    appToast = AppToast(context: context);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      PodcastTopicScreenViewModel podcastTopicScreenViewModel = Provider.of<PodcastTopicScreenViewModel>(context,listen: false);
      podcastTopicScreenViewModel.loadTopics(widget.subjectId);
    });

  }
  // const TopicScreen(
  @override
  Widget build(BuildContext context) {
    PodcastTopicScreenViewModel podcastTopicScreenViewModel = Provider.of<PodcastTopicScreenViewModel>(context,listen: false);
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
            width: double.infinity,
            color: Colors.white,
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  child: AppTextField(
                    hText: "Search topics",
                    showPrefixIcon: true,
                    onChanged: (value){
                      podcastTopicScreenViewModel.searchTopic(value);
                    },
                  ),
                ),
                SizedBox(width: 10,),
               SizedBox(
                 height: 40,
                 width: 40,
                 child: FavouriteIcon(
                       colored: true,
                       isFavourite: true,
                       onTap: ()async{
                         List<PodcastTopic> topics = await podcastTopicScreenViewModel.getFavouriteTopics(widget.subjectId);
                         FavouritePodcastPlaylistBottomSheet.showExamBoardBottomSheet(context, topics);
                       },
                     ),
               ),
                SizedBox(width: 10,),
              ],
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: Consumer<PodcastTopicScreenViewModel>(
              builder:(context,podcastTopicScreenViewModel,child){
                return podcastTopicScreenViewModel.hasError ? _buildErrorWidget(podcastTopicScreenViewModel) : podcastTopicScreenViewModel.isLoadingTopic? _buildLoadingWidget() : _buildTopicList(podcastTopicScreenViewModel.topicList);
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

 Widget _buildErrorWidget(PodcastTopicScreenViewModel podcastTopicScreenViewModel) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      appToast?.showToast(message: podcastTopicScreenViewModel.errorMessage);
    });

    print(podcastTopicScreenViewModel.errorMessage);
    return Center(
      child: AppButton(
        title: "Load Topics",
        width: 197,
        color: true,
        onTap: () => {
          podcastTopicScreenViewModel.loadTopics(widget.subjectId)
        },
      ),
    );
  }

  _buildTopicList(List<PodcastTopic> topicList) {
    return ListView.builder(
      padding: EdgeInsets.all(0),
      itemCount: topicList.length,
      itemBuilder: (context, index){
        return _buildTopicCard(topicList[index]);
      },
    );
  }

  _buildTopicCard(PodcastTopic topic) {
    return TopicCard(
      topic: topic.title,
      children: _buildPodcasts(topic),
    );
  }

  _buildPodcasts(PodcastTopic topic) {
    List<Podcast> podcasts = topic.podcasts;
    List<ObjectiveCard> podcastsList = podcasts.map<ObjectiveCard>((podcast) =>
        ObjectiveCard(
          objective: podcast.title,
          showIcon: true,
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => PodCastScreen(currentPodcast: podcast, currentTopic: topic)));
          },
        )
    ).toList();
    return podcastsList;
  }
}
