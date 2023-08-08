import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:smarter/app/global/extensions/uri_extension.dart';
import 'package:smarter/app/global/theme/theme.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AddressWebView extends StatelessWidget {
  const AddressWebView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "도로명 주소 검색",
          style: TextStyle(color: Get.theme.primaryColorDark, fontSize: 17),
        ),
        elevation: 0,
        actions: [
          InkWell(
            onTap: () => Get.back(),
            child: Container(
              padding: const EdgeInsets.all(16),
              child: const Icon(
                Icons.close,
                color: textColor,
              ),
            ),
          )
        ],
      ),
      body: WebView(
        initialUrl: '${dotenv.env['BASE_URL']!}/authentication/address',
        onWebViewCreated: (webViewController) {},
        navigationDelegate: (request) async {
          Uri uri = Uri.parse(request.url);
          // url 이 웹뷰에 유효하다면 해당 url 로 이동한다.
          if (uri.scheme == 'http' ||
              uri.scheme == 'https' ||
              uri.scheme == 'about') {
            return NavigationDecision.navigate;
          }

          String url = request.url;

          if (Platform.isAndroid) {
            Uri addressUrl = UriExtension.androidIntentUrlOrigin(request.url);
            url = addressUrl.toString();
          }

          launchUrl(Uri.parse(url));

          return NavigationDecision.prevent;
        },
        javascriptMode: JavascriptMode.unrestricted,
        javascriptChannels: <JavascriptChannel>{_javascriptChannel()},
      ),
    );
  }
}

JavascriptChannel _javascriptChannel() {
  return JavascriptChannel(
      name: 'messageHandler',
      onMessageReceived: (JavascriptMessage message) {
        Get.back(result: message.message);
      });
}
