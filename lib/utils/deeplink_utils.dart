
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:prep50/views/authentication_view/create_account_screen.dart';
import 'package:prep50/views/home_view/single_feed_screen.dart';

import '../constants/string_data.dart';

Future<void> loadInitiallyReceivedLink(context)async{
  print("Called loadInitiallyReceivedLink");
  final PendingDynamicLinkData? initialLink = await FirebaseDynamicLinks.instance.getInitialLink();

  if (initialLink != null) {
    final Uri deepLink = initialLink.link;
    navigate(deepLink, context);
  }

}

void listenForDeepLinkEvent(context){
  print("Called listenForDeepLinkEvent");
  FirebaseDynamicLinks.instance.onLink.listen(
        (pendingDynamicLinkData) {
          print("Got a link");
          final Uri deepLink = pendingDynamicLinkData.link;
          // Example of using the dynamic link to push the user to a different screen
          navigate(deepLink, context);
    },
  );
}

void navigate(Uri deepLink,context){
  String path = deepLink.path;
  print(deepLink.queryParameters["referer"]);
  print("Path: $path");
  if(path == "/register"){
    String refererUsername = deepLink.queryParameters["referer"]??"";
    Navigator.of(context).push( MaterialPageRoute(builder: (context)=> CreateAccount(refererUserName:refererUsername)));
  }else if(path == "/feeds"){
    String slug = deepLink.queryParameters["slug"]??"";
    Navigator.of(context).push( MaterialPageRoute(builder: (context)=> SingleFeedScreen(slug:slug)));
  }
}

Future<String> buildRefererLink(String username)async{
  final dynamicLinkParams = DynamicLinkParameters(
    link: Uri.parse("$REGISTRATION_ENDPOINT?referer=$username"),
    uriPrefix: "$DYNAMIC_LINK_URL_PREFIX",
    androidParameters: const AndroidParameters(
      packageName: "com.prep50.prep50",
    ),
    iosParameters: const IOSParameters(
      bundleId: "com.prep50.prep50",
      appStoreId: "123456789",
      minimumVersion: "1.0.1",
    ),
  );
  final dynamicLink = await FirebaseDynamicLinks.instance.buildShortLink(dynamicLinkParams);
  return dynamicLink.shortUrl.toString();
}

Future<String> buildFeedLink(String slug)async{
  final dynamicLinkParams = DynamicLinkParameters(
    link: Uri.parse("$FEEDS_ENDPOINT?slug=$slug"),
    uriPrefix: "$DYNAMIC_LINK_URL_PREFIX",
    androidParameters: const AndroidParameters(
      packageName: "com.prep50.prep50",
    ),
    iosParameters: const IOSParameters(
      bundleId: "com.example.app.ios",
      appStoreId: "123456789",
      minimumVersion: "1.0.1",
    ),
  );
  final dynamicLink = await FirebaseDynamicLinks.instance.buildShortLink(dynamicLinkParams);
  return dynamicLink.shortUrl.toString();
}