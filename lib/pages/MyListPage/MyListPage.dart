import 'package:flutter/material.dart';

class MyListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text("我的收藏"),
        ),
        body: (Container(
          child: Column(
            children: <Widget>[
              Text(
                '我的收藏2',
              ),
            ],
          ),
        )));
  }
}
