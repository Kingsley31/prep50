import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prep50/utils/color.dart';
import 'package:prep50/utils/text.dart';
import 'package:prep50/view-models/login_screen_viewmodel.dart';
import 'package:prep50/views/authentication_view/create_account_screen.dart';
import 'package:prep50/views/authentication_view/info_screen.dart';
import 'package:prep50/views/authentication_view/password_reset_screen.dart';
import 'package:prep50/views/home_view/home_view.dart';
import 'package:prep50/widgets/app_button.dart';
import 'package:prep50/widgets/app_text_field.dart';
import 'package:prep50/widgets/app_toast.dart';
import 'package:prep50/widgets/svg button.dart';
import 'package:prep50/validators/basic-form-validators.dart' as loginValidator;
import 'package:provider/provider.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

import '../../utils/exceptions.dart';
import '../../utils/third-party-login-info-validator.dart';
import 'package:prep50/models/user.dart' as appModel;

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  AppToast? appToast;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextInputType nameInputType = TextInputType.name;
  final TextInputType passwordInputType = TextInputType.visiblePassword;
  final TextEditingController _passwordController = TextEditingController();


  @override
  void initState() {
    super.initState();
    appToast = AppToast(context: context);
    onAuthenticationStateChange();
  }


  @override
  Widget build(BuildContext context) {
    LoginScreenViewModel loginScreenViewModel = Provider.of<LoginScreenViewModel>(context, listen: false);
    final ProgressDialog progressDialog = ProgressDialog(context:context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
                    title: "I'm a new user, Sign up ",
                    color: false,
                    onTap: () => Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                            builder: (context) => CreateAccount())),
                  )
                ],
              ),
            ),
            Expanded(
              child: Form(
                key: _formKey,
                child: ListView(
                  padding: EdgeInsets.all(0),
                  children: [
                    SizedBox(
                      height: 24,
                    ),
                    Center(
                        child: AppText.heading3M(
                      "👋Welcome Back",
                    )),
                    SizedBox(
                      height: 10,
                    ),
                    AppText.textField(
                      "We are super excited that you are back again to enjoy the fun studying to ace your papers😇.",
                      centered: true,
                      color: kMidBlackColor,
                      multiText: true,
                    ),
                    SizedBox(
                      height: 34,
                    ),
                    FutureBuilder<bool>(
                      future: loginScreenViewModel.fingerPrintAuthEnabled,
                      builder: (context,snapshot) {
                        if(snapshot.hasData && snapshot.data==false){
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppText.heading6M("Username"),
                              SizedBox(
                                height: 4,
                              ),
                              AppTextField(
                                hText: "Enter your preferred Username",
                                validator: loginValidator.nameValidator,
                                textInputType: nameInputType,
                                onChanged: (String value){
                                  //Set ViewModel Email
                                  loginScreenViewModel.setUsername=value;
                                },
                                maxLines: 1,
                              ),
                              SizedBox(
                                height: 16,
                              ),
                            ],
                          );
                        }
                        return Container();
                      }
                    ),
                    AppText.heading6M("Password"),
                    SizedBox(
                      height: 4,
                    ),
                    AppTextField(
                      controller: _passwordController,
                      hText: "Enter your password",
                      showSuffixIcon: true,
                      icons: true,
                      validator: loginValidator.passwordValidator,
                      textInputType: passwordInputType,
                      onChanged: (String value){
                        //Set ViewModel password
                        loginScreenViewModel.setPassword=value;
                      },
                      maxLines: 1,
                      obscureText: true,
                      autocorrect: false,
                      enableSuggestions: false,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        Spacer(),
                        AppText.captionTextS("cant remember my password ?"),
                        SizedBox(width: 5),
                        GestureDetector(
                          onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => PasswordReset())),
                          child: AppText.captionText("Get a new one",
                              color: kPrimaryColor),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 96,
                    ),
                    FutureBuilder<bool>(
                      future: loginScreenViewModel.fingerPrintAuthEnabled,
                      builder: (context,snapshot) {
                        if(snapshot.hasData && snapshot.data==false){
                          return _buildLoginButton(loginScreenViewModel,progressDialog);
                        }else if(snapshot.hasData && snapshot.data==true){
                          return _buildBiometricButton(loginScreenViewModel,progressDialog);
                        }
                        return Center(child: SizedBox(height: 30,width: 30,child: CircularProgressIndicator(color: kPrimaryColor,),),);
                      }
                    ),
                    SizedBox(
                      height: 56,
                    ),
                    Center(child: AppText.captionTextS("Or continue with")),
                    SizedBox(
                      height: 24,
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: GestureDetector(
                              child: SvgButton(
                          title: "Facebook",
                          width: 159,
                          color: kInfoColor,
                          assets: "assets/svg/facebook.svg",
                        ),
                              onTap: () async {
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
                        ),
                              onTap: () async {
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
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onAuthenticationStateChange() async{
    LoginScreenViewModel loginScreenViewModel = Provider.of<LoginScreenViewModel>(context, listen: false);
    //String? userLoginType = await loginScreenViewModel.userLoginType;
    bool userIsLoggedIn = await loginScreenViewModel.userIsLoggedIn;
    if(userIsLoggedIn==false){return;}

    bool fingerPrintEnabled = await loginScreenViewModel.fingerPrintAuthEnabled;
    if(fingerPrintEnabled){return;}

    appModel.User loggedInUser = await loginScreenViewModel.getLoggedInUser();
    if(loggedInUser.hasRegisteredExam){
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(settings:RouteSettings(name: HomeView.routeName),builder: (context) => HomeView()));
      return;
    }
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(
            builder: (context) => InfoScreen()));



  }

  Widget _buildLoginButton(LoginScreenViewModel loginScreenViewModel, ProgressDialog progressDialog) {
    return AppButton(
        title: "Login",
        width: 343,
        color: true,
        onTap: () async{
          if (_formKey.currentState!.validate()) {
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
            try{
              final loginResponse = await loginScreenViewModel.loginUser();
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
            }catch(e){
              progressDialog.close();
              appToast?.showToast(message: e.toString().substring(11));
              print(e.toString());
            }

          }

        }
    );
  }

  Widget _buildBiometricButton(LoginScreenViewModel loginScreenViewModel, ProgressDialog progressDialog) {
    return AppButton(
        title: "Login With Biometrics",
        width: 343,
        color: true,
        onTap: () async{
          final String username = await loginScreenViewModel.loginUsername;
          final String password = await loginScreenViewModel.loginPassword;
          _passwordController.text = password;
          loginScreenViewModel.setUsername=username;
          loginScreenViewModel.setPassword=password;
          bool isAuthenticated = await loginScreenViewModel.authenticateWithFingerPrint();
          if (isAuthenticated) {
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
            try{
              final loginResponse = await loginScreenViewModel.loginUser();
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
            }catch(e){
              progressDialog.close();
              appToast?.showToast(message: e.toString().substring(11));
              print(e.toString());
            }

          }

        }
    );
  }
}
