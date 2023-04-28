


import 'package:flutter/material.dart';

import '../../../utils/text.dart';

class LeaderBoardCard extends StatelessWidget {
  final String username;
  final String photo;
  final int score;
  const LeaderBoardCard({Key? key,required this.username,required this.photo,required this.score}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          _buildPhoto(photo),
          SizedBox(width: 10),
          Expanded(child: AppText.heading6(username)),
          Spacer(),
          AppText.captionText("Scores: $score"),
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
    );
  }

 Widget _buildPhoto(String photo) {
    return photo.isEmpty ? CircleAvatar(
        radius: 25,
        backgroundColor: Colors.amber,
    ): CircleAvatar(
      radius: 25,
      backgroundImage: NetworkImage(photo),
    );
 }
}
