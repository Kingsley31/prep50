

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:prep50/models/exam_board.dart';
import 'package:provider/provider.dart';

import '../utils/color.dart';
import '../utils/preps_icons_icons.dart';
import '../utils/text.dart';
import '../view-models/examboard_bottom_sheet_viewmodel.dart';
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
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ExamBoardBottomSheetViewModel examBoardBottomSheetViewModel=Provider.of<ExamBoardBottomSheetViewModel>(context,listen: false);
      examBoardBottomSheetViewModel.loadExamBoard();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(children: [
      Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            )),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Consumer<ExamBoardBottomSheetViewModel>(
              builder: (context,examBoardBottomSheetViewModel,child) {

                  if (examBoardBottomSheetViewModel.errorMessage.isNotEmpty) {
                    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                      _showToast(message: "${examBoardBottomSheetViewModel.errorMessage}");
                    });
                    log("${examBoardBottomSheetViewModel.errorMessage}");
                    return Center(
                      child: AppButton(
                        title: "Load Exam Boards",
                        width: 197,
                        color: true,
                        onTap: () => {examBoardBottomSheetViewModel.loadExamBoard()},
                      ),
                    );
                  }

                  if (examBoardBottomSheetViewModel.isLoadingExamBoard==false && examBoardBottomSheetViewModel.examBoardList.isNotEmpty) {
                    List<ExamBoard> examBoardsList = examBoardBottomSheetViewModel.examBoardList;
                    InfoScreenViewModel infoScreenViewModel =
                        Provider.of<InfoScreenViewModel>(context,
                            listen: false);
                    infoScreenViewModel.setExamBoardList = examBoardsList;
                    List<String> examBoardsStringList = examBoardsList
                        .map((examBoard) => examBoard.name)
                        .toList();

                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: 10,
                        ),
                        AppText.captionTextM("Select Examination Board"),
                        SizedBox(
                          height: 10,
                        ),
                        AppText.textField(
                          "The examination board you select would help us filter through subjects that relates to your syllabus",
                          multiText: true,
                          centered: true,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        DropdownButton(
                            icon: Icon(Icons.arrow_drop_down),
                            value: selectedExamBoard.isNotEmpty?selectedExamBoard:examBoardsStringList.first,
                            items: examBoardsStringList
                                .map<DropdownMenuItem<String>>((String value) {
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
                            onChanged: (value) {
                              print(value);
                              setState(() {
                                selectedExamBoard = value.toString();
                              });

                            }),
                        SizedBox(
                          height: 10,
                        ),
                        AppButton(
                          title: "Continue",
                          color: true,
                          width: 150,
                          onTap: () {
                              if(selectedExamBoard.isEmpty){
                                selectedExamBoard=examBoardsStringList.first;
                              }
                              List<ExamBoard> examBoardsList = examBoardBottomSheetViewModel.examBoardList;
                              ExamBoard examBoard = examBoardsList.firstWhere((eb) => eb.name == selectedExamBoard);
                              Navigator.pop(context, examBoard);
                          },
                        ),
                      ],
                    );
                  }

                return Center(
                  child: SizedBox(
                      width: 30,
                      height: 30,
                      child: CircularProgressIndicator(
                        color: kPrimaryColor,
                      )),
                );
              }),
        ),
      ),
    ]);
  }
}
