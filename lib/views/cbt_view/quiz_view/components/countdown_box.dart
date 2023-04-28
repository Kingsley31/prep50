import 'dart:async';

import 'package:flutter/material.dart';
import 'package:prep50/views/cbt_view/quiz_view/components/time_box.dart';

class CountdownBox extends StatelessWidget {
  final Duration countDown;

  const CountdownBox({Key? key,required this.countDown}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 103,
      width: 344,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TimeBox(item: "${countDown.inDays>=10?countDown.inDays:"0${countDown.inDays}"}", time: "Days"),
                SizedBox(width: 8),
                Column(
                  children: [
                    Container(
                      width: 5,
                      height: 5,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xff666666),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: 5,
                      height: 5,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xff666666),
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 8),
                TimeBox(item: "${countDown.inHours>=10?countDown.inHours:"0${countDown.inHours}"}", time: "Hour"),
                SizedBox(width: 8),
                Column(
                  children: [
                    Container(
                      width: 5,
                      height: 5,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xff666666),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: 5,
                      height: 5,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xff666666),
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 8),
                TimeBox(item: "${countDown.inMinutes>=10?countDown.inMinutes:"0${countDown.inMinutes}"}", time: "Minute"),
                SizedBox(width: 8),
                Column(
                  children: [
                    Container(
                      width: 5,
                      height: 5,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xff666666),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: 5,
                      height: 5,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xff666666),
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 8),
                TimeBox(item: "${countDown.inSeconds>=10?countDown.inSeconds:"0${countDown.inSeconds}"}", time: "Second"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
