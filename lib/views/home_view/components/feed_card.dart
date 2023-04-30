
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:prep50/constants/string_data.dart';
import 'package:prep50/utils/color.dart';
import 'package:prep50/utils/preps_icons_icons.dart';
import 'package:prep50/utils/text.dart';

import '../../../models/news_feed_list_item.dart';
import 'package:timeago/timeago.dart' as timeago;

class FeedCard extends StatefulWidget {
  final NewsFeedListItem newsFeedListItem;
  final Function(bool,String)? onLikeButtonClicked;
  final Function(bool,String)? onBookmarkButtonClicked;
  final Function(NewsFeedListItem)? onCommentButtonClicked;
  final Function(NewsFeedListItem)? onShareButtonClicked;
  final Function(NewsFeedListItem)? onReportButtonClicked;
  FeedCard({
    Key? key,
    required this.newsFeedListItem,
    this.onLikeButtonClicked,
    this.onBookmarkButtonClicked,
    this.onCommentButtonClicked,
    this.onShareButtonClicked,
  this.onReportButtonClicked}) : super(key: key);

  @override
  State<FeedCard> createState() => _FeedCardState();
}

class _FeedCardState extends State<FeedCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 2),
      padding: EdgeInsets.all(20),
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                height: 50,
                width: 50,
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
                    AppText.heading6(widget.newsFeedListItem.title,),
                    Row(
                      children: [
                        Icon(
                          Icons.access_time_outlined,
                          color: kMidGreyColor,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: AppText.captionText(
                            "${timeago.format(DateTime.parse(widget.newsFeedListItem.createdAt).toLocal()
                            )}",
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
                  if (value == "Report") {widget.onReportButtonClicked!(widget.newsFeedListItem);}
                  if(value=="Share Now") {widget.onShareButtonClicked!(widget.newsFeedListItem);}
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
          MarkdownBody(data: widget.newsFeedListItem.content),
          widget.newsFeedListItem.photo.isNotEmpty?SizedBox(height: 20):Container(),
          widget.newsFeedListItem.photo.isNotEmpty?
          AspectRatio(
            aspectRatio: 343 / 248,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                "$BASE_URL/${widget.newsFeedListItem.photo}",
                fit: BoxFit.cover,
              ),
            ),
          ):Container(),
          SizedBox(height: 10),
          Row(
            children: [
              bottomIcon(
                  PrepsIcons.like,
                  selected: widget.newsFeedListItem.isLiked,
                  hasCount: true,
                  count: widget.newsFeedListItem.likes.toString(),
                  onTap:(selected){
                    setState(() {
                      widget.newsFeedListItem.isLiked=selected;
                      widget.newsFeedListItem.likes+=1;
                    });
                    widget.onLikeButtonClicked!(selected,widget.newsFeedListItem.slug);
                  }
              ),
              SizedBox(width: 20),
              bottomIcon(
                  PrepsIcons.chat,
                  hasCount: true,
                  count: widget.newsFeedListItem.comments.toString(),
                  onTap: (selected){
                    widget.onCommentButtonClicked!(widget.newsFeedListItem);
                 }
              ),
              SizedBox(width: 20),
              bottomIcon(
                  Icons.insert_link_rounded,
                  onTap:(selected){
                    widget.onShareButtonClicked!(widget.newsFeedListItem);
                  }
              ),
              Spacer(),
              bottomIcon(
                  widget.newsFeedListItem.isBookmarked?Icons.bookmark:Icons.bookmark_outline,
                  selected: widget.newsFeedListItem.isBookmarked,
                  onTap:(selected){
                    setState(() {
                      widget.newsFeedListItem.isBookmarked=selected;
                    });
                    widget.onBookmarkButtonClicked!(selected,widget.newsFeedListItem.slug);
                  }
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget bottomIcon(IconData icon, {bool selected= false,bool hasCount=false,String count="0",Function(bool)? onTap}) {
    return GestureDetector(
      onTap: (){
        onTap!(!selected);
      },
      child: Container(
        decoration: BoxDecoration(
          color: selected ? kPrimaryColor.shade300 : kLighterGreyShadeColour,
          borderRadius: BorderRadius.circular(10),
        ),

        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: selected ? kPrimaryColor : kBlackColor,
            ),
            hasCount?SizedBox(width: 10,):Container(),
            hasCount?AppText.captionText(count,color:selected ? kPrimaryColor : kBlackColor ,):Container(),
          ],
        ),
      ),
    );
  }
}
