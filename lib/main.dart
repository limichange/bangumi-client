import 'package:bangumi/src/state/AnimeLogStatusData.dart';
import 'package:bangumi/src/state/GlobalData.dart';
import 'package:flutter/material.dart';
import 'package:bangumi/src/pages/MainPage.dart';
import 'package:bangumi/src/reportError.dart';
import 'package:provider/provider.dart';
import 'package:jpush_flutter/jpush_flutter.dart';

void main() async {
  try {
    runApp(MultiProvider(providers: [
      ChangeNotifierProvider(create: (content) => GlobalData()),
      ChangeNotifierProvider(create: (content) => AnimeLogStatusData())
    ], child: MyApp()));
  } catch (error, stackTrace) {
    reportError(error, stackTrace);
  }

  JPush jpush = new JPush();

  jpush.addEventHandler(
    // 接收通知回调方法。
    onReceiveNotification: (Map<String, dynamic> message) async {
      print("flutter onReceiveNotification: $message");
    },
    // 点击通知回调方法。
    onOpenNotification: (Map<String, dynamic> message) async {
      print("flutter onOpenNotification: $message");
    },
    // 接收自定义消息回调方法。
    onReceiveMessage: (Map<String, dynamic> message) async {
      print("flutter onReceiveMessage: $message");
    },
  );

  jpush.setup(
    appKey: "37aa445df9565c858ab3e9ab",
    channel: "mainChannel",
    production: false,
    debug: true, // 设置是否打印 debug 日志
  );

  jpush.getRegistrationID().then((rid) {
    print(rid);
  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '半谷米',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        brightness: Brightness.light,
        primaryColor: Colors.pink[300],
        accentColor: Colors.pink[300],
      ),
      home: MyHomePage(title: '半谷米'),
    );
  }
}
