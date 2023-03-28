import 'package:flutter/material.dart';
import 'package:prep50/utils/text.dart';
class FinalFingerprint extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffF7F7F7),
    body: Column(
        children: [
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
                    AppText.heading6S("Fingerprint Biometrics"),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 155,),
          Stack(
            children: [
            Container(
              height: 319,
              width: 319,
              decoration: BoxDecoration(
                color: Color(0xffFFF4F0),
                shape: BoxShape.circle,
              ),
            ),
            Positioned(
              top: 31.9,
              left: 31.9,
              child: Container(
                height: 255.2,
                width: 255.2,
                decoration: BoxDecoration(
                  color: Color(0xffFFE8E0),
                  shape: BoxShape.circle,
                ),
              ),
            ),
              Positioned(
                top: 63.8,
                left: 63.8,
                child: Container(
                  height: 191.4,
                  width: 191.4,
                  decoration: BoxDecoration(
                    color: Color(0xffFF4201),
                    shape: BoxShape.circle,
                  ),
                  child: (Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    Icon(
                    Icons.fingerprint_outlined,
                    size: 140,
                    color: Color(0xffFFFFFF),
                  ),
                    ]
                  )
                  )
                ),
              ),
          ],),
          SizedBox(
            height: 22,
          ),
          Container(
            height: 40,
            width: 250,
            color: Color(0xffF0FFF6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.verified_outlined,
                color: Color(0xff03BA50),),
                SizedBox(width: 11,
                ),
                AppText.textField("Fingerprint authentication successful"),
              ],
            ),
          ),


    ]
    )
    );
  }
}
