import 'package:flutter/material.dart';
import 'package:prep50/utils/color.dart';
import 'package:prep50/utils/text.dart';

class StudyWidget extends StatelessWidget {
  // const StudyWidget({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      Container(
        width: double.infinity,
        color: Color(0XFFFFFFFF),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 40,
                width: 203,
                decoration: BoxDecoration(
                    color: Color(0xfffff4f0),
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      AppText.heading6M(
                        "Concept of Government",
                        color: kPrimaryColor,
                      ),
                      SizedBox(
                        width: 14.42,
                      ),
                      Icon(
                        Icons.arrow_downward_outlined,
                        color: kPrimaryColor,
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 35),
              Column(children: [
                Container(
                    height: 798,
                    width: double.infinity,
                    child: Column(children: [
                      Row(
                        children: [
                          Expanded(
                              child: AppText.heading6M(
                            "A government is the system or group of people governing an organized community,"
                            " generally a state.",
                            multiText: true,
                            color: Color(0xff666666),
                          )),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                              child: AppText.heading6M(
                            " In the case of its broad associative definition, government normally consists of legislature, executive, and judiciary. Government is a means by which organizational policies are enforced, "
                            "as well as a mechanism for determining policy. Each government has a kind of constitution,"
                            "a statement of its governing principles and philosophy.",
                            multiText: true,
                            color: Color(0xff666666),
                          )),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                              child: AppText.heading6M(
                            "  While all types of organizations have "
                            "governance, the term government is often used more specifically, to refer to the "
                            "approximately 200 independent national governments and subsidiary organizations..",
                            multiText: true,
                            color: kInfoColor,
                          )),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                              child: AppText.heading6M(
                            "  Historically "
                            " prevalent forms of government include monarchy, aristocracy, timocracy, oligarchy, democracy, "
                            "theocracy and tyranny. The main aspect of any philosophy of government is how political power"
                            " is obtained, with the two main forms being electoral contest and hereditary succession.",
                            multiText: true,
                            color: Color(0xff666666),
                          )),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                              child: AppText.heading5M(
                            " The territories of Government",
                            multiText: true,
                          )),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                              child: AppText.heading6M(
                            " In the case of its broad associative definition, government normally "
                            "consists of legislature, executive, and judiciary. Government is a means "
                            "by which organizational policies are enforced, as well as a mechanism for "
                            "determining policy. Each government has a kind of constitution, a statement "
                            "of its governing principles and philosophy.",
                            multiText: true,
                            color: Color(0xff666666),
                          )),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                              child: AppText.heading5M(
                            " Similarities of Government",
                            multiText: true,
                          )),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                              child: AppText.heading6M(
                            " In the case of its broad associative definition, government normally "
                            "consists of legislature, executive, and judiciary. Government is a means "
                            "by which organizational policies are enforced, as well as a mechanism for "
                            "determining policy. Each government has a kind of constitution, a statement "
                            "of its governing principles and philosophy.",
                            multiText: true,
                            color: Color(0xff666666),
                          )),
                        ],
                      ),
                    ]))
              ]),
            ],
          ),
        ),
      ),
    ]);
  }
}
