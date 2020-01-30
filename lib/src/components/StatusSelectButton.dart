import 'package:bangumi/src/GlobalData.dart';
import 'package:bangumi/src/api/API.dart';
import 'package:bangumi/src/utils/Utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StatusSelectButton extends StatefulWidget {
  String uuid;
  Key key;

  StatusSelectButton({this.uuid, Key key}) : super(key: key);

  @override
  _StatusSelectButton createState() {
    print('createState');
    return new _StatusSelectButton();
  }
}

class _StatusSelectButton extends State<StatusSelectButton> {
  var _context;
  String _statusText = '加入我的收藏';

  _changeStatus(status) async {
    var res = await new API().updateAnimeLog(widget.uuid, status);

    String statusText = converStatusToText(status);

    if (res['status'] == 200) {
      Utils.showToast(context: _context, text: '状态更新为 【$statusText】');

      setState(() {
        _statusText = statusText;
      });
    }
  }

  converStatusToText(String status) {
    String statusText;

    if (status == 'todo') {
      statusText = '计划看';
    } else if (status == 'doing') {
      statusText = '观看中';
    } else if (status == 'done') {
      statusText = '已看完';
    } else {
      statusText = '加入我的收藏';
    }

    return statusText;
  }

  void _settingModalBottomSheet(context) {
    _context = context;

    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                    title: new Text('从收藏移除'),
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
  void initState() {
    super.initState();

    print('initState');

    loadData();
  }

  loadData() async {
    var res = await new API().myAnimeLogDetail(widget.uuid);

    if (res['status'] == 200) {
      String statusText = converStatusToText(res['data']['animeLog']['status']);

      setState(() {
        _statusText = statusText;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var globalData = Provider.of<GlobalData>(context);

    return Container(
      child: RaisedButton(
        child: Text(_statusText),
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
