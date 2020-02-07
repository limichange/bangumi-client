import 'package:bangumi/src/components/AnimeListItem.dart';
import 'package:bangumi/src/model/Anime.dart';
import 'package:flutter/material.dart';

class NewAnimeList extends StatelessWidget {
  List data = [];

  NewAnimeList({this.data});

  buildList() {
    if (data == null) return [Container()];

    return data.map(
      (e) {
        print(e);
        return Container(
          child: AnimeListItem(
            anime: Anime.fromJson(e['anime']),
          ),
        );
      },
    ).toList();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(children: buildList()),
      ),
    );
  }
}
