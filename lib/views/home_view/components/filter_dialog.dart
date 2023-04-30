

import 'package:flutter/material.dart';
import 'package:prep50/models/news_feed_filter.dart';
import 'package:prep50/view-models/news_feed_list_screen_viewmodel.dart';
import 'package:provider/provider.dart';

import '../../../utils/text.dart';

class FilterDialog{
  
  static show(context){
    return showDialog(
        context: context,
        builder: (context) {
          return NewsFeedFilterWidget();
        }
    );
  }
}

class NewsFeedFilterWidget extends StatefulWidget {
  const NewsFeedFilterWidget({Key? key}) : super(key: key);

  @override
  State<NewsFeedFilterWidget> createState() => _NewsFeedFilterWidgetState();
}

class _NewsFeedFilterWidgetState extends State<NewsFeedFilterWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        padding: EdgeInsets.all(20),
        height: 240,
        margin: EdgeInsets.all(20),
        child: Material(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText.heading6("Filter News"),
              SizedBox(height: 5),
              Divider(),
              SizedBox(height: 5),
              Expanded(
                child: Column(
                  children: [
                    Consumer<NewsFeedListScreenViewModel>(
                      builder: (context,newsFeedListScreenViewModel,child) {
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Checkbox(
                                value: newsFeedListScreenViewModel.feedFilter.trending==1?true:false,
                                onChanged: (value){
                                  NewsFeedFilter filter = newsFeedListScreenViewModel.feedFilter;
                                  filter.trending = value!?1:0;
                                  newsFeedListScreenViewModel.feedFilter=filter;
                                }
                            ),
                            SizedBox(width: 5,),
                            AppText.captionText("Trending news")
                          ],
                        );
                      }
                    ),
                    Consumer<NewsFeedListScreenViewModel>(
                        builder: (context,newsFeedListScreenViewModel,child) {
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Checkbox(
                                value: newsFeedListScreenViewModel.feedFilter.newest==1?true:false,
                                onChanged: (value){
                                  NewsFeedFilter filter = newsFeedListScreenViewModel.feedFilter;
                                  filter.newest = value!?1:0;
                                  newsFeedListScreenViewModel.feedFilter=filter;
                                }
                            ),
                            SizedBox(width: 5,),
                            AppText.captionText("Newest News")
                          ],
                        );
                      }
                    ),
                    Consumer<NewsFeedListScreenViewModel>(
                        builder: (context,newsFeedListScreenViewModel,child) {
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Checkbox(
                                value: newsFeedListScreenViewModel.feedFilter.oldest==1?true:false,
                                onChanged: (value){
                                  NewsFeedFilter filter = newsFeedListScreenViewModel.feedFilter;
                                  filter.oldest = value!?1:0;
                                  newsFeedListScreenViewModel.feedFilter=filter;
                                }
                            ),
                            SizedBox(width: 5,),
                            AppText.captionText("Oldest News")
                          ],
                        );
                      }
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
