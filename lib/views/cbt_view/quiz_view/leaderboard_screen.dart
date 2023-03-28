import 'package:flutter/material.dart';
import 'package:prep50/utils/color.dart';
import 'package:prep50/utils/text.dart';
import 'package:prep50/widgets/answer_widget.dart';
import 'package:prep50/widgets/app_button.dart';

class LeaderboardScreen extends StatelessWidget {
  // const LeaderboardScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.all(0),
        children: [
          Container(
            height: 363,
            width: double.infinity,
            color: Color(0XFFF04105),
            child: Column(
              children: [
                SizedBox(
                  height: 44,
                ),
                Container(
                  height: 48,
                  width: double.infinity,
                  color: kPrimaryColor,
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.arrow_back_ios_outlined,
                          color: Color(0xffffffff),
                        ),
                      ),
                      SizedBox(
                        width: 26,
                      ),
                      AppText.heading5S(
                        "Leaderboard",
                        color: Color(0xffffffff),
                      ),
                      Spacer(),
                      Icon(
                        Icons.info_outline_rounded,
                        color: Color(0xffffffff),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 271,
                  width: double.infinity,
                  child: Expanded(
                    child: Stack(
                      children: [
                        Positioned(
                          right: 56,
                          left: 56,
                          child: Column(
                            children: [
                              Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            "assets/png/crown.png"))),
                              ),
                              SizedBox(height: 8),
                              Stack(
                                children: [
                                  Container(
                                    height: 150,
                                    width: 150,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color(0xffeb3c00)),
                                  ),
                                  Positioned(
                                    top: 10,
                                    left: 10,
                                    child: Container(
                                      height: 130,
                                      width: 130,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  "assets/image/img5.jpg"))),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8),
                              AppText.heading6M(
                                "@SonoFigma",
                                color: Color(0xffffffff),
                              ),
                              SizedBox(height: 11),
                              AppText.captionText(
                                "Score: 280",
                                color: Color(0xffffffff),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          left: 2,
                          child: Column(
                            children: [
                              Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image: AssetImage("assets/png/2.png"))),
                              ),
                              SizedBox(height: 8),
                              Stack(
                                children: [
                                  Container(
                                    height: 150,
                                    width: 150,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color(0xffeb3c00)),
                                  ),
                                  Positioned(
                                    top: 10,
                                    left: 10,
                                    child: Container(
                                      height: 130,
                                      width: 130,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  "assets/image/img6.jpg"),
                                              fit: BoxFit.cover)),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8),
                              AppText.heading6M(
                                "@Maybella",
                                color: Color(0xffffffff),
                              ),
                              SizedBox(height: 11),
                              AppText.captionText(
                                "Score: 240",
                                color: Color(0xffffffff),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          right: 2,
                          child: Column(
                            children: [
                              Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage("assets/png/3.png"))),
                              ),
                              SizedBox(height: 8),
                              Stack(
                                children: [
                                  Container(
                                    height: 150,
                                    width: 150,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color(0xffeb3c00)),
                                  ),
                                  Positioned(
                                    top: 10,
                                    left: 10,
                                    child: Container(
                                      height: 130,
                                      width: 130,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  "assets/image/img7.jpg"),
                                              fit: BoxFit.cover)),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8),
                              AppText.heading6M(
                                "@Ikenna",
                                color: Color(0xffffffff),
                              ),
                              SizedBox(height: 11),
                              AppText.captionText(
                                "Score: 238",
                                color: Color(0xffffffff),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            height: 108,
            width: 340,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                    image: AssetImage("assets/png/abeg_icon.png"))),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.amber,
                ),
                SizedBox(width: 10),
                AppText.heading6("Stephen Achebe"),
                Spacer(),
                AppText.captionText("Scores: 232"),
                Container(
                  height: 18,
                  width: 18,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          image: AssetImage("assets/png/triangle.png"))),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.amber,
                ),
                SizedBox(width: 10),
                AppText.heading6("Stephen Achebe"),
                Spacer(),
                AppText.captionText("Scores: 232"),
                Container(
                  height: 18,
                  width: 18,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          image: AssetImage("assets/png/triangle.png"))),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.amber,
                ),
                SizedBox(width: 10),
                AppText.heading6("Stephen Achebe"),
                Spacer(),
                AppText.captionText("Scores: 232"),
                Container(
                  height: 18,
                  width: 18,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          image: AssetImage("assets/png/triangle.png"))),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                  child: AppButton(
                title: "Go Home",
                width: 101,
                color: false,
              )),
              Expanded(
                child: AppButton(
                  title: "Show Aswers",
                  width: 197,
                  color: true,
                  onTap: () => Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => AnswerWidget()),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
