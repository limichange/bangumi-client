import 'package:bangumi/src/state/AnimeLogStatusData.dart';
import 'package:bangumi/src/state/GlobalData.dart';
import 'package:flutter/material.dart';
import 'package:bangumi/src/pages/MainPage.dart';
import 'package:bangumi/src/reportError.dart';
import 'package:provider/provider.dart';

void main() async {
  try {
    runApp(MultiProvider(providers: [
      ChangeNotifierProvider(create: (content) => GlobalData()),
      ChangeNotifierProvider(create: (content) => AnimeLogStatusData())
    ], child: MyApp()));
  } catch (error, stackTrace) {
    reportError(error, stackTrace);
  }
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
        fontFamily: 'Heiti SC',
        brightness: Brightness.light,
        primaryColor: Colors.pink[300],
        accentColor: Colors.pink[300],
      ),
      home: MyHomePage(title: '半谷米'),
    );
  }
}
