

import 'package:flutter/material.dart';

import '../../../../utils/text.dart';
import '../../../../widgets/app_button.dart';

class TakeQuizBottomSheetDialog extends StatelessWidget {

  const TakeQuizBottomSheetDialog({Key? key}) : super(key: key);

  static Future showTakeQuizBottomSheetDialog(context) {
    return showModalBottomSheet<void>(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      context: context,
      isDismissible: false,
      enableDrag: false,
      builder: (BuildContext context) {
        return WillPopScope(
            child: TakeQuizBottomSheetDialog(),
            onWillPop: () async => false
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children:[
        Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              )),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 15,),
              Container(height: 2,width: 70,color: Colors.grey,),
              SizedBox(height: 6,),
              Container(
                height: 160,
                width: 160,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                            "assets/png/exam1.png"))),
              ),
              SizedBox(height: 10),
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 28),
                child: AppText.textField(
                  "This a quick quiz,to help you discover your level of understanding over "
                      "this topic you just read.",
                  multiText: true,
                  centered: true,
                ),
              ),
              SizedBox(
                height: 25,
              ),
              AppButton(
                  title: "Take Quiz",
                  width: 197,
                  color: true,
                  onTap: (){
                    Navigator.pop(context);
                  },
              ),
              SizedBox(
                height: 25,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
