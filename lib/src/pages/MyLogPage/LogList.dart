import 'package:bangumi/src/api/API.dart';
import 'package:bangumi/src/pages/MyLogPage/AnimeListItem.dart';
import 'package:bangumi/src/utils/Utils.dart';
import 'package:flutter/material.dart';

class LogList extends StatefulWidget {
  String status;

  LogList({this.status});

  @override
  _LogList createState() {
    return _LogList();
  }
}

class _LogList extends State<LogList> {
  var data;
  List _list = [];

  Future loadData() async {
    var res = await new API().myAnimeLog(widget.status);
    List list = new List();

    print(res);

    if (res['status'] == 200) {
      res['data']['data'].forEach((e) {
//        list.add(Anime.fromJson(e));
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

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: reload,
      child: ListView.builder(
        itemCount: _list.length,
        itemBuilder: (context, int index) {
          return Text('asdf'); //AnimeListItem(anime: _list[index]);
        },
      ),
    );
  }
}
