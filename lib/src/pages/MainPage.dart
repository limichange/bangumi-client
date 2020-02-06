import 'package:bangumi/src/eventBus/UpdateMyLogListEvent.dart';
import 'package:bangumi/src/eventBus/eventBus.dart';
import 'package:bangumi/src/pages/HomePage/HomePage.dart';
import 'package:bangumi/src/pages/MePage/MePage.dart';
import 'package:bangumi/src/pages/NewAnimeListPage/NewAnimeListPage.dart';
import 'package:bangumi/src/state/GlobalData.dart';
import 'package:flutter/material.dart';
import 'package:bangumi/src/pages/MyLogPage/MyLogPage.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final homePage = new HomePage(key: PageStorageKey('Page1'));
  final myLogPage = new MyLogPage(key: PageStorageKey('Page2'));
  final mePage = new MePage(key: PageStorageKey('Page3'));

  void onTabTapped(int index) {
    setState(() {
      Provider.of<GlobalData>(context, listen: false).updatePageIndex(index);

      if (index == 2) {
        eventBus.fire(UpdateMyLogListEvent());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var globalData = Provider.of<GlobalData>(context);

    return Scaffold(
      body: IndexedStack(children: <Widget>[
        homePage,
        NewAnimeListPage(),
        myLogPage,
        mePage,
      ], index: globalData.pageIndex),
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: globalData.pageIndex,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.home),
            title: new Text('首页'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.today),
            title: new Text('新番'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.bookmark),
            title: new Text('仓库'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.person),
            title: new Text('我的'),
          )
        ],
      ),
    );
  }
}
