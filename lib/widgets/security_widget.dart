import 'package:flutter/material.dart';
import 'package:prep50/utils/text.dart';
class SecurityWidget extends StatelessWidget {
  const SecurityWidget(
      {Key? key,
        required this.title,
        required this.subtitle})
      : super(key: key);
  final String title;
  final String subtitle;
  @override
  Widget build(BuildContext context) {

    return Container(
      height: 71,
      width: double.infinity,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: (
        Row(
          children: [
            Container(
              color: Color(0xffFFF4F0),
              height: 40,
              width: 40,
              child: (
              Icon(Icons.lock_rounded,
              color: Color(0xffFF4201),)
              ),
            ),
            SizedBox(
              width: 8,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText.heading6S(title),
                SizedBox(height: 2),
                AppText.captionText(subtitle),
              ],
            ),
            Spacer(),
            Icon(Icons.arrow_forward_ios_outlined),
          ],
        )
        ),
      ),
    );
  }
}
