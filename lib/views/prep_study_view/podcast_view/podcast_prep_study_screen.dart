import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prep50/utils/text.dart';
import 'package:prep50/views/prep_study_view/podcast_view/podcast_subject_card.dart';

class PodcastPrepStudyScreen extends StatelessWidget {
  // const AnswerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffE5E5E5),
      body: Column(
        children: [
          Container(
            height: 152,
            width: double.infinity,
            color: Color(0xffffffff),
            child: Column(
              children: [
                SizedBox(height: 58),
                Padding(
                  padding: const EdgeInsets.all(13.5),
                  child: Row(
                    children: [
                      AppText.heading6S("Tutorials"),
                      Spacer(),
                      Icon(Icons.star),
                      SizedBox(width: 10),
                      Text(
                        "26%",
                        style: GoogleFonts.sarabun(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            letterSpacing: -0.04),
                      ),
                    ],
                  ),
                ),
                // SizedBox(height: 15),
                Container(
                  height: 35,
                  width: 343,
                  decoration: BoxDecoration(
                      color: Color(0xfff7f7f7),
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(child: AppText.captionText("Tutorials")),
                        SizedBox(width: 20),
                        Expanded(
                            child: Container(
                                height: 29,
                                width: 169.5,
                                color: Color(0xffffffff),
                                child: Center(
                                    child: AppText.captionText(
                                        "Tutorials Podcasts")))),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Expanded(child: PodcastSubjectCard()),
        ],
      ),
    );
  }
}
