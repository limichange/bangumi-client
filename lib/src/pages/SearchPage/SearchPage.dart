import 'package:bangumi/src/api/API.dart';
import 'package:bangumi/src/components/AnimeListItem.dart';
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
  var searchStr = '';
  TextEditingController _textController = new TextEditingController();

  @override
  initState() {
    super.initState();

    search(widget.searchStr);
  }

  search(string) async {
    print(string);
    searchStr = string;
    _textController.value = TextEditingValue(text: string);
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

  Future reload() async {
    setState(() {
      _list = [];
    });

    await search(searchStr);
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
          title: Text("搜索"),
        ),
        body: Column(children: <Widget>[
          Container(
              padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: TextField(
                controller: _textController,
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
