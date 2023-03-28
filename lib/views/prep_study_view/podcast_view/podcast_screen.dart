import 'package:flutter/material.dart';
import 'package:prep50/utils/color.dart';

class PodCastScreen extends StatelessWidget {
  // const PodCastScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kAccentColor[700],
        body: Stack(
          children: [
            Positioned(
              left: 101,
              child: Stack(
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
            Positioned(
              top: 383,
              child: Container(
                height: 383,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xff212121).withOpacity(0.5),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.elliptical(188, 75),
                    topRight: Radius.elliptical(188, 75),
                  ),
                ),
                // child:
                // ,
              ),
            ),
          ],
        ));
  }
}
