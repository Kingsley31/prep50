import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:prep50/storage/app_data.dart';


class WelcomeScreenViewModel extends ChangeNotifier{
  final AppData _appData = AppData();

  Future<String> getUserName() async{
    final userJson = await _appData.getUser();
    print(jsonEncode(userJson));
    String username = userJson !=null ? userJson['username'].toString() : "";
    print(username);
    return username;
  }

}