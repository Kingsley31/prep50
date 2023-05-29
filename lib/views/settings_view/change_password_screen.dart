


import 'package:flutter/material.dart';
import 'package:prep50/widgets/app_button.dart';
import 'package:prep50/widgets/app_text_field.dart';
import 'package:prep50/widgets/app_toast.dart';
import 'package:provider/provider.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

import '../../utils/color.dart';
import '../../utils/exceptions.dart';
import '../../utils/text.dart';
import '../../view-models/change_password_screen_viewmodel.dart';
import '../../widgets/app_back_icon.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _oldPasswordController = TextEditingController();
  TextEditingController _newPasswordController = TextEditingController();
  TextEditingController _confirmNewPasswordController = TextEditingController();
  AppToast? _appToast;

  @override
  void initState() {
    super.initState();
    _appToast=AppToast(context: context);
  }

  @override
  Widget build(BuildContext context) {
    ProgressDialog _progressDialog = ProgressDialog(context: context);
    ChangePasswordScreenViewModel changePasswordScreenViewModel= Provider.of<ChangePasswordScreenViewModel>(context,listen: false);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              color: Color(0xffffffff),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                child: Row(
                  children: [
                    AppBackIcon(),
                    SizedBox(
                      width: 24,
                    ),
                    AppText.heading6S("Change Password"),
                  ],
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText.heading6M("Old Password"),
                        SizedBox(height: 10,),
                        AppTextField(
                          hText: "Enter old password",
                          controller: _oldPasswordController,
                          maxLines: 1,
                          textInputType: TextInputType.visiblePassword,
                          obscureText: true,
                          showSuffixIcon: true,
                          icons: true,
                          validator: (String? value){
                            if(value==null || value.isEmpty){
                              return "Please enter your old password";
                            }
                          },
                        ),
                        SizedBox(height: 20,),
                        AppText.heading6M("New Password"),
                        SizedBox(height: 10,),
                        AppTextField(
                          hText: "Enter new password",
                          controller: _newPasswordController,
                          maxLines: 1,
                          textInputType: TextInputType.visiblePassword,
                          obscureText: true,
                          showSuffixIcon: true,
                          icons: true,
                          validator: (String? value){
                            if(value==null || value.isEmpty){
                              return "Please enter new password";
                            }
                          },
                        ),
                        SizedBox(height: 20,),
                        AppText.heading6M("Confirm New Password"),
                        SizedBox(height: 10,),
                        AppTextField(
                          hText: "Confirm new password",
                          controller: _confirmNewPasswordController,
                          maxLines: 1,
                          textInputType: TextInputType.visiblePassword,
                          obscureText: true,
                          showSuffixIcon: true,
                          icons: true,
                          validator: (String? value){
                            if(value==null || value.isEmpty || value!=_newPasswordController.text){
                              return "Please confirm new password";
                            }
                          },
                        ),
                        SizedBox(height: 30,),
                        AppButton(
                          title: "Change Password",
                          color: true,
                          onTap: () async{
                            if(_formKey.currentState!.validate()){
                              _progressDialog.show(
                                max: 100,
                                msg: 'Changing password...',
                                msgColor: Colors.black,
                                progressValueColor: kPrimaryColor,
                                borderRadius: 10.0,
                                backgroundColor: Colors.white,
                                barrierDismissible: false,
                                elevation: 10.0,
                              );
                              try{
                                final response = await changePasswordScreenViewModel.changePassword(_oldPasswordController.text, _newPasswordController.text);
                                _progressDialog.close();
                                _appToast?.showToast(message: response["message"]);
                              }on ValidationException catch(e){
                                _progressDialog.close();
                                _appToast?.showToast(message: e.message);
                              }on LoginException catch(e){
                                _progressDialog.close();
                                _appToast?.showToast(message: e.message);
                              }catch(e){
                                _progressDialog.close();
                                _appToast?.showToast(message: e.toString().substring(11));
                              }
                            }

                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
