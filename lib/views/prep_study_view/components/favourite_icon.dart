


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prep50/utils/color.dart';

class FavouriteIcon extends StatelessWidget {
  final bool colored;
  final bool isFavourite;
  final Function()? onTap;

  const FavouriteIcon({Key? key,required this.colored,required this.isFavourite,this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: colored? kPrimaryColor.shade300 : Colors.white12,
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        child: isFavourite?Icon(Icons.favorite,color: kPrimaryColor,):Icon(Icons.favorite_border_outlined,color: Colors.white,),
      ),
    );
  }
}
