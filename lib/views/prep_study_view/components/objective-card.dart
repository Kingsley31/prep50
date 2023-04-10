

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/color.dart';
import '../../../utils/text.dart';

class ObjectiveCard extends StatelessWidget {
  final Function()? onTap;
  final String objective;
  final String? passmark;
  final bool passColor;
  final bool showIcon;

  ObjectiveCard({Key? key,this.onTap,required this.objective,this.passmark,this.passColor:false,this.showIcon: false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: AppText.heading6(
                objective,
                color: Color(0xff666666),
                multiText: true,
              ),
            ),
            SizedBox(width: 20,),
            Container(
              height: 25,
              width: 32,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: passColor ? kSuccessLight : kErrorLightColor),
              child: Center(
                child: showIcon
                    ? Icon(Icons.play_arrow_outlined)
                    : Text(
                  passmark!,
                  style: GoogleFonts.sarabun(
                      color: passColor ? kSuccessColor : kErrorColor,
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      letterSpacing: -0.04),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
