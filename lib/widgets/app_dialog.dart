

import 'package:flutter/material.dart';
import 'package:prep50/widgets/app_button.dart';

import '../utils/color.dart';
import '../utils/text.dart';
import 'package:prep50/validators/basic-form-validators.dart' as inputValidators;

import 'app_text_field.dart';

enum InputDialogType{EMAIL,PHONE,USERNAME}

class AppDialog{

  static Future<void> showAppErrorDialog(context,message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: AppText.heading6('Error',color: kPrimaryColor,),
          content:  AppText.textField(message,
            color: kMidBlackColor,
            multiText: true,
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }


 static Future<String?> showInputDialog(context,InputDialogType inputDialogType){
    return showDialog<String>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return WillPopScope(
            child: InputDialog(inputDialogType: inputDialogType),
            onWillPop: () async => false
        );
      },
    );
  }
}


class InputDialog extends StatefulWidget {
  final InputDialogType inputDialogType;
  const InputDialog({Key? key,required this.inputDialogType}) : super(key: key);

  @override
  State<InputDialog> createState() => _InputDialogState();
}

class _InputDialogState extends State<InputDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String input = "";
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 0.0),
      contentPadding: EdgeInsets.all(0.0),
      content: Wrap(
        children: [
          Container(
            padding: EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText.heading6(
                    getInputLabelText(widget.inputDialogType),
                    color: kPrimaryColor,
                  ),
                  SizedBox(height: 10.0,),
                  getInputField(widget.inputDialogType),
                  SizedBox(height: 20.0,),
                  AppButton(
                    title: "Submit",
                    color: true,
                    onTap: (){
                      if (_formKey.currentState!.validate()) {
                        Navigator.pop(context,input);
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String getInputLabelText(InputDialogType inputDialogType) {
    switch(inputDialogType){
      case InputDialogType.EMAIL:
        return "Enter Email";
      case InputDialogType.PHONE:
        return "Enter Phone";
      case InputDialogType.USERNAME:
        return "Enter Username";
    }
  }

 Widget getInputField(InputDialogType inputDialogType) {
   switch(inputDialogType){
     case InputDialogType.EMAIL:
       return AppTextField(
         hText: "Enter your email",
         validator: inputValidators.emailValidator,
         textInputType: TextInputType.emailAddress,
         onChanged: (String value){
           //Set ViewModel Email
           input=value;
         },
         maxLines: 1,
       );
     case InputDialogType.PHONE:
       return AppTextField(
         hText: "Enter your phone number",
         validator: inputValidators.phoneNumberValidator,
         textInputType: TextInputType.phone,
         onChanged: (String value){
           //Set ViewModel Email
           input=value;
         },
         maxLines: 1,
       );
     case InputDialogType.USERNAME:
       return AppTextField(
         hText: "Enter your preferred Username",
         validator: inputValidators.nameValidator,
         textInputType: TextInputType.name,
         onChanged: (String value){
           //Set ViewModel Email
           input=value;
         },
         maxLines: 1,
       );
   }
 }
}
