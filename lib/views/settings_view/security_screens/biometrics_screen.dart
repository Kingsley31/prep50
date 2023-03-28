import 'package:flutter/material.dart';
import 'package:prep50/utils/text.dart';
import 'package:prep50/widgets/security_widget.dart';

class BiometricScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF7F7F7),
      body: Column(
        children: [
          Container(
            height:92,
            width:double.infinity,
            color: Colors.white,
            child: Column(
              mainAxisAlignment:MainAxisAlignment.end,
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
                    SizedBox(
                      width:17
                    ),
                    AppText.heading6S("Security and Privacy"),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 8,),
          SecurityWidget(title: "Password", subtitle: "Setup a strong password for your login"),
          SizedBox(height: 8,),
          SecurityWidget(title: "Fingerprint Id", subtitle: "Enhance your security lock",),
          SizedBox(height: 8,),
          SecurityWidget(title: "Show password", subtitle: "Display characters briefly as you type"),
          SizedBox(height: 8,),
          SecurityWidget(title: "Smart lock", subtitle: "Automatically lock my app  if dormant"),
        ],
      ),
    );
  }
}
