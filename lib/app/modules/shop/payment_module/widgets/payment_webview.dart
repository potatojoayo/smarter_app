import 'dart:developer' as dev;
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smarter/app/global/extensions/uri_extension.dart';
import 'package:smarter/app/global/theme/theme.dart';
import 'package:smarter/app/global/utils/show_snack_bar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

/// 토스 결제가 진행되는 웹뷰입니다.
class PaymentWebView extends StatelessWidget {
  /// 결제창의 타이틀
  final String? title;

  /// 실제 결제가 진행되는 웹페이지 URL
  final Uri paymentRequestUrl;

  /// 웹뷰 콜백 onPageStarted
  final Function(String url)? onPageStarted;

  /// 웹뷰 콜백 onPageFinished
  final Function(String url)? onPageFinished;

  /// 결제창이 dispose 될 때 콜백
  final Function()? onDisposed;

  /// 닫힘 버튼을 탭했을 때 콜백
  final Function()? onTapCloseButton;

  final Function(WebViewController controller)? onWebViewCreated;

  const PaymentWebView({
    Key? key,
    this.title,
    this.onPageStarted,
    this.onPageFinished,
    this.onDisposed,
    this.onTapCloseButton,
    required this.paymentRequestUrl,
    required this.onWebViewCreated,
    required this.onSuccess,
  }) : super(key: key);

  final Function onSuccess;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          title ?? "",
          style: TextStyle(color: Get.theme.primaryColorDark, fontSize: 17),
        ),
        elevation: 0,
        actions: [
          InkWell(
            onTap: onTapCloseButton,
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
        initialUrl: paymentRequestUrl.toString(),
        onPageStarted: onPageStarted,
        javascriptChannels: <JavascriptChannel>{
          JavascriptChannel(
              name: 'Fail',
              onMessageReceived: (m) {
                Get.back();
                showSnackBar(m.message);
              }),
          JavascriptChannel(
              name: 'Success',
              onMessageReceived: (m) {
                onSuccess();
              })
        },
        onPageFinished: onPageFinished,
        onWebViewCreated: onWebViewCreated,
        navigationDelegate: (request) async {
          Uri uri = Uri.parse(request.url);
          // url 이 웹뷰에 유효하다면 해당 url 로 이동한다.
          if (uri.scheme == 'http' ||
              uri.scheme == 'https' ||
              uri.scheme == 'about') {
            return NavigationDecision.navigate;
          }

          // url 이 웹뷰에 유효하지 않다면 해당 url 로 이동하지 않는다.
          dev.log("NavigationDecision = ${request.url}",
              name: "WebView.navigationDelegate");

          String url = request.url;

          if (Platform.isAndroid) {
            Uri tossPayment = UriExtension.androidIntentUrlOrigin(request.url);
            url = tossPayment.toString();
          }

          launchUrl(Uri.parse(url));

          return NavigationDecision.prevent;
        },
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
