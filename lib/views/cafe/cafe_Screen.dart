import 'package:flutter/material.dart';
import 'package:prep50/utils/color.dart';
import 'package:prep50/utils/preps_icons_icons.dart';
import 'package:prep50/utils/text.dart';
import 'package:prep50/views/support_view.dart/faq_screen.dart';

class CafeScreen extends StatelessWidget {
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
              child: Padding(
                padding: const EdgeInsets.all(13.5),
                child: AppText.heading6S("Cafe Service"),
              ),
            ),
          ),

          // Spacer(),
          SizedBox(height: 20),
          component(
            context,
            title: "JAMB Exam Results",
            subtitle: "Check your jamb cbt results in few clicks ",
            iconColor: Colors.amber.shade900,
            icon: PrepsIcons.tutorial,
          ),
          SizedBox(height: 10),
          component(
            context,
            title: "O’Level Result Uplodaing",
            subtitle: "Upload your o’level result seamlessly",
            iconColor: Colors.blue.shade600,
            icon: Icons.present_to_all,
          ),
          SizedBox(height: 10),
          component(
            context,
            title: "Post-UTME Registrations",
            subtitle: "Register for post-utme",
            iconColor: Colors.pink.shade500,
            icon: Icons.note_add_outlined,
          ),
          SizedBox(height: 10),
          component(
            context,
            title: "Admission Tracking",
            subtitle: "Track all your admissions",
            iconColor: Colors.amber.shade800,
            icon: Icons.add_road_sharp,
          ),
          SizedBox(height: 10),
          component(
            context,
            title: "Re-printing of exam slips",
            subtitle: "Check your jamb cbt results in few clicks ",
            iconColor: Colors.orange.shade900,
            icon: Icons.print,
          ),
        ],
      ),
    );
  }

  Widget component(
    BuildContext context, {
    IconData? icon,
    Color? iconColor,
    String? title,
    String? subtitle,
  }) {
    return GestureDetector(
      onTap: () => Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => FaqScreen())),
      child: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                    color: iconColor ?? kErrorLightColor,
                    borderRadius: BorderRadius.circular(8)),
                child: Icon(
                  icon ?? Icons.fastfood_outlined,
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText.heading6S(
                    title,
                    color: kBlackColor,
                  ),
                  SizedBox(height: 2),
                  AppText.captionText(
                    "$subtitle",
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
    );
  }
}
