


import 'package:flutter/material.dart';
import 'package:prep50/constants/string_data.dart';
import 'package:prep50/models/weekly_quiz_participant.dart';
import 'package:prep50/view-models/weekly_quiz_leader_board_screen_viewmodel.dart';
import 'package:prep50/views/weekly_quiz/components/leader_board_card.dart';
import 'package:prep50/views/weekly_quiz/weekly_quiz_answer_screen.dart';
import 'package:provider/provider.dart';

import '../../utils/color.dart';
import '../../utils/text.dart';
import '../../widgets/app_button.dart';
import '../../widgets/app_toast.dart';
import '../home_view/home_view.dart';

class WeeklyQuizLeaderBoardScreen extends StatefulWidget {
  const WeeklyQuizLeaderBoardScreen({Key? key}) : super(key: key);

  @override
  State<WeeklyQuizLeaderBoardScreen> createState() => _WeeklyQuizLeaderBoardScreenState();
}

class _WeeklyQuizLeaderBoardScreenState extends State<WeeklyQuizLeaderBoardScreen> {
  AppToast? appToast;

  @override
  void initState() {
    super.initState();
    appToast = AppToast(context: context);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      WeeklyQuizLeaderBoardScreenViewModel weeklyQuizLeaderBoardScreenViewModel = Provider.of<WeeklyQuizLeaderBoardScreenViewModel>(context,listen: false);
      weeklyQuizLeaderBoardScreenViewModel.loadLeaderBoard();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 48,
              width: double.infinity,
              color: kPrimaryColor,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back_ios_outlined,
                        color: Color(0xffffffff),
                      ),
                    ),
                    SizedBox(
                      width: 26,
                    ),
                    AppText.heading5S(
                      "Leaderboard",
                      color: Color(0xffffffff),
                    ),
                    Spacer(),
                    Icon(
                      Icons.info_outline_rounded,
                      color: Color(0xffffffff),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 271,
              width: double.infinity,
              color: Color(0XFFF04105),
              child: Center(
                child: Consumer<WeeklyQuizLeaderBoardScreenViewModel>(
                  builder: (context,weeklyQuizLeaderBoardScreenViewModel,child) {
                    return weeklyQuizLeaderBoardScreenViewModel.errorMessage.isNotEmpty?
                        Container():weeklyQuizLeaderBoardScreenViewModel.isLoadingLeaderBoard?
                        _buildLoadingWidget(isDefaultColor: false):
                        _buildWinnerBoardWidget(weeklyQuizLeaderBoardScreenViewModel);
                  }
                ),
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: Consumer<WeeklyQuizLeaderBoardScreenViewModel>(
                builder: (context,weeklyQuizLeaderBoardScreenViewModel,child) {
                  return weeklyQuizLeaderBoardScreenViewModel.errorMessage.isNotEmpty?
                  _buildErrorWidget(weeklyQuizLeaderBoardScreenViewModel):
                  weeklyQuizLeaderBoardScreenViewModel.isLoadingLeaderBoard?
                  _buildLoadingWidget():
                  _buildLeaderBoardList(weeklyQuizLeaderBoardScreenViewModel);
                }
              ),
            ),
            SizedBox(height: 5,),
            Row(
              children: [
                Expanded(
                    child: AppButton(
                      title: "Go Home",
                      width: 101,
                      color: false,
                      onTap: (){
                        Navigator.popUntil(context,ModalRoute.withName(HomeView.routeName));
                      },
                    )),
                Expanded(
                  child: AppButton(
                    title: "Show Answers",
                    width: 197,
                    color: true,
                    onTap: () => Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => WeeklyQuizAnswerScreen()),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildErrorWidget(WeeklyQuizLeaderBoardScreenViewModel weeklyQuizLeaderBoardScreenViewModel) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      appToast?.showToast(message: weeklyQuizLeaderBoardScreenViewModel.errorMessage);
    });

    print(weeklyQuizLeaderBoardScreenViewModel.errorMessage);
    return Center(
      child: AppButton(
        title: "Load Questions",
        width: 197,
        color: true,
        onTap: () => {
          weeklyQuizLeaderBoardScreenViewModel.loadLeaderBoard()
        },
      ),
    );
  }

  Widget _buildLoadingWidget({isDefaultColor=true}) {
    return Center(
      child: SizedBox(
        height: 30,
        width: 30,
        child: CircularProgressIndicator(
          color: isDefaultColor?kPrimaryColor:Colors.white,
        ),
      ),
    );
  }

 Widget _buildLeaderBoardList(WeeklyQuizLeaderBoardScreenViewModel weeklyQuizLeaderBoardScreenViewModel) {
    return ListView.separated(
        itemBuilder: (context,index){
          WeeklyQuizParticipant weeklyQuizParticipant = weeklyQuizLeaderBoardScreenViewModel.leaderBoard[index];
          String photo = weeklyQuizParticipant.photo.isNotEmpty?"$BASE_URL/${weeklyQuizParticipant.photo}":"";
          return LeaderBoardCard(username:weeklyQuizParticipant.username, photo: photo, score: weeklyQuizParticipant.score);
        },
        separatorBuilder: (context,index) => SizedBox(height: 8,),
        itemCount: weeklyQuizLeaderBoardScreenViewModel.leaderBoard.length
    );
 }

 Widget _buildWinnerBoardWidget(WeeklyQuizLeaderBoardScreenViewModel weeklyQuizLeaderBoardScreenViewModel) {
    return Container(
      width: 150,
      //color: Colors.white,
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          Positioned(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                              "assets/png/crown.png"))),
                ),
                SizedBox(height: 8),
                Container(
                  height: 150,
                  width: 150,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xffeb3c00),
                  ),
                  child: _buildWinnerAvatar(weeklyQuizLeaderBoardScreenViewModel.highestScoreParticipant),
                ),
                SizedBox(height: 5),
                AppText.heading6M("${weeklyQuizLeaderBoardScreenViewModel.highestScoreParticipant!=null?"@${weeklyQuizLeaderBoardScreenViewModel.highestScoreParticipant!.username}":"?"}",
                  color: Color(0xffffffff),
                ),
                SizedBox(height: 3),
                AppText.captionText(
                  "Score: ${weeklyQuizLeaderBoardScreenViewModel.highestScoreParticipant!=null?weeklyQuizLeaderBoardScreenViewModel.highestScoreParticipant!.score:"?"}",
                  color: Color(0xffffffff),
                ),
              ],
            ),
          ),
          Positioned(
            left: -90,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 25,),
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: AssetImage("assets/png/2.png"))),
                ),
                Container(
                  height: 120,
                  width: 120,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xffeb3c00),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: _buildOtherWinnerAvatar(weeklyQuizLeaderBoardScreenViewModel.secondHighestScoreParticipant),
                  ),
                ),
                SizedBox(height: 3),
                AppText.heading6M("${weeklyQuizLeaderBoardScreenViewModel.secondHighestScoreParticipant!=null?"@"+weeklyQuizLeaderBoardScreenViewModel.secondHighestScoreParticipant!.username:"?"}",
                  color: Color(0xffffffff),
                ),
                SizedBox(height: 3),
                AppText.captionText(
                  "Score: ${weeklyQuizLeaderBoardScreenViewModel.secondHighestScoreParticipant!=null?weeklyQuizLeaderBoardScreenViewModel.secondHighestScoreParticipant!.score:"?"}",
                  color: Color(0xffffffff),
                ),
              ],
            ),
          ),
          Positioned(
            right: -90,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 25),
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/png/3.png"))),
                ),
                Container(
                  height: 120,
                  width: 120,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xffeb3c00),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: _buildOtherWinnerAvatar(weeklyQuizLeaderBoardScreenViewModel.thirdHighestScoreParticipant),
                  ),
                ),
                SizedBox(height: 3),
                AppText.heading6M("${weeklyQuizLeaderBoardScreenViewModel.thirdHighestScoreParticipant!=null?weeklyQuizLeaderBoardScreenViewModel.thirdHighestScoreParticipant!.username:"?"}",
                  color: Color(0xffffffff),
                ),
                SizedBox(height: 3),
                AppText.captionText(
                  "Score: ${weeklyQuizLeaderBoardScreenViewModel.thirdHighestScoreParticipant!=null?weeklyQuizLeaderBoardScreenViewModel.thirdHighestScoreParticipant!.score:"?"}",
                  color: Color(0xffffffff),
                ),
              ],
            ),
          ),
        ],
      ),
    );
 }

  Widget _buildWinnerAvatar(WeeklyQuizParticipant? highestScoreParticipant) {
    if(highestScoreParticipant==null){
      return CircleAvatar(
        child: Icon(Icons.query_builder_rounded),
      );
    }
    if(highestScoreParticipant.photo.isEmpty){
      return CircleAvatar(
        child: Icon(Icons.account_circle_rounded),
      );
    }
    return CircleAvatar(
      backgroundImage: NetworkImage("$BASE_URL/${highestScoreParticipant.photo}"),
    );
  }

Widget  _buildOtherWinnerAvatar(WeeklyQuizParticipant? otherParticipant) {
  if(otherParticipant==null){
    return CircleAvatar(
      child: Icon(Icons.query_builder_rounded),
    );
  }
  if(otherParticipant.photo.isEmpty){
    return CircleAvatar(
      child: Icon(Icons.account_circle_rounded),
    );
  }
  return CircleAvatar(
    backgroundImage: NetworkImage("$BASE_URL/${otherParticipant.photo}"),
  );
}


}

// Container(
//   height: 108,
//   width: 340,
//   decoration: BoxDecoration(
//       borderRadius: BorderRadius.circular(10),
//       image: DecorationImage(
//           image: AssetImage("assets/png/abeg_icon.png"))),
// ),