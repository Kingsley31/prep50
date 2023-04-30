


import 'package:flutter/material.dart';
import 'package:prep50/models/comment.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../utils/color.dart';
import '../../../utils/text.dart';

class CommentCard extends StatelessWidget {
  const CommentCard({Key? key,required this.comment,this.onReportButtonClicked,this.onShareButtonClicked}) : super(key: key);
  final Comment comment;
  final Function(Comment)? onReportButtonClicked;
  final Function(Comment)? onShareButtonClicked;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 2),
      padding: EdgeInsets.all(20),
      color: Colors.white,
      child:  Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                height: 40,
                width: 40,
                child: Image.asset(
                  "assets/image/img1.jpg",
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText.heading6(comment.username,),
                    Row(
                      children: [
                        Icon(
                          size:20,
                          Icons.access_time_outlined,
                          color: kMidGreyColor,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: AppText.captionText(
                            "${timeago.format(DateTime.parse(comment.createdAt).toLocal())}",
                            color: kMidGreyColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Spacer(),
              PopupMenuButton(
                child: Icon(Icons.more_horiz),
                onSelected: (dynamic value) {
                  if (value == "Report") {onReportButtonClicked!(comment);}
                  if(value=="Share Now") {onShareButtonClicked!(comment);}
                },
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: "Report",
                    child: Text('Report'),
                  ),
                  const PopupMenuItem(
                    value: "Share Now",
                    child: Text('Share Now'),
                  ),
                ],
              )
            ],
          ),
          SizedBox(height: 10,),
          AppText.textFieldM(comment.comment,multiText: true,),
        ],
      ),
    );
  }
}
