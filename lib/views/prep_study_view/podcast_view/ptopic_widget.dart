import 'package:flutter/material.dart';
import 'package:prep50/utils/text.dart';
import 'package:prep50/views/prep_study_view/tutorial_view/components/topic_card.dart';

class PodcastTopicWidget extends StatelessWidget {
  // const TopicWidget({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
            height: 181,
            width: double.infinity,
            color: Color(0xffffffff),
            child: Column(children: [
              Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 2),
                    child: Row(
                      children: [
                        AppText.heading6S("Basics and concept of Government"),
                        Spacer(),
                        Icon(Icons.arrow_upward_rounded),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Divider(
                      color: Color(0xffE5E5E5),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 2),
                    child: TopicCard(
                      topic: "Power & Authority",
                      showIcon: true,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Divider(
                      color: Color(0xffE5E5E5),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 2),
                    child: TopicCard(
                      topic: "Society,state,nation,nation-state",
                      showIcon: true,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Divider(
                      color: Color(0xffE5E5E5),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 2),
                    child: TopicCard(
                      topic: "Political processes;Political socialization,...",
                      showIcon: true,
                    ),
                  ),
                ],
              )
            ])),
        SizedBox(
          height: 10,
        ),
        Container(
          height: 59,
          width: double.infinity,
          color: Color(0xffffffff),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(13.5),
                child: Row(
                  children: [
                    AppText.heading6S("Basics and concept of Government"),
                    Spacer(),
                    Icon(Icons.arrow_downward_rounded),
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(13.5),
                child: Row(
                  children: [
                    AppText.heading6S("Basics and concept of Government"),
                    Spacer(),
                    Icon(Icons.arrow_downward_rounded),
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(13.5),
                child: Row(
                  children: [
                    AppText.heading6S("Basics and concept of Government"),
                    Spacer(),
                    Icon(Icons.arrow_downward_rounded),
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
            height: 181,
            width: double.infinity,
            color: Color(0xffffffff),
            child: Column(children: [
              Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 2),
                    child: Row(
                      children: [
                        AppText.heading6S("Basics and concept of Government"),
                        Spacer(),
                        Icon(Icons.arrow_upward_rounded),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Divider(
                      color: Color(0xffE5E5E5),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 2),
                    child: TopicCard(
                      topic: "Power & Authority",
                      showIcon: true,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Divider(
                      color: Color(0xffE5E5E5),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 2),
                    child: TopicCard(
                      topic: "Society,state,nation,nation-state",
                      showIcon: true,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Divider(
                      color: Color(0xffE5E5E5),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 2),
                    child: TopicCard(
                      topic: "Political processes;Political socialization,...",
                      showIcon: true,
                    ),
                  ),
                ],
              )
            ])),
        Container(
          height: 59,
          width: double.infinity,
          color: Color(0xffffffff),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(13.5),
                child: Row(
                  children: [
                    AppText.heading6S("Basics and concept of Government"),
                    Spacer(),
                    Icon(Icons.arrow_downward_rounded),
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(13.5),
                child: Row(
                  children: [
                    AppText.heading6S("Basics and concept of Government"),
                    Spacer(),
                    Icon(Icons.arrow_downward_rounded),
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(13.5),
                child: Row(
                  children: [
                    AppText.heading6S("Basics and concept of Government"),
                    Spacer(),
                    Icon(Icons.arrow_downward_rounded),
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(13.5),
                child: Row(
                  children: [
                    AppText.heading6S("Basics and concept of Government"),
                    Spacer(),
                    Icon(Icons.arrow_downward_rounded),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
