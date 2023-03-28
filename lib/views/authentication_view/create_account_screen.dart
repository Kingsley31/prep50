import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
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

class CreateAccount extends StatefulWidget {
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



  @override
  void initState() {
    super.initState();
    appToast = AppToast(context: context);
  }


  @override
  Widget build(BuildContext context) {
    CreateAccountViewModel createAccountViewModel = Provider.of<CreateAccountViewModel>(context, listen: false);
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
                            child: SvgButton(
                          title: "Facebook",
                          width: 159,
                          assets: "assets/svg/facebook.svg",
                          color: kInfoColor,
                        )),
                        SizedBox(
                          width: 25,
                        ),
                        Expanded(
                            child: SvgButton(
                          title: "Google",
                          width: 159,
                          assets: "assets/svg/googleicons.svg",
                          // color: false,
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

}
