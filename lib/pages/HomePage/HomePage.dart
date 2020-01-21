import 'package:bangumi/api/API.dart';
import 'package:bangumi/pages/HomePage/AnimeListItem.dart';
import 'package:bangumi/model/Anime.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  Future<List<Anime>> data;

  @override
  void initState() {
    super.initState();

    data = API.getAnimeHome();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text("半谷米"),
        ),
        body: Column(children: <Widget>[
          Container(
              padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: TextField(
                decoration: InputDecoration(hintText: '搜索'),
              )),
          Flexible(
            flex: 1,
            child: RefreshIndicator(
                onRefresh: () {},
                child: FutureBuilder<List<Anime>>(
                    future: data,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, int index) {
                            return AnimeListItem(anime: snapshot.data[index]);
                          },
                        );
                      } else if (snapshot.hasError) {
                        return Text('error');
                      } else {
                        return CircularProgressIndicator();
                      }
                    })),
          )
        ]));
  }
}
