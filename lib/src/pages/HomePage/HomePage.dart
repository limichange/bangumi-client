import 'package:bangumi/src/api/API.dart';
import 'package:bangumi/src/components/AnimeListItem.dart';
import 'package:bangumi/src/model/Anime.dart';
import 'package:bangumi/src/pages/SearchPage/SearchPage.dart';
import 'package:bangumi/src/utils/Utils.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePage createState() {
    print('createState page');
    return _HomePage();
  }
}

class _HomePage extends State<HomePage> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  List<Anime> _list = new List<Anime>();

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future loadData() async {
    var res = await api.getAnimeHome();
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
    Utils.go(context, SearchPage(searchStr: string));
  }

  createList() {
    return _list.map((i) {
      return AnimeListItem(key: ValueKey(i.uuid + 'AnimeListItem'), anime: i);
    }).toList();
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
              child: ListView(
                key: ObjectKey(_list),
                children: <Widget>[
                  Column(
                    children: createList(),
                  )
                ],
              ),
            ),
          )
        ]));
  }
}
