import 'package:flutter/material.dart';

class MenuItem extends StatelessWidget {
  String text;
  Function func;

  MenuItem({this.func, this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      color: Colors.white,
      child: Container(
        width: double.infinity,
        child: GestureDetector(
          onTap: () {
            func();
          },
          child: Row(
            children: <Widget>[
              Text(
                text,
                style: TextStyle(fontSize: 16),
              ),
              Expanded(
                child: Container(),
              ),
              Icon(Icons.arrow_right)
            ],
          ),
        ),
      ),
    );
  }
}
