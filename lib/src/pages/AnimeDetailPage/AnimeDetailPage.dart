import 'dart:math';
import 'dart:ui';

import 'package:bangumi/src/api/API.dart';
import 'package:bangumi/src/components/AnimeListItem.dart';
import 'package:bangumi/src/components/NormalImage.dart';
import 'package:bangumi/src/components/StatusSelectButton.dart';
import 'package:bangumi/src/format.dart';
import 'package:bangumi/src/model/Anime.dart';
import 'package:bangumi/src/model/Episode.dart';
import 'package:bangumi/src/pages/AnimeDetailPage/EpisodeCard.dart';
import 'package:bangumi/src/pages/FeedbackPage/FeedbackPage.dart';
import 'package:bangumi/src/utils/Utils.dart';
import 'package:flutter/material.dart';

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
  List<Episode> episodes = new List();
  bool _isLoading = true;
  List<dynamic> tags = [];
  List<dynamic> _list = [];

  @override
  void initState() {
    super.initState();

    reload();
  }

  Future reload() async {
    setState(() {
      episodes = [];
    });

    await loadData();
    await loadEpisodes();
  }

  loadEpisodes() async {
    var res = await api.getEpisodeByAnime(widget.uuid);

    var res2 = await api.getEpisodeLogsByAnime(widget.uuid);

    if (res['status'] == 200) {
      res['data']['episodes'].forEach((item) {
        Episode episode = Episode.fromJson(item);

        if (res2['status'] == 200) {
          res2['data'].forEach((i) {
            if (item['id'] == i['episodeId']) {
              print(i['status']);
              episode.logStatus = i['status'];
            }
          });
        }

        episodes.add(episode);
      });

      setState(() {
        episodes = episodes;
      });
    }
  }

  Future loadData() async {
    var res = await api.AnimeDetail(widget.uuid);
    Anime anime;

    if (res['status'] == 200) {
      anime = Anime.fromJson(res['data']);

      if (res['data']['tags'] != null && res['data']['tags'].length > 0) {
        var recommendsRes =
            await api.getAnimeByTag(res['data']['tags'][0]['uuid']);

        if (recommendsRes['status'] == 200) {
          print(recommendsRes['data']);

          recommendsRes['data']['data'].forEach((e) {
            _list.add(Anime.fromJson(e));
          });
        }

        tags = res['data']['tags'];
      }

      setState(() {
        _anime = anime;
      });
    }

    setState(() {
      print(1);
      _isLoading = false;
    });
  }

  episodesList() {
    return Row(
      children: episodes.map((episode) {
        return EpisodeCard(episode: episode);
      }).toList(),
    );
  }

  previewImageList() {
    return Container(
      child: Row(
        children: episodes.map((episode) {
          return Container(
            padding: const EdgeInsets.only(right: 8.0),
            width: 200,
            height: 120,
            child: NormalImage(url: episode.cover),
          );
        }).toList(),
      ),
    );
  }

  createRecommandsList() {
    return _list.map((i) {
      return AnimeListItem(key: ValueKey(i.uuid + 'AnimeListItem'), anime: i);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("详情"),
      ),
      body: _isLoading
          ? Container(
              height: 100,
              child: Center(
                child: CircularProgressIndicator(),
              ))
          : RefreshIndicator(
              onRefresh: reload,
              child: SingleChildScrollView(
                child: Column(children: <Widget>[
                  Container(
                    child: Stack(
                      children: <Widget>[
                        Opacity(
                          opacity: .6,
                          child: Container(
                            height: 140,
                            width: double.infinity,
                            child: NormalImage(url: _anime.cover),
                          ),
                        ),
                        Positioned.fill(
                          child: BackdropFilter(
                            filter: ImageFilter.blur(
                              sigmaX: 3,
                              sigmaY: 3,
                            ),
                            child: Container(
                              color: Colors.white10,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    transform: Matrix4.translationValues(0.0, -80.0, 0.0),
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(12),
                          child: Row(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.only(right: 12),
                                child: Center(
                                  child: Container(
                                    width: 160,
                                    height: 220,
                                    child: NormalImage(url: _anime.cover),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Expanded(
                                            child: StatusSelectButton(
                                                key: UniqueKey(),
                                                uuid: widget.uuid),
                                          ),
                                          Container(
                                            width: 58,
                                            padding: EdgeInsets.only(left: 8),
                                            child: RaisedButton(
                                              onPressed: () {
                                                Utils.go(
                                                    context,
                                                    FeedbackPage(
                                                      anime: _anime,
                                                    ));
                                              },
                                              child: Icon(
                                                Icons.feedback,
                                                size: 18,
                                                color: Colors.white,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(bottom: 6),
                                      child: Wrap(
                                        children: tags.map((tag) {
                                          return Container(
                                            padding: EdgeInsets.only(right: 4),
                                            child: Text(tag['value']),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                    Container(
                                      child: Container(
                                          child: Text(format
                                              .animeStatus(_anime.status))),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.only(left: 12, right: 12),
                          child: Text(
                            _anime.name,
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
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Container(
                            padding:
                                EdgeInsets.only(left: 10, top: 10, bottom: 10),
                            child: previewImageList(),
                          ),
                        ),
                        episodes.length > 0
                            ? Container(
                                padding: EdgeInsets.only(left: 12),
                                width: double.infinity,
                                child: Text(
                                  '共' + episodes.length.toString() + '集',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(fontSize: 16),
                                ),
                              )
                            : Container(),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Container(
                            padding:
                                EdgeInsets.only(left: 10, top: 10, bottom: 10),
                            child: episodesList(),
                          ),
                        ),
                        Container(
                          margin: new EdgeInsets.only(top: 10),
                        )
                      ],
                    ),
                  ),
                  Container(
                    transform: Matrix4.translationValues(0.0, -80.0, 0.0),
                    child: Column(
                      children: createRecommandsList(),
                    ),
                  )
                ]),
              ),
            ),
    );
  }
}
