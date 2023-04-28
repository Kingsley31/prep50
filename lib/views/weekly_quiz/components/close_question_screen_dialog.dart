
import 'package:flutter/material.dart';
import 'package:prep50/utils/text.dart';
import 'package:prep50/widgets/app_button.dart';

class CloseQuestionScreenDialog{


  static Future<bool?> show(context) async {
    return showDialog<bool>(
        context: context,
        builder: (BuildContext context){
          return WillPopScope(
              child: CloseQuestionScreenDialogWdget(),
              onWillPop: () async => false
          );
        }
    );
  }


}

class CloseQuestionScreenDialogWdget extends StatelessWidget {
  const CloseQuestionScreenDialogWdget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 30),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      content: Wrap(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(30.0))
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 40,),
                    AppText.textFieldM(
                      "Are you sure you wan to quit this quiz and you probably loose out on the prize. Try harder you can do this😥",
                      multiText: true,
                      centered: true,
                    ),
                    SizedBox(height: 20,),
                    SizedBox(
                      height: 57,
                      child: AppButton(
                        width: 200,
                        title: "Quit quiz",
                        color: true,
                        onTap: (){
                          Navigator.pop(context,true);
                        },
                      ),
                    ),
                    SizedBox(height: 10,),
                    SizedBox(
                      height: 57,
                      child: AppButtonMain(
                        width: 200,
                        title: "Cancel",
                        textColor: Colors.black,
                        color: Colors.grey[300],
                        onTap: (){
                          Navigator.pop(context,false);
                        },
                      ),
                    ),

                  ],
                ) ,
              ),
              Positioned(
                right:0,
                left: 0,
                top: -55,
                child: Container(
                  height: 80,
                  width: 80,
                  child: Image.asset("assets/png/close_quiz_dialog_icon.png"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}



