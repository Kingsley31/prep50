import 'package:flutter/material.dart';
import 'package:prep50/utils/text.dart';

class QuestionBox extends StatelessWidget {
  final String value;
  final String? groupValue;
  final Function(String?)? onChanged;
  String? text;

  QuestionBox({Key? key,required this.value,this.groupValue,this.onChanged, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      // width: 343,
      // height: 72,
      decoration: BoxDecoration(
          color: Color(0xffffffff), borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Row(
          children: [
            Radio(
              value: value,
              groupValue: groupValue,
              onChanged: onChanged,
            ),
            Expanded(child: AppText.heading6(text,multiText: true,))
          ],
        ),
      ),
    );
  }
}
