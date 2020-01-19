import 'package:bangumi/api/API.dart';
import 'package:bangumi/reportError.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text("半谷米"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.network(
                'https://i0.hdslb.com/bfs/bangumi/9d9cd5a6a48428fe2e4b6ed17025707696eab47b.png@320w_428h.webp'),
            RaisedButton(
              child: Text(
                '加入我的收藏',
              ),
              onPressed: () {
//                API.test();

                try {
                  throw new Error();
                } catch (error, stackTrace) {
                  reportError(error, stackTrace);
                }
              },
              color: Colors.pink[300],
              textColor: Colors.white,
            ),
            Text(
              '简介：大正时期，日本。心地善良的卖炭少年·炭治郎，有一天他的家人被鬼杀死了。而唯一幸存下来的妹妹——祢豆子变成了鬼。被绝望的现实打垮的炭治郎，为了寻找让妹妹变回人类的方法，决心朝着“鬼杀队”的道路前进。人与鬼交织的悲哀的兄妹的故事，现在开始！',
            ),
          ],
        ));
  }
}
