import 'package:flutter/material.dart';
import 'package:prep50/models/comment.dart';
import 'package:prep50/models/news_feed_list_item.dart';
import 'package:prep50/utils/color.dart';
import 'package:prep50/view-models/news_feed_list_screen_viewmodel.dart';
import 'package:prep50/views/home_view/components/comment_card.dart';
import 'package:prep50/views/home_view/components/feed_card.dart';
import 'package:prep50/views/home_view/components/report_dialog.dart';
import 'package:prep50/widgets/app_text_field.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';

import '../../constants/string_data.dart';
import '../../utils/exceptions.dart';
import '../../utils/text.dart';
import '../../view-models/single_feed_screen_viewmodel.dart';
import '../../widgets/app_back_icon.dart';

import '../../widgets/app_button.dart';
import '../../widgets/app_toast.dart';

class SingleFeedScreen extends StatefulWidget {
  final NewsFeedListItem newsFeedListItem;
  const SingleFeedScreen({Key? key,required this.newsFeedListItem}) : super(key: key);

  @override
  State<SingleFeedScreen> createState() => _SingleFeedScreenState();
}

class _SingleFeedScreenState extends State<SingleFeedScreen> {
  TextEditingController commentController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AppToast? appToast;


  @override
  void initState() {
    super.initState();
    appToast=AppToast(context: context);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      SingleFeedScreenViewModel singleFeedScreenViewModel = Provider.of<SingleFeedScreenViewModel>(context,listen: false);
      singleFeedScreenViewModel.loadNewsFeed(widget.newsFeedListItem.slug);
    });
  }

  @override
  Widget build(BuildContext context) {
    NewsFeedListScreenViewModel newsFeedListScreenViewModel = Provider.of<NewsFeedListScreenViewModel>(context,listen: false);
    SingleFeedScreenViewModel singleFeedScreenViewModel = Provider.of<SingleFeedScreenViewModel>(context,listen: false);
    final ProgressDialog progressDialog = ProgressDialog(context:context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15,vertical: 15),
              color: Colors.white,
              child: Row(
                children: [
                  AppBackIcon(),
                  SizedBox(
                    width: 17,
                  ),
                  Expanded(
                      child: AppText.heading6S("${widget.newsFeedListItem.title}"),
                  ),
                ],
              ),
            ),
            Divider(height: 2,),
            FeedCard(
              newsFeedListItem: widget.newsFeedListItem,
              onBookmarkButtonClicked: (isBookmarked,slug){
                try{
                  newsFeedListScreenViewModel.bookmarkFeed(slug, isBookmarked);
                }on ValidationException catch(e){
                  appToast?.showToast(message: e.message);
                }catch(e){
                  appToast?.showToast(message: e.toString().substring(11));
                }
              },
              onLikeButtonClicked:(isLiked,slug){
                try{
                  newsFeedListScreenViewModel.likeFeed(slug, isLiked);
                }on ValidationException catch(e){
                  appToast?.showToast(message: e.message);
                }catch(e){
                  appToast?.showToast(message: e.toString().substring(11));
                }
              },
              onReportButtonClicked: (newsFeedListItem)async{
                final reported = await ReportDialog.show(context,isFeed: true,slug: newsFeedListItem.slug);
                if(reported!=null && reported==true){
                  appToast?.showReportSuccessToast();
                }
              },
              onShareButtonClicked: (newsFeedListItem){
                //Open Share Dialog
                Share.share('$BASE_URL/newsfeed/view?slug=${newsFeedListItem.slug} \n\n${newsFeedListItem.content}', subject: 'Share Feed');
              },
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
              width: double.infinity,
              color: Colors.white,
              child:  AppText.heading6("Comments"),
            ),
            Expanded(
              child: Consumer<SingleFeedScreenViewModel>(
                  builder: (context,singleFeedScreenViewModel,child){
                    return singleFeedScreenViewModel.errorMessage.isNotEmpty?
                    _buildErrorWidget(singleFeedScreenViewModel):
                    singleFeedScreenViewModel.isLoadingFeed?
                    _buildLoadingWidget():
                    _buildCommentList(singleFeedScreenViewModel);
                  },
              ),
            ),
            Form(
              key: _formKey,
              child: Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: AppTextField(
                        controller: commentController,
                          height: 150,
                          hText: "Enter Comment",
                          validator: (value){
                            if(value==null || value.isEmpty) return "Please enter comment";
                          },
                        onChanged: (value){
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: 10,),
                    GestureDetector(
                      onTap:commentController.text.isEmpty?null: ()async{
                        if (_formKey.currentState!.validate()) {
                          progressDialog.show(
                          max: 100,
                          msg: 'Posting Comment...',
                          msgColor: Colors.black,
                          progressValueColor: kPrimaryColor,
                          borderRadius: 10.0,
                          backgroundColor: Colors.white,
                          barrierDismissible: false,
                          elevation: 10.0,
                          );
                          try{
                            await singleFeedScreenViewModel.postComment(commentController.text, widget.newsFeedListItem.slug);
                            commentController.text="";
                            progressDialog.close();
                            appToast?.showToast(message: "Comment posted successfully");
                            setState(() {});
                            singleFeedScreenViewModel.loadNewsFeed(widget.newsFeedListItem.slug);
                          }on ValidationException catch(e){
                          progressDialog.close();
                          appToast?.showToast(message: e.message);
                          }catch(e){
                          progressDialog.close();
                          appToast?.showToast(message: e.toString().substring(11));
                          }
                        }
                      },
                      child: Icon(Icons.send,color:commentController.text.isEmpty?Colors.grey:kPrimaryColor,),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorWidget(SingleFeedScreenViewModel singleFeedScreenViewModel) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      appToast?.showToast(message: singleFeedScreenViewModel.errorMessage);
    });

    print(singleFeedScreenViewModel.errorMessage);
    return Center(
      child: AppButton(
        title: "Load Comments",
        width: 197,
        color: true,
        onTap: () => {
          singleFeedScreenViewModel.loadNewsFeed(widget.newsFeedListItem.slug)
        },
      ),
    );
  }

  Widget _buildLoadingWidget() {
    return Center(
      child: SizedBox(
        height: 30,
        width: 30,
        child: CircularProgressIndicator(),
      ),
    );
  }

 Widget _buildCommentList(SingleFeedScreenViewModel singleFeedScreenViewModel) {
    return ListView.builder(
      itemCount: singleFeedScreenViewModel.newsFeed.comments.length,
        itemBuilder: (context,index){
          return _buildCommentCard(singleFeedScreenViewModel.newsFeed.comments[index]);
        }
    );
 }

  Widget _buildCommentCard(Comment comment) {
    return CommentCard(
      comment: comment,
      onReportButtonClicked: (comment)async{
        final reported = await ReportDialog.show(context,isFeed: false,commentId: comment.id);
        if(reported!=null && reported==true){
          appToast?.showReportSuccessToast();
        }
      },
      onShareButtonClicked: (newsFeedListItem){
        //Open Share Dialog
        Share.share('$BASE_URL/newsfeed/view?slug=${widget.newsFeedListItem.slug} \n\n${comment.comment}', subject: 'Share Comment');
      },
    );
  }



}
