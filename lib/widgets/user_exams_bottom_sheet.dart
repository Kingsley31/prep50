


import 'package:flutter/material.dart';

import '../models/user_exam.dart';
import '../utils/preps_icons_icons.dart';
import '../utils/text.dart';
import 'app_button.dart';

class UserExamsBottomSheet extends StatefulWidget {
  const UserExamsBottomSheet({Key? key, required this.userExamList}) : super(key: key);
  final List<UserExam> userExamList;
  @override
  State<UserExamsBottomSheet> createState() => _UserExamsBottomSheetState();

  static Future showExamBoardBottomSheet(context,List<UserExam> userExamList) {
    return showModalBottomSheet<void>(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      context: context,
      isDismissible: false,
      enableDrag: false,
      builder: (BuildContext context) {
        return UserExamsBottomSheet(userExamList:userExamList);
      },
    );
  }
}

class _UserExamsBottomSheetState extends State<UserExamsBottomSheet> {

  String selectedExam = "";


  @override
  Widget build(BuildContext context) {
    List<String> userExamStringList = widget.userExamList
        .map((userExam) => userExam.exam)
        .toList();
    return Wrap(children: [
      Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            )),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              AppText.captionTextM("Select Examination Board"),
              SizedBox(
                height: 10,
              ),
              AppText.textField(
                "The examination board you select would help us filter through subjects that relates to your syllabus",
                multiText: true,
                centered: true,
              ),
              SizedBox(
                height: 10,
              ),
              DropdownButton(
                  icon: Icon(Icons.arrow_drop_down),
                  value: selectedExam.isNotEmpty?selectedExam:userExamStringList.first,
                  items: userExamStringList
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Row(
                        children: [
                          Icon(PrepsIcons.circle),
                          Text(value),
                        ],
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    print(value);
                    setState(() {
                      selectedExam = value.toString();
                    });

                  }),
              SizedBox(
                height: 10,
              ),
              AppButton(
                title: "Continue",
                color: true,
                width: 150,
                onTap: () {
                  if(selectedExam.isEmpty){
                    selectedExam=userExamStringList.first;
                  }
                  UserExam userExam = widget.userExamList.firstWhere((eb) => eb.exam == selectedExam);
                  Navigator.pop(context, userExam);
                },
              ),
            ],
          ),
        ),
      ),
    ]);
  }
}
