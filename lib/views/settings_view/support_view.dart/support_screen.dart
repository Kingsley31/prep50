import 'package:flutter/material.dart';
import 'package:prep50/utils/color.dart';
import 'package:prep50/utils/text.dart';
import 'package:prep50/views/settings_view/support_view.dart/faq.dart';
import 'package:prep50/widgets/app_back_icon.dart';

class SupportScreen extends StatelessWidget {
  // const SupportScreen({ Key key }) : super(key: key);

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
                .push(MaterialPageRoute(builder: (context) => Faq())),
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
                        Icons.fastfood_outlined,
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
                          "Automatically lock up my app if dormant",
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
                      Icons.fastfood_outlined,
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
                        "+234 806 337 8105",
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
                      Icons.fastfood_outlined,
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
                        "deaconscbt@gmail.com",
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
                      Icons.fastfood_outlined,
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
                        "Prep50.ng",
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
                      Icons.fastfood_outlined,
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
                        "Basicilica the most holy trinity",
                        color: kMidGreyColor,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
