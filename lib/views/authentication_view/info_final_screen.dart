import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:prep50/utils/color.dart';
import 'package:prep50/utils/text.dart';
import 'package:prep50/widgets/app_button.dart';
class InfoFinal extends StatefulWidget {
  @override
  State<InfoFinal> createState() => _InfoFinalState();
}

class _InfoFinalState extends State<InfoFinal> {
  FToast? fToast;

  _showToast({String message="Error occurred"}) {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: kPrimaryColor,
      ),
      child:AppText.captionTextM(message,color: Colors.white,),
    );

    //Show the toast message
    fToast?.showToast(
      child: toast,
      gravity: ToastGravity.CENTER,
      toastDuration: Duration(seconds: 2),
    );
  }

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast?.init(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF7F7F7),
      body: Column(
        children: [
          Column(
            children: [
              SizedBox(height: 233,),
              Center(
                child: Stack(
                  children: [
                    Container(
                      height: 196,
                      width: 196,
                      decoration: BoxDecoration(
                        color: Color(0xffFFF4F0),
                        shape: BoxShape.circle,
                      ),
                    ),
                    Positioned(
                      top: 19.6,
                      left: 19.6,
                      child: Container(
                        height: 156.8,
                        width: 156.8,
                        decoration: BoxDecoration(
                          color: Color(0xffFFE8E0),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 39.2,
                      left: 39.2,
                      child: Container(
                          height: 117.6,
                          width: 117.6,
                          decoration: BoxDecoration(
                            color: Color(0xffFF4201),
                            shape: BoxShape.circle,
                          ),
                          child: (Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.verified_rounded,
                                  size: 75,
                                  color: Color(0xffFFFFFF),
                                ),
                              ]
                          )
                          )
                      ),
                    ),
                  ],),
              ),
              SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 64),
                child: AppText.textField(
                  "Hello, username, Good to have to hear, "
                      "your desire to ace your papers are just few clicks away. "
                      "Let's hop on it immediately ",
                  centered: true,
                  multiText: true,),
              ),
              SizedBox(
                height: 38,
              ),
              AppButton(title: "Continue", width: 197, color: true)

            ],
          ),

        ],

    )
    );
  }


}
