import 'package:bangumi/src/api/API.dart';
import 'package:bangumi/src/components/NormalImage.dart';
import 'package:bangumi/src/model/Anime.dart';
import 'package:bangumi/src/pages/AnimeDetailPage/AnimeDetailPage.dart';
import 'package:bangumi/src/utils/Utils.dart';
import 'package:flutter/material.dart';

class LogList extends StatefulWidget {
  LogList({this.status, @required Key key}) : super(key: key);

  String status;

  @override
  _LogList createState() {
    return _LogList(status: status);
  }
}

class _LogList extends State<LogList> {
  var data;
  List _list = [];
  num total;
  num _page = 0;
  bool _isLoading = false;
  String _loadType = '';
  num _lastPage = 1;
  String status;

  _LogList({this.status});

  @override
  initState() {
    super.initState();

    reload();
  }

  Future loadData() async {
    setState(() {
      _isLoading = true;
    });

    var res = await new API().myAnimeLog(widget.status, _page + 1);

    print(res);

    if (!mounted) return;

    //    pages: { total: 21, perPage: 20, page: 1, lastPage: 2 },
    setState(() {
      _isLoading = false;
    });

    if (res['status'] == 200) {
      List list = [];

      res['data']['rows'].forEach((e) {
        list.add(Anime.fromJson(e));
      });

      setState(() {
        total = res['data']['pages']['total'];
        _lastPage = res['data']['pages']['lastPage'];
      });

      res['animeList'] = list;

      return res;
    } else {
      Utils.showToast(context: context, text: res['message']);
      return {'status': 400};
    }
  }

  Future reload() async {
    if (_isLoading || !mounted) return;

    setState(() {
      _loadType = 'reload';
      _page = 0;
    });

    var res = await loadData();

    if (res == null || res['status'] != 200) return;

    setState(() {
      _list = res['animeList'];
    });
  }

  Future loadmore() async {
    if (_isLoading || _page >= _lastPage) return;

    setState(() {
      _loadType = 'loadmore';
      _page = _page + 1;
    });

    var res = await loadData();

    if (res['status'] != 200) return;

    res['animeList'].forEach((e) {
      _list.add(e);
    });

    setState(() {
      _list = _list;
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
                  child: NormalImage(
                    url: i.cover,
                    key: ValueKey(i.cover),
                  )),
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
          child: NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification scrollInfo) {
              if (!_isLoading &&
                  scrollInfo.metrics.pixels ==
                      scrollInfo.metrics.maxScrollExtent) {
                loadmore();
              }

              return true;
            },
            child: RefreshIndicator(
              onRefresh: reload,
              child: ListView(
                key: PageStorageKey(status),
                children: <Widget>[
                  Container(
                    width: width,
                    child: Wrap(
                      children: _buildGridTileList(),
                    ),
                  ),
                  Container(
                    height: 100,
                    child: Center(
                      child: _isLoading && _loadType == 'loadmore'
                          ? CircularProgressIndicator()
                          : Container(),
                    ),
                  )
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
}
