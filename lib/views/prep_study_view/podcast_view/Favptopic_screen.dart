import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:prep50/utils/color.dart';
import 'package:prep50/utils/text.dart';
import 'package:prep50/views/prep_study_view/podcast_view/ptopic_widget.dart';
import 'package:prep50/widgets/app_text_field.dart';

class FavouritePodcastTopicScreen extends StatelessWidget {
  // const TopicScreen(
  //     {Key key,})
  //     : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffE5E5E5),
      body: Column(
        children: [
          Container(
            height: 92,
            width: double.infinity,
            color: Color(0xffffffff),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(13.5),
                  child: Row(
                    children: [
                      Container(
                        height: 22,
                        width: 22,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: kPrimaryColor),
                        child: Icon(
                          Icons.arrow_back_ios_rounded,
                          color: Color(0xffffffff),
                          size: 15,
                        ),
                      ),
                      SizedBox(
                        width: 24,
                      ),
                      AppText.heading6S("Choose a topic")
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 59,
            width: double.infinity,
            color: Color(0xffffffff),
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(13.5),
                        child: Row(
                          children: [
                            AppTextField(hText: "Search topic",showPrefixIcon: true,),
                            Spacer(),
                            GestureDetector(
                              onTap: () {
                                showMaterialModalBottomSheet(
                                  context: context,
                                  builder: (context) => SingleChildScrollView(
                                    controller: ModalScrollController.of(context),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 35),
                                      child: Container(
                                        height: 295,
                                        width: double.infinity,
                                        decoration: BoxDecoration(),
                                        child: Column(
                                          children: [
                                            Container(
                                                height: 1,
                                                width: 72,
                                                decoration: BoxDecoration(
                                                    color: Color(0xffe0e0e0),
                                                    borderRadius:
                                                    BorderRadius.circular(10))),
                                            SizedBox(height: 10),
                                            AppText.heading6S("Favourite Playlist"),
                                            SizedBox(height: 10),
                                            Expanded(child: PodcastTopicWidget())
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                height: 35.7,
                                width: 34,
                                decoration: BoxDecoration(
                                    color: Color(0xfffff4f0),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Icon(
                                  Icons.favorite,
                                  color: kPrimaryColor,
                                  size: 20,
                                ),
                              ),
                            ),],
                        ),
                      ),
                    ],
                  ),

                ],
              ),
            ),
          ),
          Expanded(child: PodcastTopicWidget())
        ],
      ),
    );
  }
}
