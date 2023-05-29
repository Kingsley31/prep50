
import 'package:flutter/material.dart';
import 'package:prep50/utils/text.dart';
import 'package:prep50/widgets/app_button.dart';
import 'package:prep50/widgets/app_toast.dart';
import 'package:url_launcher/url_launcher.dart';

class MockExamScreen extends StatelessWidget {
  const MockExamScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 30,),
              Image.asset("assets/png/exam_screen_logo.png",width: 150,height: 150,),
              SizedBox(height: 20,),
              AppText.heading5S("Visit Mock Exam Website"),
              SizedBox(height: 20,),
              AppText.textFieldM("From here you will be redirected to our mock exam website. we suggest you open the link in a desktop or laptop computer browser in other for you to get conversant with the look and feel of how your POST-UTME CBT exam will be like.",multiText: true,centered: true,),
              Spacer(flex: 1,),
              AppButton(
                title: "Continue",
                color: true,
                onTap: () {
                  _launchUrl(context);
                },
              ),
              Spacer(flex: 2,),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _launchUrl(context) async {
    final Uri _url = Uri.parse('https://prep50.ng');
    if (!await launchUrl(_url,mode: LaunchMode.externalApplication)) {
      AppToast appToast= AppToast(context: context);
      appToast.showToast(message: "Couldn't launch $_url");
    }
  }
}
