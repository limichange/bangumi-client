import 'package:bangumi/src/api/API.dart';
import 'package:bangumi/src/pages/HomePage/AnimeListItem.dart';
import 'package:bangumi/src/model/Anime.dart';
import 'package:bangumi/src/utils/Utils.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  List<Anime> _list = new List<Anime>();

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future loadData() async {
    var res = await new API().getAnimeHome();
    List<Anime> list = new List<Anime>();

    if (res['status'] == 200) {
      res['data']['data'].forEach((e) {
        list.add(Anime.fromJson(e));
      });
    } else {
      Utils.showToast(context: context, text: res['message']);
    }

    setState(() {
      _list = list;
    });
  }

  Future reload() async {
    setState(() {
      _list = [];
    });
    await loadData();
  }

  search(string) async {
    print(string);
    List<Anime> list = new List<Anime>();

    var res = await new API().searchAnime(string, 1);

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
          title: Text("半谷米"),
        ),
        body: Column(children: <Widget>[
          Container(
              padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: TextField(
                onSubmitted: search,
                decoration: InputDecoration(hintText: '搜索'),
              )),
          Flexible(
            flex: 1,
            child: RefreshIndicator(
              onRefresh: reload,
              child: ListView.builder(
                itemCount: _list.length,
                itemBuilder: (context, int index) {
                  return AnimeListItem(anime: _list[index]);
                },
              ),
            ),
          )
        ]));
  }
}
