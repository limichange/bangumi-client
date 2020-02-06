import 'package:flutter/material.dart';

class NewAnimeListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _NewAnimeListPage();
  }
}

class _NewAnimeListPage extends State<NewAnimeListPage>
    with SingleTickerProviderStateMixin {
  num _index = 0;

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: 7, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text("新番"),
          bottom: TabBar(
            onTap: (index) {
              setState(() {
                _index = index;
              });
            },
            controller: _tabController,
            tabs: [
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
            ],
          ),
        ),
        body: Container());
  }
}
