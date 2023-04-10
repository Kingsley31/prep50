
import 'package:flutter/material.dart';

import '../../../utils/color.dart';
import '../../../utils/text.dart';

enum ActiveScreen{
  TUTORIAL,
  PODCAST
}

class TutorialPodcastNav extends StatelessWidget {
  final ActiveScreen activeScreen;
  final Function()? onActiveButtonTapped;

  const TutorialPodcastNav({Key? key,required this.activeScreen,this.onActiveButtonTapped}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(activeScreen == ActiveScreen.TUTORIAL){
      return _buildTutorialActiveNav();
    }
    return _buildPodcastActiveNav();
  }

  Widget _buildTutorialActiveNav() {
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: kLightGreyShadeColour,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          Expanded(
            child: Center(child: AppText.textField("Tutorials")),
          ),
          Expanded(
              child: GestureDetector(
                onTap: onActiveButtonTapped,
                child: Center(
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5)
                      ),
                      padding: EdgeInsets.all(5),
                      width: double.infinity,
                        child: Center(child: AppText.textField("Tutorials Podcasts")),
                    ),
                ),
              ),
          ),
        ],
      ),
    );
  }

  Widget _buildPodcastActiveNav() {
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: kLightGreyShadeColour,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: onActiveButtonTapped,
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5)),
                  padding: EdgeInsets.all(5),
                  width: double.infinity,
                  child:
                  Center(child: AppText.textField("Tutorials")),
                ),
              ),
            ),
          ),
          Expanded(
              child: Center(
                  child:
                  AppText.textField("Tutorials Podcasts"))),
        ],
      ),
    );
  }
}
