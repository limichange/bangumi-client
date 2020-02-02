import 'package:flutter/material.dart';

class FeedbackPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FeedbackPage();
  }
}

class _FeedbackPage extends State<FeedbackPage> {
  String _typeValue = '建议';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("反馈建议"),
      ),
      body: Container(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 100,
              child: Row(
//                crossAxisAlignment: CrossAxisAlignment.start,
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
                      maxLines: 8,
                      autofocus: true,
                      style: TextStyle(fontSize: 18),
                      decoration: InputDecoration.collapsed(hintText: "建议反馈"),
                    ),
                  )
                ],
              ),
            ),
            Container(
              child: RaisedButton(
                child: Text('提交'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
