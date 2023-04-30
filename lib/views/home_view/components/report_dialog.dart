
import 'package:flutter/material.dart';
import 'package:prep50/utils/text.dart';

import '../../../utils/color.dart';
import '../home_report_page.dart';

class ReportDialog{
  static Future<bool?> show(context, {bool isFeed=true,String? slug,String? commentId}){
    if(isFeed==true) assert(isFeed==true && slug!=null);
    if(isFeed==false) assert(isFeed==false && commentId!=null);
    return showDialog<bool?>(
          context: context,
          builder: (context){
            return ReportDialogWidget(isFeed: isFeed,slug: slug,commentId: commentId,);
          }
        );
  }
}

class ReportDialogWidget extends StatelessWidget {
  final bool isFeed;
  final String? slug;
  final String? commentId;

  ReportDialogWidget({Key? key,required this.isFeed,this.slug,this.commentId}) : super(key: key);

  final List<String> reports = [
    "Nudity",
    "Violence",
    "False Information",
    "Hate Speech",
    "Gross Content",
    "Spam",
    "Harassment"
  ];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        padding: EdgeInsets.all(20),
        height: 400,
        margin: EdgeInsets.all(20),
        child: Material(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText.heading6("Please, kindly select a problem"),
              AppText.textField(
                "Be very assured that all attentions would be provided and attended to your report",
                multiText: true,
                color: kMidGreyColor,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: reports.length,
                  itemBuilder: (context, index) => InkWell(
                    onTap: () async{
                      final reported= await Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => HomeReportScreen(
                            title: reports[index],
                            isFeed: isFeed,
                            slug: slug,
                            commentId: commentId,
                          ),
                        ),
                      );
                      Navigator.pop(context,reported);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(12.0),
                      child: AppText.heading6(reports[index]),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
