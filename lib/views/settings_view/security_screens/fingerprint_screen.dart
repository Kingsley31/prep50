import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:prep50/utils/text.dart';
import 'package:prep50/widgets/app_button.dart';
import 'package:prep50/widgets/app_text_field.dart';

class FingerPrint extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffF7F7F7),
        body: Column(children: [
          Container(
            height: 92,
            width: double.infinity,
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  // mainAxisAlignment:MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 22,
                        width: 22,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xffFF4201),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                            size: 10,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 17),
                    AppText.heading6S("Fingerprint and Biometrics"),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 32,
          ),
          Container(
            height: 300,
            width: 300,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xffFFFFFF),
            ),
            child: (Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.fingerprint_outlined,
                  size: 240,
                  color: Color(0xffADADAD),
                ),
                SizedBox(
                  height: 23.67,
                ),
                AppText.textField("Fingerprint")
              ],
            )),
          ),
          SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 80),
            child: AppText.textField(
              "Setup your fingerprint biometrics for Prep50 login when you want to use our app "
              "as you as well increase your security setup",
              centered: true,
              multiText: true,
            ),
          ),
          SizedBox(
            height: 40,
          ),
          GestureDetector(
              onTap: () {
                showMaterialModalBottomSheet(
                  context: context,
                  builder: (context) => SingleChildScrollView(
                      child: Container(
                    height: 355,
                    width: 375,
                    child: (Column(
                      children: [
                        SizedBox(
                          height: 32,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal:70),
                          child: AppText.textField(
                            "To setup the fingerprint biometrics, kindly confirm the ownership of this account by providing us with you password",
                            centered: true,
                            multiText: true,
                          ),
                        ),
                        SizedBox(
                          height: 32,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [AppText.heading6M("Password"),
                                  SizedBox(height: 4,),
                                  AppTextField(hText: "Enter your password"),],
                              ),
                            ],
                          ),
                        ),

                        SizedBox(
                          height: 59,
                        ),
                        AppButton(title: "Continue", width: 197, color: true),
                      ],
                    )),
                  )),
                );
              },
              child:
                  AppButton(title: "Set Fingerprint", width: 197, color: true)),
        ]));
  }
}
