import 'dart:async';

import 'package:bangumi/src/api/API.dart';
import 'package:bangumi/src/components/NormalImage.dart';
import 'package:bangumi/src/eventBus/UpdateMyLogListEvent.dart';
import 'package:bangumi/src/eventBus/eventBus.dart';
import 'package:bangumi/src/model/Anime.dart';
import 'package:bangumi/src/pages/AnimeDetailPage/AnimeDetailPage.dart';
import 'package:bangumi/src/utils/Utils.dart';
import 'package:flutter/material.dart';

class LogList extends StatefulWidget {
  LogList({this.status, @required Key key}) : super(key: key);

  String status;

  @override
  _LogList createState() {
    return _LogList();
  }
}

class _LogList extends State<LogList> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  var data;
  List _list = [];
  num total;
  num _page = 0;
  bool _isLoading = false;
  String _loadType = '';
  num _lastPage = 1;
  StreamSubscription _eventSub;

  @override
  initState() {
    super.initState();

    reload();

    print('init log list' + widget.status);

    _eventSub = eventBus.on<UpdateMyLogListEvent>().listen((event) {
      reload();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _eventSub.cancel();
  }

  Future loadData() async {
    setState(() {
      _isLoading = true;
    });

    var res = await api.myAnimeLog(widget.status, _page + 1);

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
      _lastPage = 1;
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

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Stack(
      key: ValueKey(widget.status),
      children: <Widget>[
        Container(
          key: ValueKey(widget.status),
          child: NotificationListener<ScrollNotification>(
            key: ValueKey(widget.status),
            onNotification: (ScrollNotification scrollInfo) {
              if (!_isLoading &&
                  scrollInfo.metrics.pixels ==
                      scrollInfo.metrics.maxScrollExtent) {
                loadmore();
              }

              return true;
            },
            child: RefreshIndicator(
              key: ValueKey(widget.status),
              onRefresh: reload,
              child: GridView.builder(
                  padding: EdgeInsets.only(
                      left: width * 0.0084, right: width * 0.0084),
                  itemCount: _list.length,
                  gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio:
                          (width * (0.3 + 0.01) / (width * 0.3 * 1.45 + 20)),
                      crossAxisCount: 3),
                  itemBuilder: (BuildContext context, int index) {
                    var i = _list[index];

                    return Container(
                      key: ObjectKey(i),
                      padding: EdgeInsets.only(
                        top: 10,
                      ),
                      child: GestureDetector(
                        onTap: () {
                          Utils.goAnimeDetail(context, i.uuid);
                        },
                        child: Column(children: <Widget>[
                          Container(
                              height: width * 0.3 * 1.45,
                              width: width * 0.3,
                              child: NormalImage(
                                url: i.cover,
                                key: ValueKey(i.cover),
                              )),
                          Container(
                              color: Colors.black12,
                              width: width * 0.3,
                              height: 20,
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
                  }),
//              child: ListView(
//                key: ValueKey(widget.status),
//                children: <Widget>[
//                  Wrap(
//                    key: ValueKey(widget.status),
//                    children: _buildGridTileList(),
//                  ),
//                  Container(
//                    height: 100,
//                    child: Center(
//                      child: _isLoading && _loadType == 'loadmore'
//                          ? CircularProgressIndicator()
//                          : Container(),
//                    ),
//                  )
//                ],
//              ),
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
