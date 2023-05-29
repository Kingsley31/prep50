import 'package:flutter/material.dart';
import 'package:prep50/models/comment.dart';
import 'package:prep50/models/news_feed.dart';
import 'package:prep50/models/news_feed_list_item.dart';
import 'package:prep50/utils/color.dart';
import 'package:prep50/utils/deeplink_utils.dart';
import 'package:prep50/view-models/news_feed_list_screen_viewmodel.dart';
import 'package:prep50/views/home_view/components/comment_card.dart';
import 'package:prep50/views/home_view/components/feed_card.dart';
import 'package:prep50/views/home_view/components/report_dialog.dart';
import 'package:prep50/widgets/app_text_field.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';

import '../../utils/exceptions.dart';
import '../../utils/text.dart';
import '../../view-models/single_feed_screen_viewmodel.dart';
import '../../widgets/app_back_icon.dart';

import '../../widgets/app_button.dart';
import '../../widgets/app_toast.dart';

class SingleFeedScreen extends StatefulWidget {
  final NewsFeedListItem? newsFeedListItem;
  final String? slug;
  const SingleFeedScreen({Key? key,this.newsFeedListItem,this.slug}) : super(key: key);

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
      singleFeedScreenViewModel.loadNewsFeed(widget.newsFeedListItem!=null?widget.newsFeedListItem!.slug:widget.slug!);
    });
  }

  @override
  Widget build(BuildContext context) {
    print(widget.slug);
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
                      child: widget.newsFeedListItem!=null?_buildTitleWidget(widget.newsFeedListItem!):_buildFutureTitleWidget(),
                  ),
                ],
              ),
            ),
            Divider(height: 2,),
            widget.newsFeedListItem!=null?_buildFeedCard(widget.newsFeedListItem!,newsFeedListScreenViewModel):_buildFutureFeedCard(newsFeedListScreenViewModel),
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
                            return null;
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
                            await singleFeedScreenViewModel.postComment(commentController.text, widget.newsFeedListItem!=null?widget.newsFeedListItem!.slug:widget.slug!);
                            commentController.text="";
                            progressDialog.close();
                            appToast?.showToast(message: "Comment posted successfully");
                            setState(() {});
                            singleFeedScreenViewModel.loadNewsFeed(widget.newsFeedListItem!=null?widget.newsFeedListItem!.slug:widget.slug!);
                          }on LoginException catch(e){
                            progressDialog.close();
                            appToast?.showToast(message: e.message);
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
          singleFeedScreenViewModel.loadNewsFeed(widget.newsFeedListItem!=null?widget.newsFeedListItem!.slug:widget.slug!)
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
    final NewsFeed newsFeed=singleFeedScreenViewModel.newsFeed;
   final NewsFeedListItem newsFeedListItem = NewsFeedListItem(
       newsFeed.slug,
       newsFeed.title,
       newsFeed.photo,
       newsFeed.content,
       newsFeed.createdAt,
       newsFeed.updatedAt,
       newsFeed.likes,
       newsFeed.comments.length,
       newsFeed.isLiked,
       newsFeed.isBookmarked);
    return ListView.builder(
      itemCount: newsFeed.comments.length,
        itemBuilder: (context,index){
          return _buildCommentCard(newsFeed.comments[index],newsFeedListItem);
        }
    );
 }

  Widget _buildCommentCard(Comment comment,NewsFeedListItem newsFeedListItem) {
    return CommentCard(
      comment: comment,
      onReportButtonClicked: (comment)async{
        final reported = await ReportDialog.show(context,isFeed: false,commentId: comment.id);
        if(reported!=null && reported==true){
          appToast?.showReportSuccessToast();
        }
      },
      onShareButtonClicked: (comment)async{
        try{
          String postLink = await buildFeedLink(newsFeedListItem.slug);
          //Open Share Dialog
          Share.share('$postLink \n\n${comment.comment}', subject: 'Share Comment');
        }catch(e){
          appToast?.showToast(message: "unable to load link please ensure your device is online and try again");
        }
      },
    );
  }

 Widget _buildFeedCard(NewsFeedListItem newsFeedListItem,NewsFeedListScreenViewModel newsFeedListScreenViewModel) {
    return  FeedCard(
      newsFeedListItem: newsFeedListItem,
      onBookmarkButtonClicked: (isBookmarked,slug){
        try{
          newsFeedListScreenViewModel.bookmarkFeed(slug, isBookmarked);
        }on LoginException catch(e){
          appToast?.showToast(message: e.message);
        }on ValidationException catch(e){
          appToast?.showToast(message: e.message);
        }catch(e){
          appToast?.showToast(message: e.toString().substring(11));
        }
      },
      onLikeButtonClicked:(isLiked,slug){
        try{
          newsFeedListScreenViewModel.likeFeed(slug, isLiked);
        }on LoginException catch(e){
          appToast?.showToast(message: e.message);
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
      onShareButtonClicked: (newsFeedListItem)async{
        try{
          String postLink = await buildFeedLink(newsFeedListItem.slug);
          Share.share('$postLink \n\n${newsFeedListItem.content}', subject: 'Share Feed');
        }catch(e){
          appToast?.showToast(message: "unable to load link please ensure your device is online and try again");
        }
        //Open Share Dialog

      },
    );
 }

 Widget _buildFutureFeedCard(NewsFeedListScreenViewModel newsFeedListScreenViewModel) {
    return Consumer<SingleFeedScreenViewModel>(
      builder: (context,singleFeedScreenViewModel,child){
        return singleFeedScreenViewModel.errorMessage.isEmpty && singleFeedScreenViewModel.isLoadingFeed==false?
        _buildFeedCard(NewsFeedListItem(
            singleFeedScreenViewModel.newsFeed.slug,
            singleFeedScreenViewModel.newsFeed.title,
            singleFeedScreenViewModel.newsFeed.photo,
            singleFeedScreenViewModel.newsFeed.content,
            singleFeedScreenViewModel.newsFeed.createdAt,
            singleFeedScreenViewModel.newsFeed.updatedAt,
            singleFeedScreenViewModel.newsFeed.likes,
            singleFeedScreenViewModel.newsFeed.comments.length,
            singleFeedScreenViewModel.newsFeed.isLiked,
            singleFeedScreenViewModel.newsFeed.isBookmarked), newsFeedListScreenViewModel):
        _buildLoadingWidget();
      },
    );
 }

 Widget _buildTitleWidget(NewsFeedListItem newsFeedListItem) {
    print(newsFeedListItem.title);
    return AppText.heading6S("${newsFeedListItem.title}");
 }

 Widget _buildFutureTitleWidget() {
   return Consumer<SingleFeedScreenViewModel>(
     builder: (context,singleFeedScreenViewModel,child){
       return singleFeedScreenViewModel.errorMessage.isEmpty && singleFeedScreenViewModel.isLoadingFeed==false?
       _buildTitleWidget(NewsFeedListItem(
           singleFeedScreenViewModel.newsFeed.slug,
           singleFeedScreenViewModel.newsFeed.title,
           singleFeedScreenViewModel.newsFeed.photo,
           singleFeedScreenViewModel.newsFeed.content,
           singleFeedScreenViewModel.newsFeed.createdAt,
           singleFeedScreenViewModel.newsFeed.updatedAt,
           singleFeedScreenViewModel.newsFeed.likes,
           singleFeedScreenViewModel.newsFeed.comments.length,
           singleFeedScreenViewModel.newsFeed.isLiked,
           singleFeedScreenViewModel.newsFeed.isBookmarked)):
       Container(height: 2,width: 2,);
     },
   );
 }



}
