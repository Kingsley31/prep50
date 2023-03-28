import 'package:flutter/material.dart';

import 'components/onboarding_card.dart';

class OnBoardingScreen extends StatelessWidget {
  // const OnBoardingScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OnboardingCard(),
    );
  }
}
