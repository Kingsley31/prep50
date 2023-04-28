import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:prep50/constants/text_style.dart';
import 'package:prep50/utils/color.dart';
import 'package:prep50/utils/text.dart';
import 'package:prep50/view-models/welcome-screen-viewmodel.dart';
import 'package:prep50/views/home_view/home_view.dart';
import 'package:prep50/widgets/app_button.dart';
import 'package:provider/provider.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  FToast? fToast;

  _showToast({String message="Error occurred"}) {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: kPrimaryColor,
      ),
      child:AppText.captionTextM(message,color: Colors.white,),
    );

    //Show the toast message
    fToast?.showToast(
      child: toast,
      gravity: ToastGravity.CENTER,
      toastDuration: Duration(seconds: 2),
    );
  }

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast?.init(context);
  }

  @override
  Widget build(BuildContext context) {
    WelcomeScreenViewModel welcomeScreenViewModel = Provider.of<WelcomeScreenViewModel>(context, listen: false);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: FutureBuilder<String>(
            future: welcomeScreenViewModel.getUserName(),
            builder: (context,AsyncSnapshot<String> snapshot){
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                    _showToast(message: "${snapshot.error}");
                  });
                  print("${snapshot.error}");
                }

                if(snapshot.hasData) {
                  print("${snapshot.data}");
                  return showWelcomeScreen(snapshot.data?.toString() ?? "");
                }
              }
              return CircularProgressIndicator(color: kPrimaryColor,);
            },
          ),
        ),
      ),
    );
  }

  Widget showWelcomeScreen(String username){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset("assets/svg/welcome.svg"),
        SizedBox(height: 20),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: textFieldRegularStyle.copyWith(color: kPrimaryColor),
            text: "👋 Hello $username",
            children: [
              TextSpan(
                text:
                " Good to have you here, your desire to ace your papers are just few clicks away. Let’s hop on it immediately",
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
        AppButton(
          title: "Continue",
          width: 197,
          color: true,
          onTap: () =>
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                settings:RouteSettings(name: HomeView.routeName),
                builder: (context) => HomeView(),
              )),
        ),
      ],
    );
  }
}
