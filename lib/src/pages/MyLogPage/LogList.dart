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
  num total;

  @override
  initState() {
    super.initState();

    loadData();
  }

  Future loadData() async {
    var res = await new API().myAnimeLog(widget.status);
    List list = new List();

    //    pages: { total: 21, perPage: 20, page: 1, lastPage: 2 },
    print(res);

    if (res['status'] == 200) {
      res['data']['rows'].forEach((e) {
        list.add(Anime.fromJson(e));
      });

      setState(() {
        total = res['data']['pages']['total'];
        _list = list;
      });
    } else {
      Utils.showToast(context: context, text: res['message']);
    }
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
                Container(
                    width: 120, height: 160, child: Image.network(i.cover)),
                Container(
                    width: 120,
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
      padding: EdgeInsets.only(top: 10, bottom: 10),
      crossAxisCount: 3,
      childAspectRatio: 0.7,
      shrinkWrap: true,
      children: _buildGridTileList());

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
            child: RefreshIndicator(
                onRefresh: reload,
                child: Container(
                  child: _buildGrid(),
                ))),
        new Positioned(
            left: 10.0,
            bottom: 10.0,
            child: new Container(
              width: 60.0,
              decoration: new BoxDecoration(
                color: Colors.pink[300],
                borderRadius: new BorderRadius.all(new Radius.circular(4.0)),
                boxShadow: [
                  new BoxShadow(
                      color: Colors.black26,
                      blurRadius: 12.0,
                      spreadRadius: 1.0)
                ],
              ),
              child: new Text(
                total.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            )),
      ],
    );
  }
}
