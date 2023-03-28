import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:prep50/utils/color.dart';
import 'package:prep50/utils/text.dart';
import 'package:prep50/validators/basic-form-validators.dart';
import 'package:prep50/view-models/password_reset_screen_viewmodel.dart';
import 'package:prep50/views/authentication_view/login_screen.dart';
import 'package:prep50/widgets/app_button.dart';
import 'package:prep50/widgets/app_text_field.dart';
import 'package:prep50/widgets/app_toast.dart';
import 'package:provider/provider.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

import '../../utils/exceptions.dart';

class PasswordReset extends StatefulWidget {
  @override
  State<PasswordReset> createState() => _PasswordResetState();
}

class _PasswordResetState extends State<PasswordReset> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AppToast? appToast;

  @override
  void initState() {
    super.initState();
    appToast = AppToast(context: context);
  }

  @override
  Widget build(BuildContext context) {
    PasswordResetScreenViewModel passwordResetScreenViewModel = Provider.of<PasswordResetScreenViewModel>(context,listen: false);
    final ProgressDialog progressDialog = ProgressDialog(context:context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(
                      CupertinoIcons.arrow_left_circle_fill,
                      color: Color(0xffFF4201),
                    ),
                  ),
                  SizedBox(
                    width: 66,
                  ),
                  AppText.heading3M("🤔Password Reset"),
                ],
              ),
              SizedBox(height: 10),
              AppText.textField(
                "Oh you forgot your password, we can help you get another once you provide us with this few details",
                centered: true,
                color: kMidBlackColor,
                multiText: true,
              ),
              SizedBox(
                height: 39,
              ),
              AppText.heading6M("Email"),
              SizedBox(
                height: 4,
              ),
              Form(
                key: _formKey,
                child: AppTextField(
                  hText: "Enter your email address",
                  showSuffixIcon: true,
                  icons: false,
                  showInfoTooltip:true,
                  tooltipText:"Be certain we would recognise the registered email only, kindly provide the email connected to this account.",
                  validator: emailValidator,
                  onChanged: (String value){
                    passwordResetScreenViewModel.email = value;
                  },
                ),
              ),
              Spacer(),
              AppButton(
                title: "Reset",
                onTap: () async {
                  if (_formKey.currentState!.validate()) {
                      progressDialog.show(
                      max: 100,
                      msg: 'Sending Reset Link...',
                      msgColor: Colors.black,
                      progressValueColor: kPrimaryColor,
                      borderRadius: 10.0,
                      backgroundColor: Colors.white,
                      barrierDismissible: false,
                      elevation: 10.0,
                      );
                      try{
                        String message = await passwordResetScreenViewModel.sendPasswordResetLink();
                        progressDialog.close();
                        showBottomSheet(context,message);
                      } on ValidationException catch (e){
                        progressDialog.close();
                        appToast?.showToast(message: e.message);
                      } catch (e) {
                        progressDialog.close();
                        appToast?.showToast(message: e.toString().substring(11));
                      }

                  }
                },
                color: true,
              )
            ],
          ),
        ),
      ),
    );
  }

  showBottomSheet(context,String message) {
    return showMaterialModalBottomSheet(
      isDismissible: false,
      context: context,
      builder: (context) => SingleChildScrollView(
          child: SafeArea(
        child: (Column(
          children: [
            Container(
              height: 160,
              width: 141.04,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/png/mail.png"))),
            ),
            SizedBox(
              height: 15.25,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: AppText.captionText(
                message,
                centered: true,
                multiText: true,
              ),
            ),
            SizedBox(
              height: 24,
            ),
            AppButton(
              title: "Login",
              width: 197,
              onTap: () => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => LoginScreen())),
              color: true,
            )
          ],
        )),
      )),
    );
  }
}
