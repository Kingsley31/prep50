import 'package:flutter/material.dart';
import 'package:prep50/utils/color.dart';
import 'package:prep50/utils/text.dart';

class HomeCard extends StatelessWidget {
  // const HomeCard({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 105),
          Container(
            height: 433,
            color: Color(0xffffffff),
            width: double.infinity,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xff666666),
                        ),
                      ),
                      SizedBox(width: 8),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppText.heading6S(
                              "Unillorin State University",
                              color: Color(0xff666666),
                            ),
                            SizedBox(height: 8),
                            Row(
                              children: [
                                Icon(
                                  Icons.alarm,
                                  size: 10,
                                  color: Color(0xffadadad),
                                ),
                                SizedBox(width: 5),
                                AppText.captionText(
                                  "3 days ago",
                                  color: Color(0xffadadad),
                                ),
                              ],
                            ),
                          ]),
                      Spacer(),
                      DropdownButton(
                        icon: Icon(
                          Icons.more_horiz_outlined,
                          color: Color(0xff323232),
                        ),
                        underline: SizedBox(),
                        dropdownColor: Color(0xffffffff),
                        items: [
                          DropdownMenuItem(
                            child: Text("Report"),
                            value: "report",
                          ),
                          DropdownMenuItem(
                            child: Text("Share"),
                            value: "share",
                          ),
                        ],
                        onChanged: (dynamic s) {},
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: AppText.textField(
                    "When it came near enough he perceived that it was not"
                    " grass; there were no blades, but only purple roots. The"
                    " roots were revolving, for each small plant in the whole"
                    " patch,like the spokes of a rimless wheel.😇😇",
                    multiText: true,
                  ),
                ),
                SizedBox(height: 8),
                Container(
                  height: 248,
                  width: 343,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          image: AssetImage("assets/png/homecarditem.png"))),
                ),
                SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Container(
                        height: 36,
                        width: 36,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: kErrorLightColor,
                        ),
                        child: Icon(
                          Icons.thumb_up,
                          size: 20,
                          color: kPrimaryColor,
                        ),
                      ),
                      SizedBox(width: 16),
                      Container(
                        height: 36,
                        width: 36,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xfff7f7f7),
                        ),
                        child: Icon(
                          Icons.thumb_up,
                          size: 20,
                          color: Color(0xff212121),
                        ),
                      ),
                      SizedBox(width: 16),
                      Container(
                        height: 36,
                        width: 36,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xfff7f7f7),
                        ),
                        child: Icon(
                          Icons.thumb_up,
                          size: 20,
                          color: Color(0xff212121),
                        ),
                      ),
                      Spacer(),
                      Container(
                        height: 36,
                        width: 36,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: kErrorLightColor,
                        ),
                        child: Icon(
                          Icons.thumb_up,
                          size: 20,
                          color: kPrimaryColor,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
