import 'package:flutter/material.dart';
import 'package:prep50/constants/text_style.dart';

class AppText extends StatelessWidget {
  final String? text;
  final TextStyle style;
  final bool multiText;
  final bool centered;

  AppText.heading1(this.text,
      {color: Colors.black, this.multiText: false, this.centered: false})
      : style = heading1RegularStyle.copyWith(color: color);

  AppText.heading1M(this.text,
      {color: Colors.black, this.multiText: false, this.centered: false})
      : style = heading1MediumStyle.copyWith(color: color);

  AppText.heading1S(this.text,
      {color: Colors.black, this.multiText: false, this.centered: false})
      : style = heading1SemiBoldStyle.copyWith(color: color);

  AppText.heading2(this.text,
      {color: Colors.black, this.multiText: false, this.centered: false})
      : style = heading2RegularStyle.copyWith(color: color);

  AppText.heading2M(this.text,
      {color: Colors.black, this.multiText: false, this.centered: false})
      : style = heading2MediumStyle.copyWith(color: color);

  AppText.heading2S(this.text,
      {color: Colors.black, this.multiText: false, this.centered: false})
      : style = heading2SemiBoldStyle.copyWith(color: color);

  AppText.heading3(this.text,
      {color: Colors.black, this.multiText: false, this.centered: false})
      : style = heading3RegularStyle.copyWith(color: color);

  AppText.heading3M(this.text,
      {color: Colors.black, this.multiText: false, this.centered: false})
      : style = heading3MediumStyle.copyWith(color: color);

  AppText.heading3S(this.text,
      {color: Colors.black, this.multiText: false, this.centered: false})
      : style = heading3SemiBoldStyle.copyWith(color: color);

  AppText.heading4(this.text,
      {color: Colors.black, this.multiText: false, this.centered: false})
      : style = heading4RegularStyle.copyWith(color: color);

  AppText.heading4M(this.text,
      {color: Colors.black, this.multiText: false, this.centered: false})
      : style = heading4MediumStyle.copyWith(color: color);

  AppText.heading4S(this.text,
      {color: Colors.black, this.multiText: false, this.centered: false})
      : style = heading4SemiBoldStyle.copyWith(color: color);

  AppText.heading5(this.text,
      {color: Colors.black, this.multiText: false, this.centered: false})
      : style = heading5RegularStyle.copyWith(color: color);

  AppText.heading5M(this.text,
      {color: Colors.black, this.multiText: false, this.centered: false})
      : style = heading5MediumStyle.copyWith(color: color);

  AppText.heading5S(this.text,
      {color: Colors.black, this.multiText: false, this.centered: false})
      : style = heading5SemiBoldStyle.copyWith(color: color);

  AppText.heading6(this.text,
      {color: Colors.black, this.multiText: false, this.centered: false})
      : style = heading6RegularStyle.copyWith(color: color);

  AppText.heading6M(this.text,
      {color: Colors.black, this.multiText: false, this.centered: false})
      : style = heading6MediumStyle.copyWith(color: color);

  AppText.heading6S(this.text,
      {color: Colors.black, this.multiText: false, this.centered: false})
      : style = heading6SemiBoldStyle.copyWith(color: color);

  AppText.textField(this.text,
      {color: Colors.black, this.multiText: false, this.centered: false})
      : style = textFieldRegularStyle.copyWith(color: color);

  AppText.textFieldM(this.text,
      {color: Colors.black, this.multiText: false, this.centered: false})
      : style = textFieldMediumStyle.copyWith(color: color);

  AppText.textFieldS(this.text,
      {color: Colors.black, this.multiText: false, this.centered: false})
      : style = textFieldSemiBoldStyle.copyWith(color: color);

  AppText.captionText(this.text,
      {color: Colors.black, this.multiText: false, this.centered: false})
      : style = captionTextStyleRegular.copyWith(color: color);

  AppText.captionTextM(this.text,
      {color: Colors.black, this.multiText: false, this.centered: false})
      : style = captionTextStyleMedium.copyWith(color: color);

  AppText.captionTextS(this.text,
      {color: Colors.black, this.multiText: false, this.centered: false})
      : style = captionTextStyleSemiBold.copyWith(color: color);

  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      maxLines: multiText ? 9999999999 : 1,
      overflow: TextOverflow.ellipsis,
      softWrap: false,
      textAlign: centered ? TextAlign.center : TextAlign.left,
      style: style,
    );
  }
}
