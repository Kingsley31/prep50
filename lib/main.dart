

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_session_timeout/local_session_timeout.dart';
import 'package:prep50/utils/color.dart';
import 'package:prep50/utils/pushnotification_utils.dart';
import 'package:prep50/view-models/change_password_screen_viewmodel.dart';
import 'package:prep50/view-models/create_account_screen_viewmodel.dart';
import 'package:prep50/view-models/edit_profile_screen_viewmodel.dart';
import 'package:prep50/view-models/examboard_bottom_sheet_viewmodel.dart';
import 'package:prep50/view-models/faq_screen_viewmodel.dart';
import 'package:prep50/view-models/home_screen_view_model.dart';
import 'package:prep50/view-models/join_quiz_screen_viewmodel.dart';
import 'package:prep50/view-models/login_screen_viewmodel.dart';
import 'package:prep50/view-models/news_feed_list_screen_viewmodel.dart';
import 'package:prep50/view-models/notifications_screen_viewmodel.dart';
import 'package:prep50/view-models/password_reset_screen_viewmodel.dart';
import 'package:prep50/view-models/payment_screen_viewmodel.dart';
import 'package:prep50/view-models/podcast_screen_viewmodel.dart';
import 'package:prep50/view-models/podcast_topic_screen_viewmodel.dart';
import 'package:prep50/view-models/prep-study-subjects-viewmodel.dart';
import 'package:prep50/view-models/quiz-question-screen-viewmodel.dart';
import 'package:prep50/view-models/referral_screen_viewmodel.dart';
import 'package:prep50/view-models/report_screen_viewmodel.dart';
import 'package:prep50/view-models/security_and_privacy_screen_viewmodel.dart';
import 'package:prep50/view-models/single_feed_screen_viewmodel.dart';
import 'package:prep50/view-models/study-screen-viewmodel.dart';
import 'package:prep50/view-models/subject_reselection_screen_viewmodel.dart';
import 'package:prep50/view-models/subscription_screen_viewmodel.dart';
import 'package:prep50/view-models/support_screen_viewmodel.dart';
import 'package:prep50/view-models/terms_of_service_screen_viewmodel.dart';
import 'package:prep50/view-models/topic_screen_viewmodel.dart';
import 'package:prep50/view-models/weekly_quiz_leader_board_screen_viewmodel.dart';
import 'package:prep50/view-models/weekly_quiz_question_screen_viewmodel.dart';
import 'package:prep50/view-models/welcome-screen-viewmodel.dart';
import 'package:prep50/view-models/info-screen-view-model.dart';
import 'package:prep50/views/Notification_view/notification_screen.dart';
import 'package:prep50/views/authentication_view/login_screen.dart';
import 'package:prep50/views/onboarding%20view/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  runApp(
      MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => InfoScreenViewModel()),
            ChangeNotifierProvider(create: (context) => CreateAccountViewModel()),
            ChangeNotifierProvider(create: (context) => WelcomeScreenViewModel()),
            ChangeNotifierProvider(create: (create) => LoginScreenViewModel()),
            ChangeNotifierProvider(create: (create) => HomeScreenViewModel()),
            ChangeNotifierProvider(create: (create) => PasswordResetScreenViewModel()),
            ChangeNotifierProvider(create: (create) => PrepStudySubjectsViewModel()),
            ChangeNotifierProvider(create: (create) => TopicScreenViewModel()),
            ChangeNotifierProvider(create: (create) => StudyScreenViewModel()),
            ChangeNotifierProvider(create: (create) => QuizQuestionScreenViewModel()),
            ChangeNotifierProvider(create: (create) => PodcastTopicScreenViewModel()),
            ChangeNotifierProvider(create: (create) => PodcastScreenViewModel()),
            ChangeNotifierProvider(create: (create) => JoinQuizScreenViewModel()),
            ChangeNotifierProvider(create: (create) => WeeklyQuizQuestionScreenViewModel()),
            ChangeNotifierProvider(create: (create) => WeeklyQuizLeaderBoardScreenViewModel()),
            ChangeNotifierProvider(create: (create) => NewsFeedListScreenViewModel()),
            ChangeNotifierProvider(create: (create) => ReportScreenViewModel()),
            ChangeNotifierProvider(create: (create) => SingleFeedScreenViewModel()),
            ChangeNotifierProvider(create: (create)=> NotificationsScreenViewModel()),
            ChangeNotifierProvider(create: (create)=> EditProfileScreenViewModel()),
            ChangeNotifierProvider(create: (create)=> SupportScreenViewModel()),
            ChangeNotifierProvider(create: (create) => FaqScreenViewModel()),
            ChangeNotifierProvider(create: (create)=>TermsOfServiceScreenViewModel()),
            ChangeNotifierProvider(create: (create)=>SubjectReselectionScreenViewModel()),
            ChangeNotifierProvider(create: (create)=> SecurityAndPrivacyScreenViewModel()),
            ChangeNotifierProvider(create: (create)=>ChangePasswordScreenViewModel()),
            ChangeNotifierProvider(create: (create) => ExamBoardBottomSheetViewModel()),
            ChangeNotifierProvider(create: (create)=>ReferralScreenViewModel()),
            ChangeNotifierProvider(create: (create) => SubscriptionScreenViewModel()),
            ChangeNotifierProvider(create: (create) => PaymentScreenViewModel())
          ],
          child: MyApp()
      )
  );
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final sessionConfig = SessionConfig(
      invalidateSessionForAppLostFocus: const Duration(seconds: 15),
      invalidateSessionForUserInactivity: const Duration(seconds: 30));

  Future<void> setupInteractedMessage(context) async {
    // Get any messages which caused the application to open from
    // a terminated state.
    RemoteMessage? initialMessage =
    await FirebaseMessaging.instance.getInitialMessage();

    // If the message also contains a data property with a "type" of "chat",
    // navigate to a chat screen
    if (initialMessage != null) {
      _handleMessage(initialMessage,context);
    }

    // Also handle any interaction when the app is in the background via a
    // Stream listener
    FirebaseMessaging.onMessageOpenedApp.listen((message){
      _handleMessage(message,context);
    });
  }

  void _handleMessage(RemoteMessage message,context) {
    Navigator.push(context, MaterialPageRoute(builder: (context)=> NotificationScreen()));
  }

  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp)async {
      await setupInteractedMessage(context);
      requestPushNotificationPermissionOnIos();
      _listenForSessionTimeOut(context);
      listenForForegroundFcmMessages();
    });
    return SessionTimeoutManager(
      sessionConfig: sessionConfig,
      child: MaterialApp(
        title: 'Prep50',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: kPrimaryColor,
          // This makes the visual density adapt to the platform that you run
          // the app on. For desktop platforms, the controls will be smaller and
          // closer together (more dense) than on mobile platforms.
          visualDensity: VisualDensity.adaptivePlatformDensity,
          appBarTheme: AppBarTheme(
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: kPrimaryColor
            )
          )
        ),
        home: SplashScreen(),
      ),
    );
  }

  void _listenForSessionTimeOut(context) async{
    SecurityAndPrivacyScreenViewModel securityAndPrivacyScreenViewModel=Provider.of<SecurityAndPrivacyScreenViewModel>(context,listen: false);
    HomeScreenViewModel homeScreenViewModel = Provider.of<HomeScreenViewModel>(context,listen: false);
    bool userIsLoggedIn =  await homeScreenViewModel.userIsLoggedIn;
    if(userIsLoggedIn==false) return;
    bool smartLockEnabled = await securityAndPrivacyScreenViewModel.getSmartLockEnable();
    if(smartLockEnabled==false) return;
    sessionConfig.stream.listen((SessionTimeoutState timeoutEvent)async {
      if (timeoutEvent == SessionTimeoutState.userInactivityTimeout) {
        try{
          await homeScreenViewModel.logoutUser();
          Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (context) => LoginScreen()));
        }catch(e){}

      } else if (timeoutEvent == SessionTimeoutState.appFocusTimeout) {
        try{
          await homeScreenViewModel.logoutUser();
          Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (context) => LoginScreen()));
        }catch(e){}
      }
    });
  }


}

