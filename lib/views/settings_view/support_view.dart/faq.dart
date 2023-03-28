import 'package:flutter/material.dart';
import 'package:prep50/utils/color.dart';
import 'package:prep50/utils/text.dart';
import 'package:prep50/widgets/app_back_icon.dart';

class Faq extends StatelessWidget {
  // const SupportScreen2({Key key}) : super(key: key);
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
                        AppBackIcon(),
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
                      ))
                    ],
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
            SizedBox(height: 12),
            Expanded(
                child: ListView.builder(
                    itemCount: 8,
                    padding: EdgeInsets.all(0),
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        child: Container(
                          color: Colors.white,
                          child: ExpansionTile(
                            childrenPadding:
                                EdgeInsets.symmetric(horizontal: 15),
                            title: AppText.heading6(title[index]),
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 5),
                                child: AppText.textField(
                                  "preparatory application breaks down each subject into JAMB objectives for the subject. Study materials and questions in this app are organized in such a way that you remember which objective each question falls under",
                                  multiText: true,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    })),
          ],
        ),
      ),
    );
  }
}
