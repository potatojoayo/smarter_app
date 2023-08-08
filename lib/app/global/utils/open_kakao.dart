import 'package:flutter/foundation.dart';
import 'package:kakao_flutter_sdk_talk/kakao_flutter_sdk_talk.dart';

void openKakao() async {
  final url = await TalkApi.instance.channelChatUrl('_jxhIxkxj');
  try {
    await launchBrowserTab(url);
  } catch (error) {
    if (kDebugMode) {
      print('카카오톡 채널 채팅 실패 $error');
    }
  }
}
