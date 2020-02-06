import 'package:bangumi/src/api/API.dart';
import 'package:bangumi/src/model/Anime.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  String searchStr;

  SearchPage({this.searchStr});

  @override
  State<StatefulWidget> createState() {
    return _SearchPage();
  }
}

class _SearchPage extends State<SearchPage> {
  var _list = [];

  search(string) async {
    print(string);
    List<Anime> list = new List<Anime>();

    var res = await api.searchAnime(string, 1);

    print(res['data']['rows']);

    res['data']['rows'].forEach((e) {
      list.add(Anime.fromJson(e));
    });

    setState(() {
      _list = list;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text("搜索"),
        ),
        body: Container());
  }
}
