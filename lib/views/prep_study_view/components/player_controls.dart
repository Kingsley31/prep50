


import 'package:flutter/material.dart';

class PlayerControls extends StatelessWidget {
  final Function()? onNextButtonTap;
  final Function()? onPreviousButtonTap;
  final Function()? onPlayButtonTap;
  final Function()? onPauseButtonTap;
  final bool isPlaying;
  const PlayerControls({Key? key,required this.isPlaying,this.onNextButtonTap,this.onPreviousButtonTap,this.onPlayButtonTap,this.onPauseButtonTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: onPreviousButtonTap,
            child: Icon(Icons.skip_previous,color: Colors.white,size: 40,),
          ),
          SizedBox(width: 30,),
          SizedBox(
            height: 80,
            width: 80,
            child: Stack(
              children: [
                Positioned(
                    right: 0,
                    left: 0,
                    top: 0,
                    child: Align(
                      alignment: Alignment.center,
                      child: Image.asset("assets/png/play_icon_background.png"),
                    )
                ),
                isPlaying? _buildPauseIcon():_buildPlayIcon(),
              ],
            ),
          ),
          SizedBox(width: 30,),
          GestureDetector(
            onTap: onNextButtonTap,
            child: Icon(Icons.skip_next,color: Colors.white,size: 40,),
          ),
        ],
      ),
    );
  }

  Widget _buildPauseIcon() {
    return Positioned(
        left: 0,
        right: 0,
        top: 0,
        bottom: 0,
        child: Align(
          alignment: Alignment.center,
          child: GestureDetector(
            onTap: onPauseButtonTap,
            child: Icon(Icons.pause,color: Colors.white,size: 40,),
          ),
        )
    );
  }

  Widget _buildPlayIcon() {
    return Positioned(
        left: 0,
        right: 0,
        top: 0,
        bottom: 0,
        child: Align(
          alignment: Alignment.center,
          child: GestureDetector(
            onTap: onPlayButtonTap,
            child: Icon(Icons.play_arrow,color: Colors.white,size: 40,),
          ),
        )
    );
  }
}
