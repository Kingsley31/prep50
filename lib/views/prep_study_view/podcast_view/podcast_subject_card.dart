import 'package:flutter/material.dart';
import 'package:prep50/utils/color.dart';
import 'package:prep50/utils/preps_icons_icons.dart';
import 'package:prep50/utils/text.dart';
import 'package:prep50/views/prep_study_view/tutorial_view/components/subject_container.dart';

class PodcastSubjectCard extends StatelessWidget {
  // const SubjectCard({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            color: Colors.white,
            child: SafeArea(
              bottom: false,
              child: Column(
                children: [
                  Row(
                    children: [
                      AppText.heading6S("Tutorials"),
                      Spacer(),
                      Icon(
                        PrepsIcons.half_star,
                        size: 20,
                        color: Color(0xffFB7C06),
                      ),
                      SizedBox(width: 5),
                      AppText.textField("26%"),
                    ],
                  ),
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: kLightGreyShadeColour,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      children: [
                        Expanded(
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
                        Expanded(
                            child: Center(
                                child:
                                    AppText.textField("Tutorials Podcasts"))),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          SubjectContainer(
            color: Colors.amber,
            title: "ENG",
            subject: "English Language",
            passcolor: true,
            passmark: "97%",
            subtitle: "By Emeka Deacons",
            time: "58:30:00Hrs",
          ),
          SizedBox(height: 10),
          SubjectContainer(
            color: Colors.red,
            title: "GOV",
            subject: "Government",
            passcolor: true,
            passmark: "97%",
            subtitle: "By Emeka Deacons",
            time: "58:30:00Hrs",
          ),
          SizedBox(height: 10),
          SubjectContainer(
            color: Colors.blue,
            title: "HIS",
            subject: "History",
            passcolor: true,
            passmark: "97%",
            subtitle: "By Emeka Deacons",
            time: "58:30:00Hrs",
          ),
          SizedBox(height: 10),
          SubjectContainer(
            color: Colors.lime.shade800,
            title: "BUS",
            subject: "English Language",
            passcolor: true,
            passmark: "97%",
            subtitle: "By Emeka Deacons",
            time: "58:30:00Hrs",
          ),
          SizedBox(height: 10),
          SubjectContainer(
            color: Colors.blueGrey,
            title: "LIT",
            subject: "Lit-in-English",
            passcolor: true,
            passmark: "97%",
            subtitle: "By Emeka Deacons",
            time: "58:30:00Hrs",
          ),
          SizedBox(height: 10),
          SubjectContainer(
            color: Colors.greenAccent,
            title: "F.Acc",
            subject: "Financial Accounting",
            passcolor: true,
            passmark: "97%",
            subtitle: "By Emeka Deacons",
            time: "58:30:00Hrs",
          ),
          SizedBox(height: 10),
          SubjectContainer(
            color: Colors.deepPurple,
            title: "PHY",
            subject: "Physics",
            passcolor: true,
            passmark: "97%",
            subtitle: "By Emeka Deacons",
            time: "58:30:00Hrs",
          ),
          SizedBox(height: 10),
          SubjectContainer(
            color: Colors.brown,
            title: "CHM",
            subject: "Chemistry",
            passcolor: true,
            passmark: "97%",
            subtitle: "By Emeka Deacons",
            time: "58:30:00Hrs",
          ),
          SizedBox(height: 10),
          SubjectContainer(
            color: Colors.orange.shade400,
            title: "CRS",
            subject: "Christian Religious Knowledge",
            passcolor: true,
            passmark: "97%",
            subtitle: "By Emeka Deacons",
            time: "58:30:00Hrs",
          ),
        ],
      ),
    );
  }
}
