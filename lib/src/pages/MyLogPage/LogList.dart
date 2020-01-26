import 'package:bangumi/src/api/API.dart';
import 'package:bangumi/src/model/Anime.dart';
import 'package:bangumi/src/utils/Utils.dart';
import 'package:flutter/material.dart';

class LogList extends StatefulWidget {
  LogList({Key key, this.status}) : super(key: key);

  String status;

  @override
  _LogList createState() {
    return _LogList();
  }
}

class _LogList extends State<LogList> {
  var data;
  List _list = [];

  @override
  initState() {
    super.initState();

    loadData();
  }

  Future loadData() async {
    var res = await new API().myAnimeLog(widget.status);
    List list = new List();

    print(res);

    if (res['status'] == 200) {
      res['data']['rows'].forEach((e) {
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

  List<Container> _buildGridTileList() => _list.map((i) {
        return Container(
            height: 300,
            width: 160,
            child: Center(
              child: Column(children: <Widget>[
                Container(width: 120, child: Image.network(i.cover)),
                Container(
                    padding: EdgeInsets.only(top: 4),
                    child: Text(i.name,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        )))
              ]),
            ));
      }).toList();

  Widget _buildGrid() => GridView.count(
      crossAxisCount: 3,
      childAspectRatio: 0.7,
      shrinkWrap: true,
      children: _buildGridTileList());

  @override
  Widget build(BuildContext context) {
    return Container(
        child: RefreshIndicator(
            onRefresh: reload,
            child: Container(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              child: _buildGrid(),
            )));
  }
}
