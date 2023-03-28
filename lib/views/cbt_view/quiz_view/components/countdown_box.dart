import 'package:flutter/material.dart';
import 'package:prep50/views/cbt_view/quiz_view/components/time_box.dart';

class CountdownBox extends StatelessWidget {
  // const CountdownBox({ Key key }) : super(key: key);

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
                TimeBox(item: "00", time: "Days"),
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
                TimeBox(item: "00", time: "Hour"),
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
                TimeBox(item: "00", time: "Minute"),
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
                TimeBox(item: "00", time: "Second"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
