import 'package:flutter/material.dart';
import 'package:prep50/utils/color.dart';

class AlertBox extends StatelessWidget {
  // const AlertBox({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52.73,
      width: 218.47,
      decoration: BoxDecoration(
        color: Color(0xffffffff),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(4.52),
            child: Container(
              height: 43.69,
              width: 43.69,
              decoration:
                  BoxDecoration(shape: BoxShape.circle, color: kPrimaryColor),
              child: Icon(
                Icons.notifications_active_rounded,
                color: Color(0xffffffff),
                size: 25,
              ),
            ),
          ),
          SizedBox(width: 25),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 12.05),
              Container(
                height: 9.04,
                width: 48.21,
                decoration: BoxDecoration(
                    color: Color(0xfffff4f0),
                    borderRadius: BorderRadius.circular(10)),
              ),
              SizedBox(height: 10.55),
              Container(
                height: 9.04,
                width: 75.33,
                decoration: BoxDecoration(
                    color: Color(0xfffff4f0),
                    borderRadius: BorderRadius.circular(10)),
              ),
            ],
          )
        ],
      ),
    );
  }
}
