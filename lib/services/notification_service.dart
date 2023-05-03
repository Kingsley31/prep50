import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:prep50/models/notification_list_item.dart';
import '../constants/string_data.dart';
import '../utils/exceptions.dart';

class NotificationService{
  String _baseUrl = BASE_URL;

  Future<List<NotificationListItem>> getAllUserNotifications({required String accessCode})async{
    final String notificationListEndpoint = "/user/notifications";
    final response = await http.get(
        Uri.parse("$_baseUrl$notificationListEndpoint"),
        headers: < String, String>{
          'Authorization': 'Bearer $accessCode',
          'Content-Type': 'application/json',
        }
    );
    if(response.statusCode == 200){
      final jsonResponse = jsonDecode(response.body);
      final List<dynamic> notificatioJsonList = jsonResponse["data"];
      print(notificatioJsonList);
      final List<NotificationListItem> notificationList = notificatioJsonList.map((notificationListItemJson) => NotificationListItem.fromJson(notificationListItemJson)).toList();
      return notificationList;
    }

    throw ValidationException(message: "Error fetching your notifications, is the device online", errors: []);
  }

  Future<Map<String,dynamic>> registerDeviceToken({required String accessCode,required String token})async{
    final String notificationRegisterEndpoint = "/user/notifications";
    final response = await http.post(
        Uri.parse("$_baseUrl$notificationRegisterEndpoint"),
        headers: < String, String>{
          'Authorization': 'Bearer $accessCode',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "token":token
        })
    );

    if(response.statusCode == 200){
      final jsonResponse = jsonDecode(response.body);
      return jsonResponse;
    }
    throw ValidationException(message: "Error registering device token, is the device online", errors: []);
  }
  
}