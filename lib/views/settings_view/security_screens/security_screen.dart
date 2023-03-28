import 'package:flutter/material.dart';
import 'package:prep50/utils/color.dart';
import 'package:prep50/utils/text.dart';
import 'package:prep50/widgets/app_back_icon.dart';

class SecurityScreen extends StatelessWidget {
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
                      AppText.heading6S("Security and Privacy"),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            component(
              icon: Icons.lock,
              title: "Password",
              subtitle: "Setup a strong password for your login",
            ),
            SizedBox(height: 10),
            component(
              icon: Icons.fingerprint,
              title: "Fingerprint Id",
              subtitle: "Enhance your security lock",
            ),
            SizedBox(height: 10),
            component(
              icon: Icons.visibility,
              title: "Show password",
              subtitle: "Display characters briefly as you type",
            ),
            SizedBox(height: 10),
            component(
              icon: Icons.smart_button_rounded,
              title: "Smart lock",
              subtitle: "Automatically lock my app if dormant",
            ),
          ],
        ),
      ),
    );
  }

  Widget component({IconData? icon, String? title, String? subtitle}) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                  color: kErrorLightColor,
                  borderRadius: BorderRadius.circular(8)),
              child: Icon(
                icon,
                color: kErrorColor,
              ),
            ),
            SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText.heading6S(
                  "$title",
                  color: kBlackColor,
                ),
                SizedBox(height: 2),
                AppText.captionText(
                  "$subtitle",
                  color: kMidGreyColor,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
