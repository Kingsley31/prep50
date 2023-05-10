

import 'package:flutter/material.dart';
import 'package:prep50/validators/basic-form-validators.dart';
import 'package:prep50/widgets/app_button.dart';
import 'package:prep50/widgets/app_text_field.dart';
import 'package:provider/provider.dart';

import '../../../utils/text.dart';
import '../../../view-models/security_and_privacy_screen_viewmodel.dart';

class BottomSheetPasswordDialog{

  static Future<bool?> show(context,{required String message}){
    return showModalBottomSheet<bool?>(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      context: context,
      isDismissible: true,
      enableDrag: false,
      builder: (BuildContext context) {
        return BottomSheetPasswordDialogWidget(message: message,);
      },
    );
  }
}

class BottomSheetPasswordDialogWidget extends StatefulWidget {
  final String message;
  const BottomSheetPasswordDialogWidget({Key? key,required this.message}) : super(key: key);

  @override
  State<BottomSheetPasswordDialogWidget> createState() => _BottomSheetPasswordDialogWidgetState();
}

class _BottomSheetPasswordDialogWidgetState extends State<BottomSheetPasswordDialogWidget> {
  GlobalKey<FormState> _formKey= GlobalKey<FormState>();
  TextEditingController _passwordController= TextEditingController();


  @override
  Widget build(BuildContext context) {
    SecurityAndPrivacyScreenViewModel securityAndPrivacyScreenViewModel=Provider.of<SecurityAndPrivacyScreenViewModel>(context,listen: false);
    securityAndPrivacyScreenViewModel.passwordError=null;
    return Wrap(children: [
      Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            )),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 5,
                ),
                Center(
                  child: Container(
                    height: 2,
                    width: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                AppText.textField(
                  widget.message,
                  multiText: true,
                  centered: true,
                ),
                SizedBox(height: 40,),
                Align(alignment:Alignment.topLeft,child: AppText.textFieldM("Password")),
                Form(
                  key: _formKey,
                  child: Consumer<SecurityAndPrivacyScreenViewModel>(
                    builder: (context,securityAndPrivacyScreenViewModel,child) {
                      return AppTextField(
                        controller: _passwordController,
                        errorText: securityAndPrivacyScreenViewModel.passwordError,
                        obscureText: true,
                        maxLines: 1,
                        hText: "Enter your password",
                        icons: true,
                        textInputType: TextInputType.visiblePassword,
                        showSuffixIcon: true,
                        validator: (String? password) {
                          if (password == null || password.isEmpty) {
                            return "Please enter password";
                          }
                        },
                      );
                    }
                  ),
                ),
                SizedBox(height: 20,),
                Center(
                  child: AppButton(
                    title: "Continue",
                    width: 150,
                    color: true,
                    onTap: ()async{
                      if(_formKey.currentState!.validate()){
                        bool passwordIsCorrect=await securityAndPrivacyScreenViewModel.passwordIsCorrect(_passwordController.text);
                        if(passwordIsCorrect){
                          Navigator.pop(context,true);
                        }
                      }
                    },
                  ),
                ),
                SizedBox(height: 20,)
              ],
            ),
          ),
        ),
      ),
    ]);
  }
}
