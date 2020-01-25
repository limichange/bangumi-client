import 'package:flutter/material.dart';

class StatusSelectButton extends StatelessWidget {
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
                      print('none');
                    }),
                new ListTile(
                    title: new Text('计划看'),
                    onTap: () {
                      Navigator.pop(context);
                      print('none');
                    }),
                new ListTile(
                    title: new Text('已看完'),
                    onTap: () {
                      Navigator.pop(context);
                      print('none');
                    }),
                new ListTile(
                    title: new Text('观看中'),
                    onTap: () {
                      Navigator.pop(context);
                      print('none');
                    }),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    String statusText = '加入我的收藏';

    return Container(
      child: RaisedButton(
        child: Text(statusText),
        onPressed: () {
          _settingModalBottomSheet(context);
        },
        color: Colors.pink[300],
        textColor: Colors.white,
      ),
    );
  }
}
