
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:prep50/constants/string_data.dart';
import 'package:prep50/models/podcast.dart';
import 'package:prep50/views/prep_study_view/components/play_mode_icons.dart';
import 'package:prep50/views/prep_study_view/components/player_speed_controls.dart';

import '../models/podcast_topic.dart';
import '../storage/app_data.dart';

class PodcastScreenViewModel extends ChangeNotifier{
  AppData _appData = AppData();
  Podcast? _currentPodcast;
  PodcastTopic? _currentTopic;
  int _currentPodcastIndex=0;
  final AudioPlayer _player = AudioPlayer(playerId: "gfh2fhfh56f7fh");
  bool _isPlaying = true;
  bool _isFavourite = false;
  PlayerSpeed _playerSpeed = PlayerSpeed.oneX;
  PlayMode _currentPlayMode = PlayMode.NORMAL;
  Duration _currentAudioDuration = Duration(minutes: 0);
  Duration _currentAudioProgress = Duration(minutes: 0);

  Duration get currentAudioDuration{
    return _currentAudioDuration;
  }

  Duration get currentAudioProgress{
    return _currentAudioProgress;
  }

  PlayerSpeed get playerSpeed{
    return _playerSpeed;
  }

  PlayMode get currentPlayMode{
    return _currentPlayMode;
  }

  bool get isFavourite{
    return _isFavourite;
  }

  bool get isPlaying{
    return _isPlaying;
  }

  initialize(Podcast podcast,PodcastTopic podcastTopic)async{
    _currentTopic=podcastTopic;
    _currentPodcast = podcast;
    _currentPodcastIndex = podcastTopic.podcasts.indexWhere((element) => element.id ==podcast.id);
    _isFavourite = await _getTopicIsFavourite(podcastTopic);
    notifyListeners();
    print("$BASE_URL/${podcast.url}");

    _player.onDurationChanged.listen((Duration d)async{
      print("duration changed:${d.inSeconds}");
      _currentAudioDuration= await _player.getDuration() ?? Duration(milliseconds: await _player.getCurrentPosition()!!.inMilliseconds+200);
      notifyListeners();
    });

    _player.onPlayerStateChanged.listen((PlayerState playerState) {
      _isPlaying = playerState == PlayerState.playing;
      notifyListeners();
    });

    _player.onPositionChanged.listen((Duration d) async {
      _currentAudioProgress = d;
      _currentAudioDuration=  await _player.getDuration()??Duration(milliseconds: d.inMilliseconds+200);
      notifyListeners();
    });

    _player.onPlayerComplete.listen((event) {
       if(_currentPlayMode == PlayMode.NORMAL){
         _currentPodcastIndex = _currentPodcastIndex<(_currentTopic!.podcasts.length-1)?_currentPodcastIndex+1:0;
         if(_currentPodcastIndex>0){
           _playNextPodcast(_currentPodcastIndex);
         }
       }
    });
    if(_currentPlayMode == PlayMode.NORMAL){
      _player.setReleaseMode(ReleaseMode.stop);
    }else{
      _player.setReleaseMode(ReleaseMode.loop);
    }
    //await _player.play(UrlSource("https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3"));
    await _player.play(UrlSource("$BASE_URL/${podcast.url}"));
    //await _player.resume();
  }

  void _playNextPodcast(int currentPodcastIndex) {
    _currentPodcast = _currentTopic!.podcasts[_currentPodcastIndex];
    _currentAudioDuration = Duration(minutes: 0);
    _currentAudioProgress = Duration(minutes: 0);
    notifyListeners();
    _player.play(UrlSource("$BASE_URL/${_currentPodcast!.url}"));
  }

  void seekPlayerPosition(Duration duration){
    _player.seek(duration);
  }

  void pausePlayer(){
    _player.pause();
  }

  void resumePlayer(){
    _player.resume();
  }

  void playNext(){
    _currentPodcastIndex = _currentPodcastIndex<(_currentTopic!.podcasts.length-1)?_currentPodcastIndex+1:0;
    _playNextPodcast(_currentPodcastIndex);
  }

  void playPrevious(){
    _currentPodcastIndex = _currentPodcastIndex>0?_currentPodcastIndex-1:_currentTopic!.podcasts.length-1;
    _playNextPodcast(_currentPodcastIndex);
  }

  void setPlayerSpeed(PlayerSpeed playerSpeed)async{
    _playerSpeed = playerSpeed;
    if(_playerSpeed == PlayerSpeed.zeroX){
      await _player.setPlaybackRate(0.5);
    }else if(_playerSpeed == PlayerSpeed.oneX){
      await _player.setPlaybackRate(1.0);
    }else{
      await _player.setPlaybackRate(2.0);
    }
    notifyListeners();
  }

  void setPlayMode(PlayMode playMode){
    if(playMode == PlayMode.NORMAL){
      _player.setReleaseMode(ReleaseMode.stop);
    }else{
      _player.setReleaseMode(ReleaseMode.loop);
    }
    _currentPlayMode = playMode;
    notifyListeners();
  }

  Future<bool> _getTopicIsFavourite(PodcastTopic podcastTopic)async {
    List<PodcastTopic> topics = await _appData.getUserSubjectFavouriteTopics(podcastTopic.subjectId);
    return topics.any((topic) => topic.id == podcastTopic.id);
  }

  addCurrentTopicToUserSubjectFavouriteTopic()async {
    List<PodcastTopic> topics = await _appData.getUserSubjectFavouriteTopics(_currentTopic!.subjectId);
    topics.add(_currentTopic!);
    await _appData.saveUserSubjectFavouriteTopics(_currentTopic!.subjectId, topics);
    _isFavourite=true;
    notifyListeners();
  }

  removeCurrentTopicFromUserSubjectFavouriteTopics()async{
    List<PodcastTopic> topics = await _appData.getUserSubjectFavouriteTopics(_currentTopic!.subjectId);
    topics.removeWhere((topic) => topic.id == _currentTopic!.id);
    await _appData.saveUserSubjectFavouriteTopics(_currentTopic!.subjectId, topics);
    _isFavourite=false;
    notifyListeners();
  }

  disposePlayer(){
    _currentAudioDuration=Duration(minutes: 0);
    _currentAudioProgress=Duration(minutes: 0);
    _player.stop();
    //_player.dispose();
  }


}