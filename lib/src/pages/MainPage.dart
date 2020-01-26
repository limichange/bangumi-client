import 'package:bangumi/src/pages/HomePage/HomePage.dart';
import 'package:bangumi/src/pages/MePage/MePage.dart';
import 'package:flutter/material.dart';
import 'package:bangumi/src/pages/MyLogPage/MyLogPage.dart';

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
  int _currentIndex = 0;
  final homePage = new HomePage(key: PageStorageKey('Page1'));
  final myLogPage = new MyLogPage(key: PageStorageKey('Page2'));
  final mePage = new MePage(key: PageStorageKey('Page3'));

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

//  final PageStorageBucket bucket = PageStorageBucket();
//
//  getPage(index) {
//    if (index == 0) {
//      return homePage;
//    } else if (index == 1) {
//      return myLogPage;
//    } else if (index == 2) {
//      return mePage;
//    }
//  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
          children: <Widget>[homePage, myLogPage, mePage],
          index: _currentIndex),
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.home),
            title: new Text('首页'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.bookmark),
            title: new Text('仓库'),
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), title: Text('我的'))
        ],
      ),
    );
  }
}
