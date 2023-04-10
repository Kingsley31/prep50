

import 'package:flutter/material.dart';

import '../../../utils/text.dart';

class TopicCard extends StatelessWidget {
  final List<Widget> children;
  final String topic;

  TopicCard({Key? key,required this.topic,required this.children}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      color: Colors.white,
      child: ExpansionTile(
        childrenPadding: EdgeInsets.symmetric(horizontal: 15),
        title: AppText.heading6S(topic),
        children: children,
      ),
    );
  }
}
