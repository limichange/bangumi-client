import 'package:bangumi/src/state/AnimeLogStatusData.dart';
import 'package:bangumi/src/state/GlobalData.dart';
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
    return new _StatusSelectButton();
  }
}

class _StatusSelectButton extends State<StatusSelectButton> {
  _changeStatus(status) async {
    var res = await api.updateAnimeLog(widget.uuid, status);

    String statusText = converStatusToText(status);

    if (res['status'] == 200) {
      Utils.showToast(context: context, text: '状态更新为 【$statusText】');

      _updateLocalStatus(statusText);
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

  void _settingModalBottomSheet() {
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

    loadData();
  }

  loadData() async {
    var res = await api.myAnimeLogDetail(widget.uuid);

    if (res['status'] == 200) {
      String statusText = converStatusToText(res['data']['animeLog']['status']);
      _updateLocalStatus(statusText);
    } else if (res['status'] == 204) {
      _updateLocalStatus(converStatusToText('none'));
    }
  }

  _updateLocalStatus(String statusText) {
    Provider.of<AnimeLogStatusData>(context, listen: false)
        .updateStatus(widget.uuid, statusText);
  }

  @override
  Widget build(BuildContext context) {
    var statusText = Provider.of<AnimeLogStatusData>(context).get(widget.uuid);
    var globalData = Provider.of<GlobalData>(context);

    return RaisedButton(
      child: Text(statusText),
      onPressed: () {
        if (globalData.isLogin) {
          _settingModalBottomSheet();
        } else {
          Utils.goLogin(context);
        }
      },
      color: Colors.pink[300],
      textColor: Colors.white,
    );
  }
}
