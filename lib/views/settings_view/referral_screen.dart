import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:prep50/utils/color.dart';
import 'package:prep50/utils/text.dart';
import 'package:prep50/widgets/app_back_icon.dart';

class ReferralView extends StatelessWidget {
  // const ReferralView({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              color: Color(0xffffffff),
              child: SafeArea(
                bottom: false,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 13.5),
                  child: Row(
                    children: [
                      AppBackIcon(),
                      SizedBox(
                        width: 24,
                      ),
                      AppText.heading6S("Refer"),
                    ],
                  ),
                ),
              ),
            ),
            AppText.heading6M("Refer to a friend 😇"),
            AppText.captionText("let’s get them onboard immediately"),
            SizedBox(height: 20),
            Center(
              child: Container(
                // padding: EdgeInsets.all(20),
                width: double.infinity,
                child: Image.asset(
                  "assets/png/referal_card.png",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Icon(Icons.info_outline, color: kPrimaryColor),
                SizedBox(width: 10),
                AppText.heading6M("How our referral bonus works",
                    color: kPrimaryColor),
              ],
            ),
            SizedBox(height: 20),
            indicator(
              1,
              title: "Invite your friends",
              subtitle: "You just need to copy and share the link",
            ),
            indicator(
              2,
              title: "They subscribe to our yearly plan",
              subtitle: "Just with #2000",
            ),
            indicator(
              3,
              title: "You get you artime splash",
              subtitle: "Then we send you your airtime immediately🎉",
            )
          ],
        ),
      ),
    );
  }

  Widget indicator(int count, {String? title, String? subtitle}) {
    return Container(
      height: 70,
      child: Row(
        children: [
          Column(
            children: [
              ClipOval(
                child: Container(
                  width: 30,
                  height: 30,
                  color: Colors.white,
                  child: Center(child: AppText.textField("$count")),
                ),
              ),
              SvgPicture.asset(
                "assets/svg/line.svg",
                height: 40,
              )
            ],
          ),
          SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText.captionText("$title"),
              SizedBox(height: 10),
              AppText.captionText(
                "$subtitle",
                color: kMidBlackColor,
              ),
            ],
          )
        ],
      ),
    );
  }
}
