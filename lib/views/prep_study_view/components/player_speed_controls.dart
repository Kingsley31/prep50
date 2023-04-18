

import 'package:flutter/material.dart';
import 'package:prep50/utils/color.dart';
import 'package:prep50/utils/text.dart';

enum PlayerSpeed{ zeroX ,oneX,twoX}
class PlayerSpeedControls extends StatelessWidget {
  final PlayerSpeed currentPlayerSpeed;
  final Function(PlayerSpeed playerSpeed)? playerSpeedChanged;
  const PlayerSpeedControls({Key? key,required this.currentPlayerSpeed,this.playerSpeedChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage("assets/png/player_speed_control_container.png"))
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _buildZeroxButton(),
          Spacer(),
          _buildOnexButton(),
          Spacer(),
          _buildTwoxButton(),
        ],
      ),
    );
  }

 Widget _buildZeroxButton() {
    return currentPlayerSpeed == PlayerSpeed.zeroX 
        ? 
    Container(
      padding: EdgeInsets.symmetric(horizontal: 8,vertical: 4),
      decoration: BoxDecoration(
        color: kPrimaryColor,
        borderRadius: BorderRadius.all(Radius.circular(8))
      ),
      child: AppText.textFieldM("0.1x",color: Colors.white,),
    )
        :
        GestureDetector(
          onTap:(){
            playerSpeedChanged!(PlayerSpeed.zeroX);
          } ,
          child: AppText.textFieldM("0.1x",color: Colors.white,),
        );
 }

 Widget _buildOnexButton() {
   return currentPlayerSpeed == PlayerSpeed.oneX
       ?
   Container(
     padding: EdgeInsets.symmetric(horizontal: 8,vertical: 4),
     decoration: BoxDecoration(
         color: kPrimaryColor,
         borderRadius: BorderRadius.all(Radius.circular(8))
     ),
     child: AppText.textFieldM("0.2x",color: Colors.white,),
   )
       :
   GestureDetector(
     onTap:(){
       playerSpeedChanged!(PlayerSpeed.oneX);
     } ,
     child: AppText.textFieldM("0.2x",color: Colors.white,),
   );
 }

 Widget _buildTwoxButton() {
   return currentPlayerSpeed == PlayerSpeed.twoX
       ?
   Container(
     padding: EdgeInsets.symmetric(horizontal: 8,vertical: 4),
     decoration: BoxDecoration(
         color: kPrimaryColor,
         borderRadius: BorderRadius.all(Radius.circular(8))
     ),
     child: AppText.textFieldM("0.3x",color: Colors.white,),
   )
       :
   GestureDetector(
     onTap:(){
       playerSpeedChanged!(PlayerSpeed.twoX);
     } ,
     child: AppText.textFieldM("0.3x",color: Colors.white,),
   );
 }
}
