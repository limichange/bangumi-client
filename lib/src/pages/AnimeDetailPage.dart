import 'package:flutter/material.dart';

class AnimeDetailPage extends StatelessWidget {
  String uuid = "";

  AnimeDetailPage({this.uuid});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text("半谷米"),
        ),
        body: Column(children: <Widget>[
          Container(
            child: Text(uuid),
          ),
          Container(),
        ]));
  }
}
