

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:prep50/models/exam_board.dart';
import 'package:provider/provider.dart';

import '../utils/color.dart';
import '../utils/preps_icons_icons.dart';
import '../utils/text.dart';
import '../view-models/info-screen-view-model.dart';
import 'app_button.dart';

class ExamBoardsBottomSheet extends StatefulWidget {
  const ExamBoardsBottomSheet({Key? key}) : super(key: key);

  @override
  State<ExamBoardsBottomSheet> createState() => _ExamBoardsBottomSheetState();

  static Future showExamBoardBottomSheet(context) {
    return showModalBottomSheet<void>(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      context: context,
      isDismissible: false,
      enableDrag: false,
      builder: (BuildContext context) {
        return ExamBoardsBottomSheet();
      },
    );
  }
}

class _ExamBoardsBottomSheetState extends State<ExamBoardsBottomSheet> {
  FToast? fToast;
  String selectedExamBoard = "";

  _showToast({String message="Error occurred"}) {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: kPrimaryColor,
      ),
      child:AppText.captionTextM(message,color: Colors.white,),
    );

    //Show the toast message
    fToast?.showToast(
      child: toast,
      gravity: ToastGravity.CENTER,
      toastDuration: Duration(seconds: 2),
    );
  }

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast?.init(context);
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children:[
        Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              )),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child:FutureBuilder<List<ExamBoard>>(
                future:Provider.of<InfoScreenViewModel>(context, listen: false).getAllExamBoards(),
                builder: (context,AsyncSnapshot<List<ExamBoard>> snapshot){
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
                        _showToast(message: "${snapshot.error}");
                      });
                      log("${snapshot.error}");
                      return Center(
                              child:AppButton(
                                title: "Load Exam Boards",
                                width: 197,
                                color: true,
                                onTap: () => {
                                  setState(() {})
                                },
                              ),
                            );
                    }

                    if(snapshot.hasData) {
                      List<ExamBoard> examBoardsList = snapshot.data==null ? []:snapshot.data!;
                      InfoScreenViewModel infoScreenViewModel = Provider.of<InfoScreenViewModel>(context, listen: false);
                      infoScreenViewModel.setExamBoardList=examBoardsList;
                      List<String> examBoardsStringList = examBoardsList.map((examBoard) => examBoard.name).toList();
                      selectedExamBoard=examBoardsStringList.first;
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(height: 10,),
                          AppText.captionTextM("Select Examination Board"),
                          SizedBox(height: 10,),
                          AppText.textField("The examination board you select would help us filter through subjects that relates to your syllabus",multiText: true,centered: true,),
                          SizedBox(height: 10,),
                          DropdownButton(
                              icon: Icon(Icons.arrow_drop_down),
                              value: selectedExamBoard,
                              items: examBoardsStringList.map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Row(
                                    children: [
                                      Icon(PrepsIcons.circle),
                                      Text(value),
                                    ],
                                  ),
                                );
                              }).toList(),
                              onChanged: (value){
                                selectedExamBoard = value.toString();
                              }
                          ),
                          SizedBox(height: 10,),
                          AppButton(
                            title: "Continue",
                            color: true,
                            width: 150,
                            onTap: () => Navigator.pop(context,selectedExamBoard),
                          ),
                        ],
                      );
                    }
                  }
                  return Center(
                    child: SizedBox(width:30,height: 30,child: CircularProgressIndicator(color: kPrimaryColor,)),
                  );
                }
            ),
          ),
        ),
      ]
    );
  }
}
