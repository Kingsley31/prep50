import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:prep50/constants/string_data.dart';
import 'package:prep50/models/news_feed_list_item.dart';
import 'package:prep50/models/user.dart';
import 'package:prep50/utils/color.dart';
import 'package:prep50/utils/exceptions.dart';
import 'package:prep50/utils/preps_icons_icons.dart';
import 'package:prep50/utils/text.dart';
import 'package:prep50/views/home_view/components/filter_dialog.dart';
import 'package:prep50/views/home_view/components/report_dialog.dart';
import 'package:prep50/views/home_view/single_feed_screen.dart';
import 'package:prep50/widgets/app_button.dart';
import 'package:prep50/widgets/app_text_field.dart';
import 'package:prep50/widgets/app_toast.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../view-models/home_screen_view_model.dart';
import '../../view-models/news_feed_list_screen_viewmodel.dart';
import '../Notification_view/notification_screen.dart';
import 'components/drawer.dart';
import 'components/feed_card.dart';


class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // const HomeScreen ({ Key? key }) : super(key: key);
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  AppToast? appToast;


  @override
  void initState() {
    super.initState();
    appToast=AppToast(context: context);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      NewsFeedListScreenViewModel newsFeedListScreenViewModel = Provider.of<NewsFeedListScreenViewModel>(context,listen: false);
      newsFeedListScreenViewModel.loadNewsFeedList();
    });
  }

  @override
  Widget build(BuildContext context) {
    HomeScreenViewModel homeScreenViewModel = Provider.of<HomeScreenViewModel>(context,listen: false);
    NewsFeedListScreenViewModel newsFeedListScreenViewModel = Provider.of<NewsFeedListScreenViewModel>(context,listen: false);
    return Scaffold(
      key: scaffoldKey,
      drawer: AppDrawer(),
      backgroundColor: kAccentColor[300],
      body: Column(
        // padding: EdgeInsets.all(0),
        // shrinkWrap: true,
        children: [
          Container(
            padding: EdgeInsets.all(20),
            color: Colors.white,
            child: SafeArea(
              bottom: false,
              left: false,
              right: false,
              // top: false,
              child: Column(
                children: [
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          scaffoldKey.currentState!.openDrawer();
                        },
                        child: Container(
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
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        flex: 2,
                        child: FutureBuilder<User>(
                            future: homeScreenViewModel.getLoggedInUser(),
                            builder: (context,snapshot){
                              if(snapshot.hasData){
                                return AppText.captionText(
                                  "👋Hello, excited to \nsee you ${snapshot.data?.username}",
                                  multiText: true,
                                );
                              }

                              return SizedBox(
                                height: 20.0,
                                width: 20.0,
                                child: CircularProgressIndicator(
                                  color: kPrimaryColor,
                                ),
                              );
                            },
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          PersistentNavBarNavigator.pushNewScreen(
                            context,
                            screen: NotificationScreen(),
                            withNavBar: false, // OPTIONAL VALUE. True by default.
                          );
                        },
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              color: kPrimaryColor.shade300,
                              borderRadius: BorderRadius.circular(10)),
                          child: Icon(
                            Icons.access_time_outlined,
                            color: kPrimaryColor,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: AppTextField(
                          hText: "Search news, school handles ",
                          showPrefixIcon: true,
                          onChanged: (value){
                            newsFeedListScreenViewModel.searchNewsFeed(value);
                          },
                        ),
                      ),
                      SizedBox(width: 20),
                      InkWell(
                        onTap: ()async {
                         await  FilterDialog.show(context);
                         newsFeedListScreenViewModel.loadNewsFeedList();
                         //print("Dialog Closed");
                        } ,
                        child: Container(
                          decoration: BoxDecoration(
                              color: kPrimaryColor,
                              borderRadius: BorderRadius.circular(10)),
                          height: 40,
                          width: 40,
                          child: Icon(
                            PrepsIcons.menu,
                            color: Colors.white,
                            size: 15,
                          ),
                        ),
                      )
                    ],
                  )
                  // TextField()
                ],
              ),
            ),
          ),
          Expanded(
            child: Consumer<NewsFeedListScreenViewModel>(
                builder: (context,newsFeedListScreenViewModel,child) {
                  return newsFeedListScreenViewModel.feedErrorMessage.isNotEmpty?
                      _buildErrorWidget(newsFeedListScreenViewModel):
                      newsFeedListScreenViewModel.isLoadingFeeds?
                          _buildLoadingWidget():
                          _buildNewsFeedList(newsFeedListScreenViewModel);
              }
            ),
          ),
        ],
      ),
    );
  }

 Widget _buildNewsFeedList(NewsFeedListScreenViewModel newsFeedListScreenViewModel) {
   return ListView.builder(
     shrinkWrap: true,
     // physics: NeverScrollableScrollPhysics(),
     padding: EdgeInsets.all(0),
     itemCount: newsFeedListScreenViewModel.newsFeedList.length,
     itemBuilder: (context, index) {
       return _buildFeedCard(newsFeedListScreenViewModel.newsFeedList[index],newsFeedListScreenViewModel);
     } ,
   );
 }

  Widget _buildFeedCard(NewsFeedListItem newsFeedListItem, NewsFeedListScreenViewModel newsFeedListScreenViewModel) {
    return FeedCard(
      newsFeedListItem: newsFeedListItem,
      onBookmarkButtonClicked: (isBookmarked,slug){
        try{
          newsFeedListScreenViewModel.bookmarkFeed(slug, isBookmarked);
        }on ValidationException catch(e){
          appToast?.showToast(message: e.message);
        }catch(e){
          appToast?.showToast(message: e.toString().substring(11));
        }
      },
      onCommentButtonClicked:(newsFeedListItem){
        //Goto Single Feed Screen
        PersistentNavBarNavigator.pushNewScreen(
          context,
          screen: SingleFeedScreen(newsFeedListItem:newsFeedListItem),
          withNavBar: false, // OPTIONAL VALUE. True by default.
        );
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
    );
  }

 Widget _buildErrorWidget(NewsFeedListScreenViewModel newsFeedListScreenViewModel) {
   WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
     appToast?.showToast(message: newsFeedListScreenViewModel.feedErrorMessage);
   });

   print(newsFeedListScreenViewModel.feedErrorMessage);
   return Center(
     child: AppButton(
       title: "Load News Feed",
       width: 197,
       color: true,
       onTap: () => {
         newsFeedListScreenViewModel.loadNewsFeedList()
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


}
