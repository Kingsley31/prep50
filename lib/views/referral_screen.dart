import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:prep50/constants/string_data.dart';
import 'package:prep50/utils/color.dart';
import 'package:prep50/utils/text.dart';
import 'package:prep50/view-models/home_screen_view_model.dart';
import 'package:prep50/widgets/app_back_icon.dart';
import 'package:prep50/widgets/app_button.dart';
import 'package:prep50/widgets/app_toast.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../models/user.dart';

class ReferralScreen extends StatelessWidget {
  // const ReferralView({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeScreenViewModel homeScreenViewModel= Provider.of<HomeScreenViewModel>(context,listen:false);
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
            SizedBox(height: 10,),
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
            ),
            Spacer(),
            FutureBuilder<User>(
                future: homeScreenViewModel.getLoggedInUser(),
                builder: (context,snapshot) {
                  if(snapshot.hasData && snapshot.data!=null){
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 15,top: 2,bottom: 2,right: 2),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: AppText.textField(
                                  "$BASE_URL/create-account?referer=${snapshot.data?.username}",
                                  color: kPrimaryColor,
                                ),
                              ),
                              SizedBox(width: 5,),
                              GestureDetector(
                                onTap: ()async{
                                  await Clipboard.setData(ClipboardData(text: "$BASE_URL/create-account?referer=${snapshot.data?.username}"));
                                  final AppToast appToast = AppToast(context: context);
                                  appToast.showToast(message: "Copied!");
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                                  decoration: BoxDecoration(
                                    color: kPrimaryColor[300],
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: AppText.textFieldM(
                                    "Copy",
                                    color: kPrimaryColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20,),
                        AppButton(
                          title: "Share  Link",
                          color: true,
                          onTap: (){
                            Share.share("Hi, join me to prepare for POST-UTME exams on prep50 using the link below \n\n$BASE_URL/create-account?referer=${snapshot.data?.username}", subject: 'Share Referral Link');
                          },
                        ),
                      ],
                    );
                  }
                  return Center(
                    child: SizedBox(
                      height: 20.0,
                      width: 20.0,
                      child: CircularProgressIndicator(
                        color: kPrimaryColor,
                      ),
                    ),
                  );
                }
            ),

          ],
        ),
      ),
    );
  }

  Widget indicator(int count, {String? title, String? subtitle}) {
    return Container(
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
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText.captionText("$title"),
                SizedBox(height: 10),
                AppText.captionText(
                  "$subtitle",
                  color: kMidBlackColor,
                  multiText: true,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
