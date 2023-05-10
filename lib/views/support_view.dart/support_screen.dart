import 'package:flutter/material.dart';
import 'package:prep50/utils/color.dart';
import 'package:prep50/utils/text.dart';
import 'package:prep50/widgets/app_back_icon.dart';
import 'package:prep50/widgets/app_toast.dart';
import 'package:provider/provider.dart';

import '../../view-models/support_screen_viewmodel.dart';
import '../../widgets/app_button.dart';
import 'faq_screen.dart';

class SupportScreen extends StatefulWidget {
  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  AppToast? appToast;

  @override
  void initState() {
    super.initState();
    appToast=AppToast(context: context);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      SupportScreenViewModel supportScreenViewModel = Provider.of<SupportScreenViewModel>(context,listen: false);
      supportScreenViewModel.loadSupportContact();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kLightGreyShadeColour,
      body: Column(
        children: [
          Container(
            width: double.infinity,
            color: Color(0xffffffff),
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.all(13.5),
                child: Row(
                  children: [
                    AppBackIcon(),
                    SizedBox(
                      width: 24,
                    ),
                    AppText.heading6S("Support"),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 25),
          Container(
            height: 254,
            // width: 254,
            decoration: BoxDecoration(
                // borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                    image: AssetImage("assets/png/support_img.png"))),
          ),
          // Spacer(),
          SizedBox(height: 20),
          GestureDetector(
            onTap: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => FaqScreen())),
            child: Container(
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
                        Icons.help,
                        color: kErrorColor,
                      ),
                    ),
                    SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText.heading6S(
                          "FAQ",
                          color: kBlackColor,
                        ),
                        SizedBox(height: 2),
                        AppText.captionText(
                          "See frequently asked questions",
                          color: kMidGreyColor,
                        ),
                      ],
                    ),
                    Spacer(),
                    Icon(
                      Icons.arrow_forward_ios_outlined,
                      size: 15,
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 8),
          Consumer<SupportScreenViewModel>(
              builder: (context,supportScreenViewModel,child){
                return supportScreenViewModel.errorMessage.isNotEmpty?
                    _buildErrorWidget(supportScreenViewModel):supportScreenViewModel.isLoadingSupportContact?
                    _buildLoadingWidget():_buildSupportContact(supportScreenViewModel);
              }
          ),
        ],
      )
    );
  }

 Widget _buildLoadingWidget() {
    return Center(
      child: SizedBox(
        width: 30,
        height: 30,
        child: CircularProgressIndicator(),
      ),
    );
 }

 Widget _buildSupportContact(SupportScreenViewModel supportScreenViewModel) {
    return Column(
      children: [
        Container(
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
                    Icons.dialer_sip,
                    color: kErrorColor,
                  ),
                ),
                SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText.heading6S(
                      "Contact",
                      color: kBlackColor,
                    ),
                    SizedBox(height: 2),
                    AppText.captionText(
                      "${supportScreenViewModel.supportContact.phone}",
                      color: kMidGreyColor,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 8),
        Container(
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
                    Icons.email,
                    color: kErrorColor,
                  ),
                ),
                SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText.heading6S(
                      "Email Address",
                      color: kBlackColor,
                    ),
                    SizedBox(height: 2),
                    AppText.captionText(
                      "${supportScreenViewModel.supportContact.email}",
                      color: kMidGreyColor,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 8),
        Container(
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
                    Icons.laptop,
                    color: kErrorColor,
                  ),
                ),
                SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText.heading6S(
                      "Website",
                      color: kBlackColor,
                    ),
                    SizedBox(height: 2),
                    AppText.captionText(
                      "${supportScreenViewModel.supportContact.website}",
                      color: kMidGreyColor,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 8),
        Container(
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
                    Icons.location_on,
                    color: kErrorColor,
                  ),
                ),
                SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText.heading6S(
                      "Location",
                      color: kBlackColor,
                    ),
                    SizedBox(height: 2),
                    AppText.captionText(
                      "${supportScreenViewModel.supportContact.location}",
                      color: kMidGreyColor,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

 Widget _buildErrorWidget(SupportScreenViewModel supportScreenViewModel) {
   WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
     appToast?.showToast(message: supportScreenViewModel.errorMessage);
   });

   print(supportScreenViewModel.errorMessage);
   return Center(
     child: AppButton(
       title: "Load Support Contact Details",
       width: 197,
       color: true,
       onTap: () => {
         supportScreenViewModel.loadSupportContact()
       },
     ),
   );
 }


}
