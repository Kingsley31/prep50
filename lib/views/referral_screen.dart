import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import 'package:prep50/utils/color.dart';
import 'package:prep50/utils/text.dart';

import 'package:prep50/widgets/app_back_icon.dart';
import 'package:prep50/widgets/app_button.dart';
import 'package:prep50/widgets/app_toast.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';


import '../view-models/referral_screen_viewmodel.dart';

class ReferralScreen extends StatefulWidget {
  @override
  State<ReferralScreen> createState() => _ReferralScreenState();
}

class _ReferralScreenState extends State<ReferralScreen> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ReferralScreenViewModel referralScreenViewModel= Provider.of<ReferralScreenViewModel>(context,listen:false);
      referralScreenViewModel.loadReferralLink();

    });
  }

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
              title: "You get you airtime splash",
              subtitle: "Then we send you your airtime immediately🎉",
            ),
            Spacer(),
            Consumer<ReferralScreenViewModel>(
                builder: (context,referralScreenViewModel,child) {
                  if(referralScreenViewModel.errorMessage.isEmpty && referralScreenViewModel.isLoadingLink==false){
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
                                  "${referralScreenViewModel.referralLink}",
                                  color: kPrimaryColor,
                                ),
                              ),
                              SizedBox(width: 5,),
                              GestureDetector(
                                onTap: ()async{
                                  await Clipboard.setData(ClipboardData(text: "${referralScreenViewModel.referralLink}"));
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
                            Share.share("Hi, join me to prepare for POST-UTME exams on prep50 using the link below \n\n${referralScreenViewModel.referralLink}", subject: 'Share Referral Link');
                          },
                        ),
                      ],
                    );
                  }

                  if(referralScreenViewModel.errorMessage.isNotEmpty){
                    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                      final AppToast appToast = AppToast(context: context);
                      appToast.showToast(message: referralScreenViewModel.errorMessage);
                    });

                    print(referralScreenViewModel.errorMessage);
                    return Center(
                      child: AppButton(
                        title: "Load Referral",
                        width: 197,
                        color: true,
                        onTap: () => {
                          referralScreenViewModel.loadReferralLink()
                        },
                      ),
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
