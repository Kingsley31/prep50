import 'package:flutter/material.dart';

import '../../utils/deeplink_utils.dart';
import 'components/onboarding_card.dart';

class OnBoardingScreen extends StatelessWidget {
  // const OnBoardingScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      loadInitiallyReceivedLink(context);
      listenForDeepLinkEvent(context);
    });
    return Scaffold(
      body: OnboardingCard(),
    );
  }
}
