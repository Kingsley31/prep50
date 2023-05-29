
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:prep50/utils/color.dart';
import 'package:prep50/utils/exceptions.dart';
import 'package:prep50/utils/preps_icons_icons.dart';
import 'package:prep50/views/authentication_view/login_screen.dart';
import 'package:prep50/views/cafe/cafe_Screen.dart';
import 'package:provider/provider.dart';

import '../../view-models/home_screen_view_model.dart';
import '../mock_exam/mock_exam_screen.dart';
import '../prep_study_view/tutorial_view/prep_study_screen.dart';
import '../weekly_quiz/join_quiz_screen.dart';
import 'components/logout_dialog.dart';
import 'home_screen.dart';

class HomeView extends StatefulWidget {
  static String routeName = "/home";
  // const HomeView({ Key key }) : super(key: key);

  @override
  State<HomeView> createState() => HomeViewState();
}

class HomeViewState extends State<HomeView>{
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      onAuthenticationStateChange();
      onFcmTokenChange();
    });

  }

  List<Widget> _buildScreens() {
    return [
      HomeScreen(),
      MockExamScreen(),
      CafeScreen(),
      // HomeCard(),
      JoinQuizScreen(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(
          PrepsIcons.fire,
          size: 20,
        ),
        title: ("Feeds"),
        activeColorPrimary: kPrimaryColor,
        inactiveColorPrimary: kAccentColor,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(
          PrepsIcons.tutorial,
          size: 20,
        ),
        title: ("Exam"),
        activeColorPrimary: kPrimaryColor,
        inactiveColorPrimary: kAccentColor,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(
          PrepsIcons.education,
          size: 20,
        ),
        title: ("Cafe"),
        activeColorPrimary: kPrimaryColor,
        inactiveColorPrimary: kMidGreyColor,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(
          PrepsIcons.timer,
          size: 20,
        ),
        title: ("Quiz"),
        activeColorPrimary: kPrimaryColor,
        inactiveColorPrimary: kAccentColor,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        final bool logout = await LogoutDialog.show(context)??false;
        if(logout){
          HomeScreenViewModel homeScreenViewModel = Provider.of<HomeScreenViewModel>(context, listen: false);
          try{
            await homeScreenViewModel.logoutUser(disableSettings: true);
            //Navigator.pop(context);
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginScreen()));
          }catch(e){}
        }
        return false;
      },
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 50.0),
          child: FloatingActionButton(
              onPressed: () {
                PersistentNavBarNavigator.pushNewScreen(
                  context,
                  screen: PrepStudyScreen(),
                  withNavBar: true, // OPTIONAL VALUE. True by default.
                );

              },
              backgroundColor: Color(0xffffffff),
              child: Icon(
                PrepsIcons.bookmark,
                color: kPrimaryColor,
              )),
        ),
        body: PersistentTabView(
          context,
          // controller: _controller,
          screens: _buildScreens(),
          items: _navBarsItems(),
          confineInSafeArea: true,
          backgroundColor: Colors.white, // Default is Colors.white.
          handleAndroidBackButtonPress: true, // Default is true.
          resizeToAvoidBottomInset:
              true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
          stateManagement: true, // Default is true.
          hideNavigationBarWhenKeyboardShows:
              true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
          decoration: NavBarDecoration(
            borderRadius: BorderRadius.circular(10.0),
            colorBehindNavBar: Colors.white,
          ),
          popAllScreensOnTapOfSelectedTab: true,
          popActionScreens: PopActionScreensType.all,
          itemAnimationProperties: ItemAnimationProperties(
            // Navigation Bar's items animation properties.
            duration: Duration(milliseconds: 200),
            curve: Curves.ease,
          ),
          screenTransitionAnimation: ScreenTransitionAnimation(
            // Screen transition animation on change of selected tab.
            animateTabTransition: true,
            curve: Curves.ease,
            duration: Duration(milliseconds: 200),
          ),
          navBarStyle:
              NavBarStyle.style1, // Choose the nav bar style with this property
        ),
      ),
    );
  }

  void onAuthenticationStateChange()async{
    HomeScreenViewModel homeScreenViewModel = Provider.of<HomeScreenViewModel>(context,listen: false);
    homeScreenViewModel.addListener(() async{
      bool userIsLoggedIn = await homeScreenViewModel.userIsLoggedIn;
      if(userIsLoggedIn==false){
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginScreen()));
      }
    });

  }

  void onFcmTokenChange(){
    FirebaseMessaging.instance.onTokenRefresh
        .listen((fcmToken) async{
      HomeScreenViewModel homeScreenViewModel = Provider.of<HomeScreenViewModel>(context,listen: false);
      try{
        await homeScreenViewModel.registerFcmToken(fcmToken);
      }on LoginException catch(e){}catch(e){}
    });
  }
}
