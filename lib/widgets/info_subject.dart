import 'package:flutter/material.dart';
import 'package:prep50/utils/color.dart';
import 'package:prep50/utils/text.dart';

class Subjects extends StatefulWidget {
  const Subjects(
      {Key? key,required this.title, this.selected,required this.id,this.onSelected})
      : super(key: key);
  final String title;
  final bool? selected;
  final String id;
  final Function(String,bool)? onSelected;

  @override
  _SubjectsState createState() => _SubjectsState();
}

class _SubjectsState extends State<Subjects> {
  bool selected = false;
  changeSelected() {
    setState(() {
      selected = !selected;
      widget.onSelected!(widget.id,selected);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: changeSelected,
      child: Container(
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: widget.selected ?? selected
              ? kPrimaryColor.shade300
              : kLighterGreyShadeColour,
          borderRadius: BorderRadius.circular(10),
        ),
        child: AppText.heading6(
          widget.title,
          color: widget.selected ?? selected ? kPrimaryColor : kBlackColor,
        ),
      ),
    );
  }
}
