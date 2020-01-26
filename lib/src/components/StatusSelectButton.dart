import 'dart:math';

import 'package:bangumi/src/GlobalData.dart';
import 'package:bangumi/src/api/API.dart';
import 'package:bangumi/src/utils/Utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StatusSelectButton extends StatelessWidget {
  String uuid;

  StatusSelectButton({this.uuid});

  _changeStatus(status) async {
    var res = await new API().updateAnimeLog(uuid, status);

    print(res);
  }

  void _settingModalBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                    title: new Text('没看过'),
                    onTap: () {
                      Navigator.pop(context);
                      _changeStatus('none');
                    }),
                new ListTile(
                    title: new Text('计划看'),
                    onTap: () {
                      Navigator.pop(context);
                      _changeStatus('todo');
                    }),
                new ListTile(
                    title: new Text('已看完'),
                    onTap: () {
                      Navigator.pop(context);
                      _changeStatus('done');
                    }),
                new ListTile(
                    title: new Text('观看中'),
                    onTap: () {
                      Navigator.pop(context);
                      _changeStatus('doing');
                    }),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    String statusText = '加入我的收藏';
    var globalData = Provider.of<GlobalData>(context);

    return Container(
      child: RaisedButton(
        child: Text(statusText),
        onPressed: () {
          if (globalData.isLogin) {
            _settingModalBottomSheet(context);
          } else {
            Utils.goLogin(context);
          }
        },
        color: Colors.pink[300],
        textColor: Colors.white,
      ),
    );
  }
}
