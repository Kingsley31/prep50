import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:prep50/models/faq.dart';
import 'package:prep50/models/support_contact.dart';
import 'package:prep50/utils/exceptions.dart';
import '../constants/string_data.dart';
import '../utils/prep50_api_utils.dart';

class SystemInfoServices{
  final String baseUrl = BASE_URL;

  Future<SupportContact> getSupportContact()async{
    final String accessToken = await getApiToken();
    final String supportContactEndpoint= "/support/contacts";
    final response = await http.get(
      Uri.parse('$baseUrl$supportContactEndpoint'),
      headers: < String, String>{
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      },
    );

    if(response.statusCode == 200){
      final jsonResponse = jsonDecode(response.body);
      SupportContact supportContact=SupportContact.fromJson(jsonResponse["data"]);
      return supportContact;
    }
    throw ValidationException(message: "Error fetching support details, is the device online", errors: []);
  }

  Future<List<Faq>> getFaqList()async{
    final String accessToken = await getApiToken();
    final String faqListEndpoint="/support/faq";
    final response = await http.get(
      Uri.parse('$baseUrl$faqListEndpoint'),
      headers: < String, String>{
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      },
    );

    if(response.statusCode == 200){
      final jsonResponse = jsonDecode(response.body);
      print(jsonResponse);
      final List<dynamic> faqsJsonList = jsonResponse["data"];
      print(faqsJsonList);
      final List<Faq> faqsList = faqsJsonList.map((faqJson) => Faq.fromJson(faqJson)).toList();
      return faqsList;
    }

    throw ValidationException(message: "Error fetching faqs, is the device online", errors: []);
  }

  Future<String> getTermsOfService()async{
    final String accessToken = await getApiToken();
    final String termsOfServicesString = "/terms";
    final response = await http.get(
      Uri.parse('$baseUrl$termsOfServicesString'),
      headers: < String, String>{
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      },
    );

    if(response.statusCode == 200){
      final jsonResponse = jsonDecode(response.body);
      String termsOfService=jsonResponse["data"];
      return termsOfService;
    }
    throw ValidationException(message: "Error fetching terms of service, is the device online", errors: []);
  }
}