import 'package:bangumi/src/api/API.dart';
import 'package:bangumi/src/components/NormalImage.dart';
import 'package:bangumi/src/model/Anime.dart';
import 'package:bangumi/src/pages/AnimeDetailPage.dart';
import 'package:bangumi/src/utils/Utils.dart';
import 'package:flutter/material.dart';

class LogList extends StatefulWidget {
  LogList({this.status}) : super(key: UniqueKey());

  String status;

  @override
  _LogList createState() {
    return _LogList();
  }
}

class _LogList extends State<LogList> with AutomaticKeepAliveClientMixin {
  var data;
  List _list = [];
  num total;
  num _page = 1;

  @override
  initState() {
    super.initState();

    loadmore();
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

      return {'list': list, 'total': res['data']['pages']['total']};
    } else {
      Utils.showToast(context: context, text: res['message']);
      return {'list': _list, 'total': total};
    }
  }

  Future reload() async {
    var res = await loadData();

    setState(() {
      _page = 1;
      total = res['total'];
      _list = res['list'];
    });
  }

  Future loadmore() async {
    var res = await loadData();

    setState(() {
      _page = _page + 1;
      total = res['total'];
      _list = res['list'];
    });
  }

  onTap(Anime info) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AnimeDetailPage(uuid: info.uuid)),
    );
  }

  List<Container> _buildGridTileList() => _list.map((i) {
        var width = MediaQuery.of(context).size.width * 0.3;

        return Container(
          width: width,
          margin:
              EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.025),
          padding: EdgeInsets.only(top: 10),
          child: GestureDetector(
            onTap: () {
              Utils.goAnimeDetail(context, i.uuid);
            },
            child: Column(children: <Widget>[
              Container(
                  height: width * 1.45,
                  width: width,
                  child: NormalImage(url: i.cover)),
              Container(
                  width: width,
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
          ),
        );
      }).toList();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Stack(
      children: <Widget>[
        Container(
          child: RefreshIndicator(
            onRefresh: reload,
            child: Container(
              child: ListView(
                key: UniqueKey(),
                children: <Widget>[
                  Container(
                    width: width,
                    padding: EdgeInsets.only(bottom: 100),
                    child: Wrap(
                      children: _buildGridTileList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        // count panel
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

  @override
  bool get wantKeepAlive => true;
}
