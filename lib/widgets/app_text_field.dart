import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextField extends StatefulWidget {

  AppTextField({
    Key? key,
    required this.hText,
    this.showSuffixIcon: false,
    this.icons: false,
    this.showPrefixIcon: false,
    this.maxLines,
    this.height,
    this.color,
    this.validator,
    this.onChanged,
    this.textInputType,
    this.obscureText:false,
    this.autocorrect:true,
    this.enableSuggestions:true,
    this.showInfoTooltip = false,
    this.tooltipText="",
    this.errorText
  }) : super(key: key);
  final String hText;
  final bool showSuffixIcon;
  final bool icons;
  final bool showPrefixIcon;
  final int? maxLines;
  final double? height;
  final Color? color;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;
  final TextInputType? textInputType;
  bool obscureText;
  final bool enableSuggestions;
  final bool autocorrect;
  final bool showInfoTooltip;
  final String tooltipText;
  final String? errorText;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  final GlobalKey<TooltipState> tooltipkey = GlobalKey<TooltipState>();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: widget.color ?? Color(0xffF7F7F7),
      ),
      child: TextFormField(
        maxLines: widget.maxLines,
        validator: widget.validator,
        obscureText: widget.obscureText,
        enableSuggestions: widget.enableSuggestions,
        autocorrect: widget.autocorrect,
        keyboardType: widget.textInputType,
        onChanged: widget.onChanged,
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
          errorText: widget.errorText,
          contentPadding: const EdgeInsets.all(5),
          border: OutlineInputBorder(borderSide: BorderSide.none),
          hintText: widget.hText,
          hintStyle: GoogleFonts.sarabun(
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),

          prefixIconConstraints: widget.showPrefixIcon
              ? BoxConstraints(maxWidth: 40, minWidth: 40)
              : BoxConstraints(maxWidth: 4, minWidth: 3),
          prefixIcon: widget.showPrefixIcon
              ? Icon(Icons.search)
              : SizedBox(
                  width: 0,
                  height: 0,
                ),
          suffixIcon: widget.showSuffixIcon
              ? widget.icons
                  ? IconButton(
                        icon:Icon(widget.obscureText?Icons.visibility:Icons.visibility_off_rounded)
                        ,onPressed:() {
                          setState(() {
                            widget.obscureText = !widget.obscureText;
                          });
                        },
                    )
                  : widget.showInfoTooltip ? _showTooltipEnableIcon(widget.tooltipText): Icon(Icons.info_outline_rounded)
              : SizedBox(),
        ),
      ),
    );
  }

  _showTooltipEnableIcon(String tooltipText) {
    return Tooltip(
      key: tooltipkey,
      message:tooltipText,
      padding: EdgeInsets.symmetric(vertical: 15,horizontal: 15),
      margin: EdgeInsets.symmetric(horizontal: 20.0),
      child: IconButton(
        icon: Icon(Icons.info_outline_rounded),
        onPressed: (){
          tooltipkey.currentState?.ensureTooltipVisible();
        },
      ),
      decoration: BoxDecoration(
        color: Colors.black,
          borderRadius: BorderRadius.circular(10),
      ),
      textStyle: TextStyle(color: Colors.white),
      triggerMode: TooltipTriggerMode.manual,
    );
  }
}
