import 'package:bangumi/src/api/API.dart';
import 'package:flutter/material.dart';

class UpdateLogPage extends StatefulWidget {
  @override
  _UpdateLogPage createState() {
    return _UpdateLogPage();
  }
}

class _UpdateLogPage extends State<UpdateLogPage> {
  bool _isLoaidng = true;
  var logs;

  @override
  void initState() {
    loadData();
  }

  loadData() async {
    var res = await API().appUpdateLog();

    print(res);

    if (res['status'] == 200) {
      print(res['data']['logs']);
      setState(() {
        logs = res['data']['logs'];
      });
    }

    setState(() {
      _isLoaidng = false;
    });
  }

  List<Widget> createList() {
    List<Widget> list = [];

    if (logs == null) {
      return [Container(child: Center(child: Text('暂无日志')))];
    } else {
      print(logs);

      logs.forEach((item) {
        List<Widget> innerlist = [];

        innerlist.add(Container(
          padding: EdgeInsets.only(top: 10),
          child: Text(
            item['version'],
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            textAlign: TextAlign.start,
          ),
        ));

        item['content'].forEach((i) {
          innerlist.add(Container(child: Text(i)));
        });

        list.add(Container(
          padding: EdgeInsets.all(12),
          child: Column(
            children: innerlist,
            crossAxisAlignment: CrossAxisAlignment.start,
          ),
        ));
      });

      return list;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text("更新日志"),
        ),
        body: _isLoaidng
            ? Container(
                height: 100,
                child: Center(
                  child: CircularProgressIndicator(),
                ))
            : Column(
                children: createList(),
              ));
  }
}
