
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:prep50/models/payment_response.dart';

import '../constants/string_data.dart';
import '../utils/prep50_api_utils.dart';


class PaymentService{
  final String baseUrl = BASE_URL;

  Future<PaymentResponse> verifyPayment({required String type,required String reference})async{
    final String verifyPaymentEndpoint = "/pay-verify";
    final String accessToken = await getApiToken();
    print(accessToken);
    final response = await http.post(
      Uri.parse('$baseUrl$verifyPaymentEndpoint'),
      headers: <String, String>{
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "type":type,
        "reference":reference
      }),
    );

    if(response.statusCode==200){
      final jsonResponse = jsonDecode(response.body);
      return PaymentResponse.fromJson(jsonResponse);
    }

    throw Exception("Unable to verify payment, is the device online?");
  }


}