import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:prep50/models/podcast_topic.dart';
import 'package:prep50/utils/color.dart';
import 'package:prep50/utils/text.dart';
import 'package:prep50/views/prep_study_view/components/favourite_icon.dart';
import 'package:prep50/views/prep_study_view/components/play_mode_icons.dart';
import 'package:prep50/views/prep_study_view/components/player_speed_controls.dart';
import 'package:prep50/widgets/app_back_icon.dart';
import 'package:provider/provider.dart';

import '../../../models/podcast.dart';
import '../../../view-models/podcast_screen_viewmodel.dart';
import '../components/player_controls.dart';

class PodCastScreen extends StatefulWidget {
  final Podcast currentPodcast;
  final PodcastTopic currentTopic;

  PodCastScreen({required this.currentPodcast,required this.currentTopic});


  @override
  State<PodCastScreen> createState() => _PodCastScreenState();
}

class _PodCastScreenState extends State<PodCastScreen> {
  late PodcastScreenViewModel podcastScreenViewModel;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      podcastScreenViewModel = Provider.of<PodcastScreenViewModel>(context,listen: false);
      podcastScreenViewModel.initialize(widget.currentPodcast,widget.currentTopic);
    });

  }


  @override
  void dispose() {
    podcastScreenViewModel.disposePlayer();
    super.dispose();

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kAccentColor[700],
        body: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: 254,
                width: double.infinity,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Positioned(
                      top: 15,
                      left: 20,
                        child: Container(
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: Colors.white12,
                            borderRadius: BorderRadius.all(Radius.circular(8.0)),
                          ),
                          child: AppBackIcon(),
                        ),
                    ),
                    Positioned(
                      top: 15,
                      right: 20,
                      child: Consumer<PodcastScreenViewModel>(
                        builder: (context,podcastScreenViewModel,child) {
                          return FavouriteIcon(
                            isFavourite: podcastScreenViewModel.isFavourite,
                            colored: false,
                            onTap: (){
                              if(podcastScreenViewModel.isFavourite){
                                podcastScreenViewModel.removeCurrentTopicFromUserSubjectFavouriteTopics();
                              }else{
                                podcastScreenViewModel.addCurrentTopicToUserSubjectFavouriteTopic();
                              }
                            },
                          );
                        }
                      ),
                    ),
                    Positioned(
                      right: 0,
                      left: 0,
                      top: 0,
                      child: Align(
                        alignment: Alignment.center,
                        child: Stack(
                          fit: StackFit.loose,
                          children: [
                            Container(
                              height: 254,
                              width: 175,
                              decoration: BoxDecoration(
                                  color: Color(0xff000000),
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(100),
                                    bottomRight: Radius.circular(100),
                                  )),
                            ),
                            Positioned(
                              top: 79,
                              left: 1,
                              child: Container(
                                height: 173,
                                width: 173,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image: AssetImage("assets/png/podcast.png"))),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10),
                child: AppText.textFieldM(
                  widget.currentTopic.title,
                  color: Colors.white,
                  centered: true,
                  multiText: true,
                ),
              ),
              SizedBox(height: 10,),
              Container(
                width: 170,
                padding: EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.white10,
                  border: Border.all(color: Colors.white,width: 1.0,style: BorderStyle.solid),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Consumer<PodcastScreenViewModel>(
                      builder: (context,podcastScreenViewModel,child) {
                        return AppText.textField("${podcastScreenViewModel.currentAudioDuration.inMinutes>0?podcastScreenViewModel.currentAudioDuration.inMinutes:".."} minutes record",color: Colors.white,);
                      }
                    ),
                    SizedBox(width: 10,),
                    Icon(Icons.headset,color: Colors.white,)
                  ],
                ) ,
              ),
              SizedBox(height: 40,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Consumer<PodcastScreenViewModel>(
                    builder: (context,podcastScreenViewModel,child) {
                      print("Position Change");
                    return ProgressBar(
                      thumbColor: Colors.white70,
                      progressBarColor: kPrimaryColor,
                      progress: podcastScreenViewModel.currentAudioProgress,
                      total: podcastScreenViewModel.currentAudioDuration,
                      timeLabelLocation: TimeLabelLocation.below,
                      timeLabelTextStyle: TextStyle(color: Colors.white),
                      timeLabelPadding: 10,
                      onSeek: (progress){
                        podcastScreenViewModel.seekPlayerPosition(progress);
                      },
                    );
                  }
                ),
              ),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                child: Row(
                  children: [
                    Consumer<PodcastScreenViewModel>(
                        builder: (context,podcastScreenViewModel,child) {
                        return PlayModeNormalIcon(
                            currentPlayMode: podcastScreenViewModel.currentPlayMode,
                            onTap: (){
                              podcastScreenViewModel.setPlayMode(PlayMode.NORMAL);
                            },
                          );
                      }
                    ),
                    Spacer(),
                    Consumer<PodcastScreenViewModel>(
                        builder: (context,podcastScreenViewModel,child) {
                        return PlayModeRepeatIcon(
                            currentPlayMode: podcastScreenViewModel.currentPlayMode,
                            onTap: (){
                              podcastScreenViewModel.setPlayMode(PlayMode.REPEAT);
                            },
                          );
                      }
                    ),
                  ],
                ),
              ),
              Consumer<PodcastScreenViewModel>(
                  builder: (context,podcastScreenViewModel,child) {
                  return PlayerControls(
                    isPlaying:podcastScreenViewModel.isPlaying,
                    onNextButtonTap: (){
                      podcastScreenViewModel.playNext();
                    },
                    onPreviousButtonTap: (){
                      podcastScreenViewModel.playPrevious();
                    },
                    onPlayButtonTap: (){
                      podcastScreenViewModel.resumePlayer();
                    },
                    onPauseButtonTap: (){
                      podcastScreenViewModel.pausePlayer();
                    },
                  );
                }
              ),
              Spacer(),
              Padding(
                padding: EdgeInsets.all(15),
                child: Consumer<PodcastScreenViewModel>(
                    builder: (context,podcastScreenViewModel,child) {
                    return PlayerSpeedControls(
                      currentPlayerSpeed: podcastScreenViewModel.playerSpeed,
                      playerSpeedChanged: (PlayerSpeed currentSpeed){
                        podcastScreenViewModel.setPlayerSpeed(currentSpeed);
                      },
                    );
                  }
                ),
              ),
            ],
          ),
        )
    );
  }




}
