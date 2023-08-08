import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:new_version_plus/new_version_plus.dart';
import 'package:smarter/app/global/widgets/text.dart';
import 'package:url_launcher/url_launcher.dart';

import 'app/data/provider/client.dart';

Future<void> checkNewVersion() async {
  final newVersion = NewVersionPlus(
    iOSAppStoreCountry: 'kr',
  );
  final status = await newVersion.getVersionStatus();
  if (status!.canUpdate && !Get.routing.isBottomSheet!) {
    final url = Uri.parse(
        'https://smarter-config.s3.ap-northeast-2.amazonaws.com/config.json');
    final response = await http.get(url);
    final body = utf8.decode(response.bodyBytes);
    final baseUrl = jsonDecode(body)['baseUrl'];
    Client.init(baseUrl);
    Get.bottomSheet(
      WillPopScope(
        onWillPop: () async => false,
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25.0),
              topRight: Radius.circular(25.0),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const DefaultText('업데이트가 필요합니다.'),
              const SizedBox(
                height: 24,
              ),
              const DefaultText(
                '새로운 앱 버전이 출시되었습니다. 앱을 사용하시기 위해서는 업데이트가 필요합니다.',
                style: TextStyle(fontSize: 16),
                overflow: TextOverflow.visible,
              ),
              const SizedBox(
                height: 8,
              ),
              GestureDetector(
                onTap: () async {
                  if (Platform.isAndroid) {
                    await launchUrl(
                      Uri.parse('market://details?id=com.blocket.smarter'),
                      mode: LaunchMode.externalApplication,
                    );
                  } else {
                    await launchUrl(
                      Uri.parse('https://apps.apple.com/app/1641226640'),
                      mode: LaunchMode.externalApplication,
                    );
                  }
                  exit(0);
                },
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: DefaultText(
                    '업데이트하기',
                    style: TextStyle(
                        color: Get.theme.primaryColorDark, fontSize: 20),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      isDismissible: false,
      enableDrag: false,
    );
  }
}
