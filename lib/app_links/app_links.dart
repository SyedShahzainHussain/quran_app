import 'dart:developer';

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/foundation.dart';

class AppLinks {
  Future createLink() async {
    final dynamicLinkParams = DynamicLinkParameters(
      link: Uri.parse("https://www.google.com/home"),
      uriPrefix: "https://syeds.page.link",
      androidParameters: AndroidParameters(
        packageName: "com.example.holy_quran_app",
        minimumVersion: 30,
        fallbackUrl: Uri.parse("https://www.google.com"),
      ),
    );
    try {
      final dynamicLink =
          await FirebaseDynamicLinks.instance.buildShortLink(dynamicLinkParams);
      final dynamicLinkUri = dynamicLink.shortUrl.toString();
      log("Dynamic Link URL: $dynamicLinkUri");
    } catch (e) {
      log("Error creating dynamic link: $e");
    }
  }

  initData() {
    FirebaseDynamicLinks.instance.onLink.listen(
        (PendingDynamicLinkData dynamicLinkData) {
      final Uri deepLink = dynamicLinkData.link;
      if (kDebugMode) {
        print("deep link: ${deepLink.toString()}");
        print("deep link query parameters: ${deepLink.queryParameters}");
      }
    }, onError: (error) {
      print("Error handling dynamic link: $error");
    });
  }
}
