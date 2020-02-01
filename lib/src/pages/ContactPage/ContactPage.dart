import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ContactPage();
  }
}

class _ContactPage extends State<ContactPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("联系我们"),
      ),
      body: Column(children: <Widget>[
        Container(
          child: RaisedButton(
            onPressed: () {
              launch('https://t.me/joinchat/Ejn98BISHfLkoZ0WEhdSuw',
                  forceSafariVC: false);
            },
            child: Text('lick'),
          ),
        )
      ]),
    );
  }
}
