import 'package:flutter/material.dart';
import 'package:prep50/utils/text.dart';
import 'components/topic_card.dart';

class TopicWidget extends StatelessWidget {
  // const TopicWidget({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      color: Colors.white,
      child: ExpansionTile(
        childrenPadding: EdgeInsets.symmetric(horizontal: 15),
        title: AppText.heading6S("Basics and concept of Government"),
        children: [
          TopicCard(
            topic: "Power & Authority",
            passmark: "64%",
            passcolor: true,
          ),
          Divider(
            color: Color(0xffE5E5E5),
          ),
          TopicCard(
            topic: "Society,state,nation,nation-state",
            passmark: "28%",
            passcolor: false,
          ),
          Divider(
            color: Color(0xffE5E5E5),
          ),
          TopicCard(
            topic: "Political processes;Political socialization,...",
            passmark: "64%",
            passcolor: true,
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
