import 'package:flutter/material.dart';
import 'package:prep50/utils/color.dart';
import 'package:prep50/utils/text.dart';
import 'package:prep50/widgets/app_back_icon.dart';
import 'package:prep50/widgets/app_button.dart';
import 'package:prep50/widgets/app_toast.dart';
import 'package:provider/provider.dart';

import '../../view-models/faq_screen_viewmodel.dart';

class FaqScreen extends StatefulWidget {
  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  AppToast? appToast;
  @override
  void initState() {
    super.initState();
    appToast=AppToast(context: context);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      FaqScreenViewModel _faqScreenViewModel= Provider.of<FaqScreenViewModel>(context,listen: false);
      _faqScreenViewModel.loadFaqList();
    });
  }
  final List<String> title = [
    "Why Prep50",
    "The mission of prep50",
    "What is prep50",
    "How to subscribe",
    "Can I lock my account",
    "How to subscribe to our newsletter",
    "Can I report a post",
    "Can I participate in quiz"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kLightGreyShadeColour,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(13.5),
                    child: Row(
                      children: [
                        AppBackIcon(reverseColor:true),
                        SizedBox(
                          width: 24,
                        ),
                        AppText.heading6S(
                          "Support",
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 134,
                          // width: 254,
                          decoration: BoxDecoration(
                              // borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                  image: AssetImage(
                                      "assets/png/support_img2.png"))),
                        ),
                      ),
                      Expanded(
                          child: AppText.heading5M(
                        "Questions you might have got for us as we help you learn more about us",
                          multiText: true,
                          centered: true,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 20,)
                    ],
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
            SizedBox(height: 12),
            Expanded(
                child: Consumer<FaqScreenViewModel>(
                  builder: (context,faqScreenViewModel,child) {
                    return faqScreenViewModel.errorMessage.isNotEmpty?
                           _buildErrorWidget(faqScreenViewModel):
                        faqScreenViewModel.isLoadingFaqList?
                            _buildLoadingWidget():_buildFaqListWidget(faqScreenViewModel);
                  }
                )),
          ],
        ),
      ),
    );
  }

 Widget _buildLoadingWidget() {
    return Center(
      child: SizedBox(
        height: 30,
        width: 30,
        child: CircularProgressIndicator(),
      ),
    );
 }

 Widget _buildFaqListWidget(FaqScreenViewModel faqScreenViewModel) {
    return ListView.builder(
        itemCount: faqScreenViewModel.faqList.length,
        padding: EdgeInsets.all(0),
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 4),
            child: Container(
              color: Colors.white,
              child: ExpansionTile(
                childrenPadding:
                EdgeInsets.symmetric(horizontal: 15),
                title: AppText.heading6(faqScreenViewModel.faqList[index].title),
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 5),
                    child: AppText.textField(
                      faqScreenViewModel.faqList[index].content,
                      multiText: true,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
 }

 Widget  _buildErrorWidget(FaqScreenViewModel faqScreenViewModel) {
   WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
     appToast?.showToast(message: faqScreenViewModel.errorMessage);
   });

   print(faqScreenViewModel.errorMessage);
   return Center(
     child: AppButton(
       title: "Load Faq List",
       width: 197,
       color: true,
       onTap: () => {
         faqScreenViewModel.loadFaqList()
       },
     ),
   );
 }


}
