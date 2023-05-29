import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prep50/utils/color.dart';
import 'package:prep50/utils/exceptions.dart';
import 'package:prep50/utils/text.dart';
import 'package:prep50/view-models/create_account_screen_viewmodel.dart';
import 'package:prep50/views/authentication_view/info_screen.dart';
import 'package:prep50/views/authentication_view/login_screen.dart';
import 'package:prep50/widgets/app_button.dart';
import 'package:prep50/widgets/app_text_field.dart';
import 'package:prep50/widgets/app_toast.dart';
import 'package:prep50/widgets/svg button.dart';
import 'package:prep50/validators/basic-form-validators.dart' as registrationValidator;
import 'package:provider/provider.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

import '../../utils/third-party-login-info-validator.dart';
import '../../view-models/login_screen_viewmodel.dart';
import '../home_view/home_view.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({Key? key,this.refererUserName}):super(key: key);
  final String? refererUserName;
  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  AppToast? appToast;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextInputType phoneNumberInputTpe = TextInputType.phone;
  final TextInputType emailInputType = TextInputType.emailAddress;
  final TextInputType nameInputType = TextInputType.name;
  final TextInputType passwordInputType = TextInputType.visiblePassword;
  final TextEditingController refererController = TextEditingController();



  @override
  void initState() {
    super.initState();
    appToast = AppToast(context: context);
  }


  @override
  Widget build(BuildContext context) {
    CreateAccountViewModel createAccountViewModel = Provider.of<CreateAccountViewModel>(context, listen: false);
    LoginScreenViewModel loginScreenViewModel = Provider.of<LoginScreenViewModel>(context, listen: false);
    final ProgressDialog progressDialog = ProgressDialog(context:context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SafeArea(
              bottom: false,
              child: Row(
                children: [
                  Icon(
                    CupertinoIcons.arrow_left_circle_fill,
                    color: Color(0xffFF4201),
                  ),
                  Spacer(),
                  AppButton(
                    width: 197,
                    title: "I have an account, Login",
                    color: false,
                    onTap: () => Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => LoginScreen())),
                  )
                ],
              ),
            ),
            Expanded(
              child: Form(
                key:_formKey,
                child: ListView(
                  padding: EdgeInsets.all(0),
                  children: [
                    SizedBox(
                      height: 24,
                    ),
                    Center(
                      child: AppText.heading3M(
                        "Create An Account",
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    AppText.textField(
                      "Let's get you started as we help you ace you papers and help you enjoy the fun in studying",
                      centered: true,
                      color: kMidBlackColor,
                      multiText: true,
                    ),
                    SizedBox(
                      height: 34,
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: GestureDetector(
                              child: SvgButton(
                          title: "Facebook",
                          width: 159,
                          assets: "assets/svg/facebook.svg",
                          color: kInfoColor,
                        ),
                              onTap: ()async {
                                try{
                                  progressDialog.show(
                                    max: 100,
                                    msg: 'Login in...',
                                    msgColor: Colors.black,
                                    progressValueColor: kPrimaryColor,
                                    borderRadius: 10.0,
                                    backgroundColor: Colors.white,
                                    barrierDismissible: false,
                                    elevation: 10.0,
                                  );
                                  final userCredentials = await loginScreenViewModel.signInWithFacebook();
                                  final ThirdPartyLoginInfo thirdPartyLoginInfo = await ThirdPartyLoginInfoValidator.validate(context, userCredentials.user?.displayName, userCredentials.user?.email, userCredentials.user?.phoneNumber);
                                  final loginResponse = await loginScreenViewModel.authenticateApiWithFacebookDetails(thirdPartyLoginInfo.username, thirdPartyLoginInfo.phoneNumber, thirdPartyLoginInfo.email);
                                  progressDialog.close();
                                  if(loginResponse.user.hasRegisteredExam){
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(settings:RouteSettings(name: HomeView.routeName),builder: (context) => HomeView()));
                                    return;
                                  }
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) => InfoScreen()));
                                }on ValidationException catch(e){
                                  progressDialog.close();
                                  appToast?.showToast(message: e.message);
                                  print(e.toString());
                                }on FirebaseAuthException catch(e){
                                  progressDialog.close();
                                  appToast?.showToast(message: e.message??"Failed to authenticate with facebook, try email/password signing.");
                                  print(e.toString());
                                }catch(e){
                                  progressDialog.close();
                                  appToast?.showToast(message: e.toString().substring(11));
                                  print(e.toString());
                                }
                              },
                            )),
                        SizedBox(
                          width: 25,
                        ),
                        Expanded(
                            child: GestureDetector(
                              child: SvgButton(
                          title: "Google",
                          width: 159,
                          assets: "assets/svg/googleicons.svg",
                          // color: false,
                        ),
                              onTap: ()async {
                                try{
                                  progressDialog.show(
                                    max: 100,
                                    msg: 'Login in...',
                                    msgColor: Colors.black,
                                    progressValueColor: kPrimaryColor,
                                    borderRadius: 10.0,
                                    backgroundColor: Colors.white,
                                    barrierDismissible: false,
                                    elevation: 10.0,
                                  );
                                  final userCredentials = await loginScreenViewModel.signInWithGoogle();
                                  final ThirdPartyLoginInfo thirdPartyLoginInfo = await ThirdPartyLoginInfoValidator.validate(context, userCredentials.user?.displayName, userCredentials.user?.email, userCredentials.user?.phoneNumber);
                                  final loginResponse = await loginScreenViewModel.authenticateApiWithGoogleDetails(thirdPartyLoginInfo.username, thirdPartyLoginInfo.phoneNumber, thirdPartyLoginInfo.email);
                                  progressDialog.close();
                                  if(loginResponse.user.hasRegisteredExam){
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(settings:RouteSettings(name: HomeView.routeName),builder: (context) => HomeView()));
                                    return;
                                  }
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) => InfoScreen()));
                                }on ValidationException catch(e){
                                  progressDialog.close();
                                  appToast?.showToast(message: e.message);
                                  print(e.toString());
                                }on FirebaseAuthException catch(e){
                                  progressDialog.close();
                                  appToast?.showToast(message: e.message??"Failed to authenticate with google, try email/password signing.");
                                  print(e.toString());
                                }catch(e){
                                  progressDialog.close();
                                  appToast?.showToast(message: e.toString().substring(11));
                                  print(e.toString());
                                }
                              },
                            ))
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Center(child: AppText.heading4("Or")),
                    SizedBox(
                      height: 16,
                    ),
                    AppText.heading6M("Username"),
                    SizedBox(
                      height: 4,
                    ),
                    AppTextField(
                      hText: "Enter your preferred Username",
                      validator: registrationValidator.nameValidator,
                      textInputType: nameInputType,
                      onChanged: (String value){
                        //Set ViewModel Username
                        createAccountViewModel.setUsername=value;
                      },
                      maxLines: 1,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    AppText.heading6M("Email"),
                    SizedBox(
                      height: 4,
                    ),
                    AppTextField(
                        hText: "Enter your email address",
                        validator: registrationValidator.emailValidator,
                        textInputType: emailInputType,
                        onChanged: (String value){
                          //Set ViewModel Email
                          createAccountViewModel.setEmail=value;
                        },
                        maxLines: 1,
                    ),
                    widget.refererUserName!=null?_buildRefererField(createAccountViewModel):Container(),
                    SizedBox(
                      height: 16,
                    ),
                    AppText.heading6M("Phone Number"),
                    SizedBox(
                      height: 4,
                    ),
                    AppTextField(
                        hText: "Enter your phone number",
                        validator: registrationValidator.phoneNumberValidator,
                        textInputType: phoneNumberInputTpe,
                        onChanged: (String value){
                          //Set ViewModel Phone number
                          createAccountViewModel.setPhone=value;
                        },
                        maxLines: 1,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    AppText.heading6M(
                      "Password",
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    AppTextField(
                      hText: "Create a strong password",
                      showSuffixIcon: true,
                      icons: true,
                      validator: registrationValidator.passwordValidator,
                      textInputType: passwordInputType,
                      onChanged: (String value){
                        //Set ViewModel password
                        createAccountViewModel.setPassword=value;
                      },
                      maxLines: 1,
                      obscureText: true,
                      autocorrect: false,
                      enableSuggestions: false,
                    ),
                    SizedBox(
                      height: 26,
                    ),
                    Center(
                      child: AppButton(
                        title: "Create account",
                        width: 343,
                        color: true,
                        onTap: () async {
                            if (_formKey.currentState!.validate()) {
                              progressDialog.show(
                                max: 100,
                                msg: 'Creating account...',
                                msgColor: Colors.black,
                                progressValueColor: kPrimaryColor,
                                borderRadius: 10.0,
                                backgroundColor: Colors.white,
                                barrierDismissible: false,
                                elevation: 10.0,
                              );
                              try{
                                final registrationResponse = await createAccountViewModel.registerUser();
                                progressDialog.close();
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) => InfoScreen()));
                              } on ValidationException catch(e){
                                progressDialog.close();
                                appToast?.showToast(message: e.message);
                                print(e.toString());
                              }on Exception catch(e){
                                progressDialog.close();
                                appToast?.showToast(message: e.toString().substring(11));
                                print(e.toString());
                              }

                            }
                          },
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

 Widget _buildRefererField(CreateAccountViewModel createAccountViewModel) {
    createAccountViewModel.setReferer=widget.refererUserName??"";
    refererController.text=widget.refererUserName??"";
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 16,
        ),
        AppText.heading6M("Referer"),
        SizedBox(
          height: 4,
        ),
        AppTextField(
          controller: refererController,
          hText: "Enter your referer username",
          validator: registrationValidator.nameValidator,
          textInputType: nameInputType,
          onChanged: (String value){
            //Set ViewModel Phone number
            createAccountViewModel.setReferer=value;
          },
          maxLines: 1,
        ),
      ],
    );
 }



}
