import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:prep50/utils/color.dart';
import 'package:prep50/utils/text.dart';
import 'package:prep50/views/prep_study_view/tutorial_view/topics_screen.dart';
import 'package:prep50/widgets/app_button.dart';

class SubjectContainer extends StatelessWidget {
  const SubjectContainer(
      {Key? key,
      required this.color,
      required this.title,
      required this.subject,
      this.passmark,
      this.passcolor: false,
      this.subtitle,
      this.selected: false,
      this.time})
      : super(key: key);
  final String title;
  final String? time;
  final String subject;
  final String? subtitle;
  final String? passmark;
  final bool selected;
  final bool passcolor;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => diplayBottomSheet(context),
      child: Column(
        children: [
          Container(
            height: 75,
            width: double.infinity,
            color: Color(0xffffffff),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        color: color, borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: AppText.heading6(
                        title,
                        color: Color(0xffffffff),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppText.heading6(
                        subject,
                        color: Color(0xff000000),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      subtitle == null
                          ? SizedBox()
                          : AppText.captionText(
                              "$subtitle",
                              color: kAccentColor[400],
                            ),
                    ],
                  ),
                  Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        width: 32,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color:
                                passcolor ? kSuccessLight : kErrorLightColor),
                        child: Center(
                          child: Text(
                            passmark!,
                            style: GoogleFonts.sarabun(
                                color: passcolor ? kSuccessColor : kErrorColor,
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                letterSpacing: -0.04),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      time == null
                          ? SizedBox()
                          : Row(
                              children: [
                                Icon(
                                  Icons.lock_clock,
                                  size: 10,
                                ),
                                SizedBox(
                                  width: 5.33,
                                ),
                                AppText.captionText(
                                  "$time",
                                  color: kAccentColor[400],
                                ),
                              ],
                            ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  diplayBottomSheet(context) {
    return showMaterialModalBottomSheet(
      context: context,
      builder: (context) => SingleChildScrollView(
        controller: ModalScrollController.of(context),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 35),
          child: Column(
            children: [
              Container(
                  height: 1,
                  width: 72,
                  decoration: BoxDecoration(
                      color: Color(0xffe0e0e0),
                      borderRadius: BorderRadius.circular(10))),
              SizedBox(height: 10),
              Container(
                height: 48,
                // width: 206,
                decoration: BoxDecoration(
                  color: Color(0xfff7f7f7),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 22,
                            width: 22,
                            color: kSuccessColor,
                            child: Center(
                                child: Icon(
                              Icons.check,
                              color: Color(0xffffffff),
                              size: 10,
                            )),
                          ),
                          SizedBox(width: 10),
                          AppText.captionTextS(
                            "You selected ",
                            color: Color(0xff666666),
                          ),
                          AppText.captionTextS(
                            "Government",
                            color: Color(0xff212121),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 49),
                child: AppText.textField(
                  "Kindly select your exam board so we can help you read according to syllabus.",
                  multiText: true,
                  centered: true,
                ),
              ),
              SizedBox(height: 20),
              AppText.captionText("Exam Board", color: Color(0xfffadadad)),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 49, vertical: 11),
                child: Container(
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(5)),
                  child: DropdownButton(
                    hint: AppText.captionText("Select Exam Board",
                        color: Color(0xfffadadad)),
                    icon: Icon(Icons.keyboard_arrow_down,
                        color: Color(0xff323232)),
                    isExpanded: true,
                    underline: SizedBox(),
                    dropdownColor: Color(0xffffffff),
                    items: [
                      DropdownMenuItem(
                        child: Text("JAMB"),
                        value: "JAMB",
                      ),
                      DropdownMenuItem(
                        child: Text("WAEC"),
                        value: "WAEC",
                      ),
                    ],
                    onChanged: (dynamic s) {},
                  ),
                ),
              ),
              AppButton(
                title: "Continue",
                width: 197,
                color: true,
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => TopicScreen())),
              )
            ],
          ),
        ),
      ),
    );
  }
}
