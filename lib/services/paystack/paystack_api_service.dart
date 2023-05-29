
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:prep50/constants/string_data.dart';
import 'package:prep50/services/paystack/models/payment_initialization_response.dart';

import 'models/payment_verification_response.dart';

class PaystackApiService{
  
  Future<PaymentInitializationResponse> initializePayment({required String email,required String amount})async{
    Uri url = Uri.parse("https://api.paystack.co/transaction/initialize");
    final http.Response response = await http.post(
        url,
        headers: <String, String>{
        'Authorization': 'Bearer $PAYSTACK_SECRETE_KEY',
        'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "email":email,
          "amount":amount,
          "callback_url":PAYSTACK_CALLBACK_URL
        })
    );

    if(response.statusCode==200){
      final jsonResponse = jsonDecode(response.body);
      return PaymentInitializationResponse.fromJson(jsonResponse);
    }
    throw Exception("Unable to initialize transaction, is the device online?");
  }


  Future<PaymentVerificationResponse> verifyPayment({required String reference})async{
    Uri url = Uri.parse("https://api.paystack.co/transaction/verify/$reference");
    final http.Response response = await http.get(
        url,
        headers: <String, String>{
          'Authorization': 'Bearer $PAYSTACK_SECRETE_KEY',
          'Content-Type': 'application/json',
        },
    );

    if(response.statusCode==200){
      final jsonResponse = jsonDecode(response.body);
      return PaymentVerificationResponse.fromJson(jsonResponse);
    }
    if(response.statusCode==400){
      throw Exception("Invalid key");
    }
    throw Exception("Unable to verify transaction, is the device online?");
  }
}