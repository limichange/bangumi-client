import 'package:bangumi/src/api/API.dart';
import 'package:bangumi/src/model/Anime.dart';
import 'package:flutter/material.dart';

class FeedbackPage extends StatefulWidget {
  Anime anime = new Anime();

  FeedbackPage({this.anime});

  @override
  State<StatefulWidget> createState() {
    return _FeedbackPage();
  }
}

class _FeedbackPage extends State<FeedbackPage> {
  String _typeValue = '建议';
  String _content = '';
  bool _isLoading = false;
  var _context;

  _submit() async {
    String animeUuid = '';

    if (_isLoading) {
      return;
    }

    _isLoading = true;

    if (widget.anime != null) {
      animeUuid = widget.anime.uuid;
    }

    var res = await API().addFeedback(_content, _typeValue, animeUuid);

    _isLoading = false;

    await showDialog(
        context: _context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(res['message']),
          );
        });

    if (res['status'] == 200) {
      Navigator.pop(_context);
    }
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("反馈建议"),
      ),
      body: Container(
        padding: EdgeInsets.all(12),
        child: Column(
          children: <Widget>[
            Container(
              height: 68,
              child: Row(
                children: <Widget>[
                  Text(
                    '类型: ',
                    style: TextStyle(fontSize: 18),
                  ),
                  Container(
                    child: DropdownButton<String>(
                      items: <String>['建议', '报错'].map((String value) {
                        return new DropdownMenuItem<String>(
                          value: value,
                          child: new Text(value),
                        );
                      }).toList(),
                      value: _typeValue,
                      onChanged: (value) {
                        setState(() {
                          _typeValue = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '内容: ',
                    style: TextStyle(fontSize: 18),
                  ),
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          _content = value;
                        });
                      },
                      maxLines: 8,
                      style: TextStyle(fontSize: 18),
                      decoration:
                          InputDecoration.collapsed(hintText: "填写更加详细的内容"),
                    ),
                  )
                ],
              ),
            ),
            Container(
              child: Center(
                child: RaisedButton(
                  child: Text('提交'),
                  color: Colors.pink[300],
                  textColor: Colors.white,
                  onPressed: _submit,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
