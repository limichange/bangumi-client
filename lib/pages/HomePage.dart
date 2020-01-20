import 'package:bangumi/components/AnimeListItem.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text("半谷米"),
        ),
        body: ListView.builder(
          itemCount: 7,
          itemBuilder: (context, int index) {
            return AnimeListItem();
          },
        ));
  }
}
