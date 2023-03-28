import 'package:flutter/material.dart';
import 'package:prep50/utils/color.dart';
import 'package:prep50/utils/text.dart';
import 'package:prep50/widgets/app_back_icon.dart';
import 'package:prep50/widgets/app_button.dart';
import 'package:prep50/widgets/app_text_field.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
                    AppText.heading6S("Profile Settings"),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(0),
              children: [
                SizedBox(height: 20),
                Center(
                  child: SizedBox(
                    height: 100,
                    width: 100,
                    child: Stack(
                      children: [
                        ClipOval(
                          child: Container(
                            height: 100,
                            width: 100,
                            child: Image.asset(
                              "assets/image/img1.jpg",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: ClipOval(
                            child: Container(
                              height: 40,
                              width: 40,
                              color: Colors.white,
                              child: Center(
                                child: ClipOval(
                                  child: Container(
                                    height: 32,
                                    width: 32,
                                    color: kPrimaryColor,
                                    child: Icon(
                                      Icons.camera_alt,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                component(title: "Username", hint: "Blazers"),
                component(title: "Email", hint: "#Stephenstanzy2021Prepright#"),
                component(title: "Phone Number", hint: "07041524690"),
                component(title: "Address", hint: "Enter your address"),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: AppText.heading6("Gender"),
                ),
                SizedBox(height: 6),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(10),
                          color: Colors.white,
                          child: Row(
                            children: [
                              AppText.captionText(
                                "Male",
                                color: kMidBlackColor,
                              ),
                              Spacer(),
                              Radio(
                                  value: "21",
                                  groupValue: "3",
                                  onChanged: (dynamic v) {})
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(10),
                          color: Colors.white,
                          child: Row(
                            children: [
                              AppText.captionText(
                                "Female",
                                color: kMidBlackColor,
                              ),
                              Spacer(),
                              Radio(
                                value: "21",
                                groupValue: "3",
                                onChanged: (dynamic v) {},
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Center(
                  child: AppButton(
                    title: "Save",
                    color: true,
                    width: 197,
                  ),
                ),
                SizedBox(
                  height: 60,
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget component({
    String? title,
    String? hint,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText.heading6("$title"),
          SizedBox(height: 6),
          AppTextField(
            hText: "$hint",
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
