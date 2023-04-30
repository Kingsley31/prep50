import 'package:flutter/material.dart';
import 'package:prep50/constants/text_style.dart';
import 'package:prep50/utils/color.dart';
import 'package:prep50/utils/text.dart';
import 'package:prep50/view-models/report_screen_viewmodel.dart';
import 'package:prep50/widgets/app_back_icon.dart';
import 'package:prep50/widgets/app_button.dart';
import 'package:prep50/widgets/app_text_field.dart';
import 'package:prep50/widgets/app_toast.dart';
import 'package:provider/provider.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';

import '../../utils/exceptions.dart';

class HomeReportScreen extends StatefulWidget {

  const HomeReportScreen({Key? key,required this.title,required this.isFeed,this.slug,this.commentId}) : super(key: key);
  final String title;
  final String? slug;
  final String? commentId;
  final bool isFeed;

  @override
  State<HomeReportScreen> createState() => _HomeReportScreenState();
}

class _HomeReportScreenState extends State<HomeReportScreen> {
  TextEditingController messageController = TextEditingController();
  AppToast? appToast;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    appToast = AppToast(context: context);
  }

  @override
  Widget build(BuildContext context) {
    ReportScreenViewModel reportScreenViewModel = Provider.of<ReportScreenViewModel>(context,listen: false);
    final ProgressDialog progressDialog = ProgressDialog(context:context);
    return Scaffold(
      backgroundColor: Color(0xffe5e5e5),
      body: ListView(
        padding: EdgeInsets.all(0),
        children: [
          Container(
            // height: 94,
            width: double.infinity,
            color: Color(0xffffffff),
            child: Column(
              children: [
                SafeArea(
                  bottom: false,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 17, vertical: 13),
                    child: Row(
                      children: [
                        AppBackIcon(),
                        SizedBox(
                          width: 17,
                        ),
                        AppText.heading6S("Report")
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 17),
                  child: AppText.textField(
                    "Be very assured that all attentions would be"
                    " provided and attended to your report",
                    multiText: true,
                    color: kMidBlackColor,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
          SizedBox(height: 21),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              height: 269,
              width: 343,
              decoration: BoxDecoration(
                  color: Color(0xffffffff),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Column(
                children: [
                  SizedBox(height: 50),
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 70,
                        backgroundColor: Color(0xfffff4f0),
                      ),
                      Positioned(
                        top: 14,
                        left: 14,
                        right: 14,
                        bottom: 14,
                        child: CircleAvatar(
                          radius: 51,
                          backgroundColor: Color(0xffffe8e0),
                        ),
                      ),
                      Positioned(
                        top: 28,
                        left: 28,
                        child: CircleAvatar(
                          radius: 42,
                          backgroundColor: kPrimaryColor,
                          child: Center(
                              child: Icon(
                            Icons.check,
                            size: 45,
                            color: Color(0xffffffff),
                          )),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 17),
                    child: RichText(
                      text: TextSpan(
                        text: "You selected ",
                        style: textFieldRegularStyle.copyWith(
                            color: kMidBlackColor),
                        children: [
                          TextSpan(
                            text: "${widget.title}",
                            style: textFieldRegularStyle.copyWith(
                              color: kPrimaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: " as a problem you would want to report on "
                                "the Uniilorin State University’s post.",
                          ),
                        ],
                      ),
                    ),

                    //  AppText.textField(
                    //   "You selected $title as a problem you would want to report on "
                    //   "the Uniilorin State University’s post.",
                    //   multiText: true,
                    //   color: kMidBlackColor,
                    // ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xffffffff),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 17, vertical: 11),
                    child: AppText.textField(
                      "Please kindly send us a complaint or more details "
                      "why you are reporting this newsfeed.",
                      color: kMidBlackColor,
                      multiText: true,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 17),
                    child: Form(
                      key: _formKey,
                      child: AppTextField(
                        controller: messageController,
                        hText: "Enter your complaint...",
                        maxLines: 10,
                        validator: (value){
                          if(value ==null || value!.isEmpty){
                            return "Please enter a message";
                          }
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
          SizedBox(height: 24),
          Container(
            height: 83,
            width: double.infinity,
            color: Color(0xffffffff),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: AppButton(
                color: true,
                width: 343,
                title: "Send Report",
                onTap: ()async{
                  if (_formKey.currentState!.validate()) {
                      progressDialog.show(
                      max: 100,
                      msg: 'Sending Report...',
                      msgColor: Colors.black,
                      progressValueColor: kPrimaryColor,
                      borderRadius: 10.0,
                      backgroundColor: Colors.white,
                      barrierDismissible: false,
                      elevation: 10.0,
                      );
                      try{
                        if(widget.isFeed){
                          await reportScreenViewModel.reportFeed(widget.title, widget.slug!, messageController.text);
                          progressDialog.close();
                          Navigator.pop(context,true);
                        }else{
                          await reportScreenViewModel.reportComment(widget.title, widget.commentId!,messageController.text);
                          progressDialog.close();
                          Navigator.pop(context,true);
                        }
                      }on ValidationException catch(e){
                        progressDialog.close();
                        appToast?.showToast(message: e.message);
                      }catch(e){
                        progressDialog.close();
                        appToast?.showToast(message: e.toString().substring(11));
                      }


                  }
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
