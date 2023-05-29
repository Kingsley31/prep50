import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:prep50/utils/color.dart';
import 'package:prep50/utils/text.dart';
import 'package:prep50/views/authentication_view/create_account_screen.dart';
import 'package:prep50/views/authentication_view/login_screen.dart';
import 'package:prep50/widgets/app_button.dart';

import '../../authentication_view/info_screen.dart';

class OnboardingCard extends StatelessWidget {
  // const OnboardingCard({ Key? key }) : super(key: key);
  final CarouselController _controller = CarouselController();
  final List<String> texts = [
    "Get authenthic informations about the educational system in Nigeria, & enjoy our cafe services just with few clicks.",
    "You can now practice your past questions with our CBT Emulator and also get a weekly quiz with giveaways",
    "Tutorials have been made easy for you that you can now listen to them why you have all times to do whatever that is desired.",
    "Your subject studies are now segemented and organised that you can read and asnwer qucik questions at your comfort. "
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          CarouselSlider.builder(
            carouselController: _controller,
            itemCount: 4,
            options: CarouselOptions(
              autoPlay: true,
              height: MediaQuery.of(context).size.height,
              viewportFraction: 1,
            ),
            itemBuilder:
                (BuildContext context, int itemIndex, int pageViewIndex) =>
                    Container(
              // height: double.infinity,
              // width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage("assets/image/img${itemIndex + 1}.jpg"),
                ),
              ),
            ),
          ),
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              // color: Color(0xff000000).withOpacity(0.3),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.transparent,
                  Colors.transparent,
                  Colors.transparent,
                  Colors.black,
                  Colors.black,
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 15,
            right: 15,
            child: SafeArea(
              // height: 465,
              child: Column(
                children: [
                  // SizedBox(height: 188),

                  CarouselSlider.builder(
                    itemCount: 4,
                    options: CarouselOptions(
                      autoPlay: true,
                      height: 70,
                      // autoPlayAnimationDuration: Duration(seconds: 4),
                      viewportFraction: 1,

                      autoPlayCurve: Curves.fastOutSlowIn,
                    ),
                    itemBuilder: (BuildContext context, int itemIndex,
                            int pageViewIndex) =>
                        Container(
                      alignment: Alignment.bottomCenter,
                      child: AppText.textFieldM(
                        texts[itemIndex],
                        color: Color(0xffffffff),
                        multiText: true,
                        centered: true,
                      ),
                    ),
                  ),
                  SizedBox(height: 38),
                  Container(
                    // color: Colors.red,
                    height: 70,
                    child: AppButton(
                      color: true,
                      title: "Create account",
                      onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => CreateAccount())
                          // MaterialPageRoute(
                          // builder: (context) => InfoScreen())
                      ),
                      // width: 343,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    height: 70,
                    child: AppButtonMain(
                      color: Colors.white,
                      textColor: kPrimaryColor,
                      title: "Login",
                      onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => LoginScreen())),
                      // width: 343,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
