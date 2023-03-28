import 'package:flutter/material.dart';
import 'package:prep50/utils/text.dart';

class QuestionBox extends StatelessWidget {
  // const QuestionBox({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      // width: 343,
      // height: 72,
      decoration: BoxDecoration(
          color: Color(0xffffffff), borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Row(
          children: [
            Radio(
              value: "in",
              groupValue: "22",
              onChanged: (dynamic value) {},
            ),
            AppText.heading6("Dr. Philaphlous David in 1880")
          ],
        ),
      ),
    );
  }
}
