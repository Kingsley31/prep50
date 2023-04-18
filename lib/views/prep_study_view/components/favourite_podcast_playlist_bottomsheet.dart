import 'package:flutter/material.dart';
import 'package:prep50/utils/text.dart';
import 'package:prep50/views/prep_study_view/components/objective-card.dart';
import 'package:prep50/views/prep_study_view/components/topic-card.dart';

import '../../../models/podcast.dart';
import '../../../models/podcast_topic.dart';
import '../podcast_view/podcast_screen.dart';




class FavouritePodcastPlaylistBottomSheet extends StatefulWidget {
  final List<PodcastTopic> topics;
  const FavouritePodcastPlaylistBottomSheet({Key? key,required this.topics}) : super(key: key);

  @override
  State<FavouritePodcastPlaylistBottomSheet> createState() => _FavouritePodcastPlaylistBottomSheetState();

  static Future showExamBoardBottomSheet(context,List<PodcastTopic> topics) {
    return showModalBottomSheet<void>(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      context: context,
      isDismissible: true,
      enableDrag: false,
      builder: (BuildContext context) {
        return FavouritePodcastPlaylistBottomSheet(topics: topics,);
      },
    );
  }
}

class _FavouritePodcastPlaylistBottomSheetState extends State<FavouritePodcastPlaylistBottomSheet> {


  @override
  Widget build(BuildContext context) {
    return Wrap(
        children:[
          Container(
            height: MediaQuery.of(context).size.height/2,
            decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                )),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      )),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 15,),
                      Container(
                        color: Colors.grey,
                        height: 1,
                        width: 70,
                      ),
                      SizedBox(height: 5,),
                      AppText.heading6("Favourite Playlist",centered: true,),
                      SizedBox(height: 20,),
                    ],
                  ),
                ),
                Expanded(
                    child: _buildTopicList(widget.topics)
                ),
              ],
            ),
          ),
        ]
    );
  }

  _buildTopicList(List<PodcastTopic> topicList) {
    return ListView.builder(
      shrinkWrap: true,
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
