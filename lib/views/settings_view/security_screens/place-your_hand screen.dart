import 'package:flutter/material.dart';
import 'package:prep50/utils/text.dart';
class PlaceYourHand extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffFFFFFF),
    body: Column(children: [
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
                  AppText.heading6S("Fingerprint Biometrics"),
              ],
            ),
          ],
        ),
      ),
      SizedBox(
        height: 177.5,
      ),
      Container(
        height: 300,
        width: 300,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xffF7F7F7),
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
      SizedBox(
        height:156 ,
      ),
      Container(
        height: 60,
        width: 300,
        decoration: BoxDecoration(
          color: Color(0xffF7F7F7),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: (
          AppText.textField("Place your hand on your fingerprint section, as we authenticate it",
          centered: true,
          multiText: true,)
          ),
        ),
      )
    ]
    )

    );
  }
}
