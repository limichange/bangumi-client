import 'package:bangumi/src/pages/NewAnimeListPage/NewAnimeList.dart';
import 'package:flutter/material.dart';
import 'package:bangumi/src/api/API.dart';

class NewAnimeListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _NewAnimeListPage();
  }
}

class _NewAnimeListPage extends State<NewAnimeListPage>
    with SingleTickerProviderStateMixin {
  var _data = {};

  TabController _tabController;

  loadData() async {
    var res = await api.getNewAnimeList();

    if (res['status'] == 200) {
      print(res);

      setState(() {
        _data = res['data'];
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: 7, vsync: this);

    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
//          title: Text("新番"),
          flexibleSpace: SafeArea(
            child: Container(
              width: double.infinity,
              height: 56,
              child: TabBar(controller: _tabController, tabs: [
                Tab(
                  text: "一",
                ),
                Tab(
                  text: "二",
                ),
                Tab(
                  text: "三",
                ),
                Tab(
                  text: "四",
                ),
                Tab(
                  text: "五",
                ),
                Tab(
                  text: "六",
                ),
                Tab(
                  text: "天",
                ),
              ]),
            ),
          ),
        ),
        body: Container(
          child: TabBarView(
            controller: _tabController,
            children: <Widget>[
              NewAnimeList(
                data: _data['mon'],
              ),
              NewAnimeList(
                data: _data['tue'],
              ),
              NewAnimeList(
                data: _data['wed'],
              ),
              NewAnimeList(
                data: _data['thu'],
              ),
              NewAnimeList(
                data: _data['fri'],
              ),
              NewAnimeList(
                data: _data['sat'],
              ),
              NewAnimeList(
                data: _data['sun'],
              ),
            ],
          ),
        ));
  }
}
