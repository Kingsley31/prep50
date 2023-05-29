import 'package:flutter/material.dart';
import 'package:prep50/utils/color.dart';
import 'package:prep50/utils/custom_transition.dart';
import 'package:prep50/utils/text.dart';
import 'package:prep50/views/onboarding%20view/onboarding_screen.dart';

import '../../utils/deeplink_utils.dart';

class SplashScreen extends StatefulWidget {
  // const OnBoardingScreen({ Key? key }) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 3), () {
      Navigator.of(context)
          .pushReplacement(CustomPageRoute(OnBoardingScreen()));
    });
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp)async {
    //   await loadInitiallyReceivedLink(context);
    //   listenForDeepLinkEvent(context);
    //
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/image/logo.png"),
                  SizedBox(
                    height: 8,
                  ),
                  AppText.heading6(
                    "...leading you through!",
                    color: kPrimaryColor,
                  ),
                ],
              ),
            ),
            AppText.captionText("Version 2.1"),
            SizedBox(
              height: 8,
            ),
            SafeArea(top: false, child: AppText.captionTextS("2023"))
          ],
        ),
      ),
    );
  }
}
