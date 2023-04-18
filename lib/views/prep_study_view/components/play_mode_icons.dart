

import 'package:flutter/material.dart';

import '../../../utils/preps_icons_icons.dart';

enum PlayMode{REPEAT,NORMAL}

class PlayModeNormalIcon extends StatelessWidget {
  final PlayMode currentPlayMode;
  final Function()? onTap;
  const PlayModeNormalIcon({Key? key,required this.currentPlayMode,this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return currentPlayMode == PlayMode.NORMAL? _buildActiveState():_buildNormalState();
  }

 Widget _buildNormalState() {
    return GestureDetector(
      onTap: onTap,
      child: Icon(Icons.clear,color: Colors.white,),
    );
 }

 Widget _buildActiveState() {
    return Container(
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white12,
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      child: Icon(Icons.clear,color: Colors.white,),
    );
 }
}

class PlayModeRepeatIcon extends StatelessWidget {
  final PlayMode currentPlayMode;
  final Function()? onTap;
  const PlayModeRepeatIcon({Key? key,required this.currentPlayMode,this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return currentPlayMode == PlayMode.REPEAT? _buildActiveState():_buildNormalState();
  }

  Widget _buildNormalState() {
    return GestureDetector(
      onTap: onTap,
      child: Icon(Icons.repeat,color: Colors.white,),
    );
  }

  Widget _buildActiveState() {
    return Container(
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white12,
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      child: Icon(Icons.repeat,color: Colors.white,),
    );
  }
}
