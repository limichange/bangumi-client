import 'package:bangumi/src/pages/AnimeDetailPage/AnimeDetailPage.dart';
import 'package:bangumi/src/utils/Utils.dart';
import 'package:flutter/material.dart';
import 'package:jpush_flutter/jpush_flutter.dart';

class JPushServer {
  static JPush jpush;

  static init(context) {
    jpush = new JPush();

    jpush.addEventHandler(
      // 接收通知回调方法。
      onReceiveNotification: (Map<String, dynamic> message) async {
        print("flutter onReceiveNotification: $message");
      },
      // 点击通知回调方法。
      onOpenNotification: (Map<String, dynamic> message) async {
//        print("flutter onOpenNotification: $message");

        print(message['extras']['\$attributes']['id']);

        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => AnimeDetailPage(
                  uuid: message['extras']['\$attributes']['uuid'])),
        );
      },
      // 接收自定义消息回调方法。
      onReceiveMessage: (Map<String, dynamic> message) async {
        print("flutter onReceiveMessage: $message");
      },
    );

    jpush.setup(
      appKey: "37aa445df9565c858ab3e9ab",
      channel: "mainChannel",
      production: true,
      debug: true, // 设置是否打印 debug 日志
    );

    jpush.applyPushAuthority(
        new NotificationSettingsIOS(sound: true, alert: true, badge: true));
  }

  static getRegistrationID() async {
    try {
      String rid = await jpush.getRegistrationID();
      return rid;
    } catch (e) {
      return null;
    }
  }
}
