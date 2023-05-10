


import 'package:flutter/material.dart';
import 'package:prep50/widgets/app_back_icon.dart';
import 'package:prep50/widgets/app_toast.dart';
import 'package:provider/provider.dart';

import '../../utils/color.dart';
import '../../utils/text.dart';
import '../../view-models/security_and_privacy_screen_viewmodel.dart';
import 'components/bottom_sheet_password_dialog.dart';
import 'change_password_screen.dart';

class SecurityAndPrivacyScreen extends StatefulWidget {
  const SecurityAndPrivacyScreen({Key? key}) : super(key: key);

  @override
  State<SecurityAndPrivacyScreen> createState() => _SecurityAndPrivacyScreenState();
}

class _SecurityAndPrivacyScreenState extends State<SecurityAndPrivacyScreen> {
  AppToast? _appToast;


  @override
  void initState() {
    super.initState();
    _appToast=AppToast(context: context);
  }

  @override
  Widget build(BuildContext context) {
    SecurityAndPrivacyScreenViewModel securityAndPrivacyScreenViewModel=Provider.of<SecurityAndPrivacyScreenViewModel>(context,listen: false);
    return Scaffold(
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
                    AppText.heading6S("Security and Privacy"),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    component(
                      icon: Icons.lock,
                      title: "Password",
                      subtitle: "Change password",
                      widget: Center(child: Icon(Icons.arrow_forward_ios,color: Colors.grey,size: 20,)),
                      onTap: ()async{
                        bool authenticated = await BottomSheetPasswordDialog.show(context,message: "To change your password, kindly confirm the ownership of this account through providing us with your password")??false;
                        if(authenticated){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ChangePasswordScreen()));
                        }
                      },
                    ),
                    SizedBox(height: 20),
                    FutureBuilder<bool>(
                        future: securityAndPrivacyScreenViewModel.deviceHasBiometrics(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData && snapshot.data==true) {
                            return component(
                              icon: Icons.fingerprint,
                              title: "Fingerprint Id",
                              subtitle: "Enable fingerprint authentication",
                              widget: FutureBuilder<bool>(
                                  future: securityAndPrivacyScreenViewModel.getFingerPrintEnabled(),
                                  builder: (context, snapshot) {
                                    if(snapshot.hasData){
                                      return Switch(
                                          value: snapshot.data!,
                                          onChanged: (bool enabled)async{
                                            bool isAuthenticated=await securityAndPrivacyScreenViewModel.authenticateWithFingerPrint(enabled);
                                            if(isAuthenticated){
                                              await securityAndPrivacyScreenViewModel.setFingerPrintEnable(enabled);
                                              setState(() {});
                                              _appToast?.showToast(message: "Fingerprint authentication ${enabled?"enabled":"disabled"} successfully.");

                                            }

                                          }
                                      );
                                    }
                                    return SizedBox(height:20,width:20,child: CircularProgressIndicator(color: kPrimaryColor,));
                                  }
                              ),
                            );
                          }
                          return Container();
                        }
                    ),
                    SizedBox(height: 20),
                    FutureBuilder<bool>(
                        future: securityAndPrivacyScreenViewModel.getSmartLockEnable(),
                        builder: (context,snapshot) {
                          if(snapshot.hasData){
                            return component(
                              icon: Icons.smart_button_rounded,
                              title: "Smart lock",
                              subtitle: "Automatically lock my app if dormant",
                              widget: Switch(
                                  value: snapshot.data!,
                                  onChanged: (bool enabled)async{
                                    await securityAndPrivacyScreenViewModel.setSmartLock(enabled);
                                    setState(() {});
                                    _appToast?.showToast(message: "Smart lock ${enabled?"enabled":"disabled"} successfully.");

                                  }
                              ),
                            );
                          }
                          return Container();
                        }
                    ),
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }

  Widget component({IconData? icon, String? title, String? subtitle,Widget? widget,Function()? onTap,}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                    color: kErrorLightColor,
                    borderRadius: BorderRadius.circular(8)),
                child: Icon(
                  icon,
                  color: kErrorColor,
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText.heading6S(
                      "$title",
                      color: kBlackColor,
                    ),
                    SizedBox(height: 2),
                    AppText.captionText(
                      "$subtitle",
                      color: kMidGreyColor,
                      multiText: true,
                    ),
                  ],
                ),
              ),
              widget??Container(),
              SizedBox(width: 8,)
            ],
          ),
        ),
      ),
    );
  }
}
