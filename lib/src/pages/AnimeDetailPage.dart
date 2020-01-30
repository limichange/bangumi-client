import 'package:bangumi/src/api/API.dart';
import 'package:bangumi/src/components/NormalImage.dart';
import 'package:bangumi/src/components/StatusSelectButton.dart';
import 'package:bangumi/src/model/Anime.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class AnimeDetailPage extends StatefulWidget {
  String uuid = "";

  AnimeDetailPage({this.uuid});

  @override
  _AnimeDetailPage createState() {
    return _AnimeDetailPage();
  }
}

class _AnimeDetailPage extends State<AnimeDetailPage> {
  Anime _anime = Anime(cover: '', name: '', desc: '', uuid: '');

  @override
  void initState() {
    super.initState();

    loadData();
  }

  loadData() async {
    var res = await new API().AnimeDetail(widget.uuid);
    Anime anime;

    if (res['status'] == 200) {
      anime = Anime.fromJson(res['data']);
    }

    setState(() {
      _anime = anime;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text("详情"),
        ),
        body: Column(children: <Widget>[
          Container(
            padding: EdgeInsets.all(12),
            child: Center(
              child: Container(
                width: 220,
                height: 280,
                child: NormalImage(url: _anime.cover),
              ),
            ),
          ),
          Container(
            child: Text(
              _anime.name,
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                GestureDetector(
                  child: Text(
                    _anime.desc,
                  ),
                ),
              ],
            ),
          ),
          StatusSelectButton(key: UniqueKey(), uuid: widget.uuid)
        ]));
  }
}
