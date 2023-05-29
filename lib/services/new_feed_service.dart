import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:prep50/models/news_feed.dart';
import 'package:prep50/models/news_feed_filter.dart';
import 'package:prep50/models/news_feed_list_item.dart';
import '../constants/string_data.dart';
import '../utils/exceptions.dart';
import '../utils/prep50_api_utils.dart';

class NewsFeedService{
  String _baseUrl = BASE_URL;

  Future<List<NewsFeedListItem>> getNewsFeedItemList({required NewsFeedFilter filter})async{
    final String accessToken = await getApiToken();
    String newsFeedListEndpoint = "/newsfeed?trending=${filter.trending}&newest=${filter.newest}&oldest=${filter.oldest}";
    final response = await http.get(
        Uri.parse("$_baseUrl$newsFeedListEndpoint"),
        headers: < String, String>{
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        }
    );

    if(response.statusCode == 200){
      final jsonResponse = jsonDecode(response.body);
      final List<dynamic> newsFeedJsonList = jsonResponse["data"];
      print(newsFeedJsonList);
      final List<NewsFeedListItem> newsFeedList = newsFeedJsonList.map((newsFeedJson) => NewsFeedListItem.fromJson(newsFeedJson)).toList();
      return newsFeedList;
    }

    throw ValidationException(message: "Error fetching news feeds, is the device online", errors: []);
  }

  Future<NewsFeed> getNewsFeed({required String slug})async{
    final String accessToken = await getApiToken();
    String newsFeedEndpoint = "/newsfeed/view?slug=${slug}";
    final response = await http.get(
        Uri.parse("$_baseUrl$newsFeedEndpoint"),
        headers: < String, String>{
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        }
    );

    if(response.statusCode == 200){
      final jsonResponse = jsonDecode(response.body);
      print(jsonResponse["data"]);
      NewsFeed newsFeed = NewsFeed.fromJson(jsonResponse["data"]);
      return newsFeed;
    }
    throw ValidationException(message: "Error fetching news feed, is the device online", errors: []);
  }

  Future<Map<String,dynamic>> postComment({required String slug,required String comment})async{
    final String accessToken = await getApiToken();
    String commentEndpoint = "/newsfeed/comment";
    final response = await http.post(
        Uri.parse("$_baseUrl$commentEndpoint"),
        headers: < String, String>{
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "slug":slug,
          "comment":comment
        })
    );

    if(response.statusCode == 200){
      final jsonResponse = jsonDecode(response.body);
      return jsonResponse;
    }
    throw ValidationException(message: "Error posting comment, is the device online", errors: []);
  }

  Future<Map<String,dynamic>> updateComment({required String commentId,required String comment})async{
    final String accessToken = await getApiToken();
    String commentEndpoint = "/newsfeed/comment";
    final response = await http.put(
        Uri.parse("$_baseUrl$commentEndpoint"),
        headers: < String, String>{
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "id":commentId,
          "comment":comment
        })
    );

    if(response.statusCode == 200){
      final jsonResponse = jsonDecode(response.body);
      return jsonResponse;
    }
    throw ValidationException(message: "Error posting comment, is the device online", errors: []);
  }

  Future<Map<String,dynamic>> reportComment({required String type,required String commentId,required String message})async{
    final String accessToken = await getApiToken();
    String commentEndpoint = "/newsfeed/report-comment";
    final response = await http.put(
        Uri.parse("$_baseUrl$commentEndpoint"),
        headers: < String, String>{
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "id":commentId,
          "type":type,
          "message":message
        })
    );

    if(response.statusCode == 200){
      final jsonResponse = jsonDecode(response.body);
      return jsonResponse;
    }
    throw ValidationException(message: "Error posting comment, is the device online", errors: []);
  }

  Future<Map<String,dynamic>> likePost({required String slug,required bool liked})async{
    final String accessToken = await getApiToken();
    String likeEndpoint = "/newsfeed/like";
    final response = await http.post(
        Uri.parse("$_baseUrl$likeEndpoint"),
        headers: < String, String>{
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "slug":slug,
          "like":liked
        })
    );

    if(response.statusCode == 200){
      final jsonResponse = jsonDecode(response.body);
      return jsonResponse;
    }
    throw ValidationException(message: "Error liking post, is the device online", errors: []);
  }

  Future<Map<String,dynamic>> bookMarkPost({required String slug,required bool bookmarked})async{
    final String accessToken = await getApiToken();
    String bookmarkEndpoint = "/newsfeed/bookmark";
    final response = await http.post(
        Uri.parse("$_baseUrl$bookmarkEndpoint"),
        headers: < String, String>{
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "slug":slug,
          "bookmark":bookmarked
        })
    );

    if(response.statusCode == 200){
      final jsonResponse = jsonDecode(response.body);
      return jsonResponse;
    }
    throw ValidationException(message: "Error bookmarking post, is the device online", errors: []);
  }

  Future<Map<String,dynamic>> reportPost({required String slug,required String type,required String message})async{
    final String accessToken = await getApiToken();
    String bookmarkEndpoint = "/newsfeed";
    final response = await http.post(
        Uri.parse("$_baseUrl$bookmarkEndpoint"),
        headers: < String, String>{
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "slug":slug,
          "type":type,
          "message":message
        })
    );

    if(response.statusCode == 200){
      final jsonResponse = jsonDecode(response.body);
      return jsonResponse;
    }

    if(response.statusCode == 202){
      final jsonResponse = jsonDecode(response.body);
      throw ValidationException(message: jsonResponse["message"], errors: []);
    }
    throw ValidationException(message: "Error bookmarking post, is the device online", errors: []);
  }
}