import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../reportError.dart';

class AnimeListItem extends StatelessWidget {
  var imageURL =
      'https://i0.hdslb.com/bfs/bangumi/9d9cd5a6a48428fe2e4b6ed17025707696eab47b.png@320w_428h.webp';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, top: 10, right: 10),
      child: Row(
        children: <Widget>[
          Container(
            width: 128,
            child: Image.network(imageURL),
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.only(left: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Text(
                      '鬼灭之刃',
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Text(
                    '简介：大正时期，日本。心地善良的卖炭少年·炭治郎，有一天他的家人被鬼杀死了。而唯一幸存下来的妹妹——祢豆子变成了鬼。被绝望的现实打垮的炭治郎，为了寻找让妹妹变回人类的方法，决心朝着“鬼杀队”的道路前进。人与鬼交织的悲哀的兄妹的故事，现在开始！',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 5,
                  ),
                  RaisedButton(
                    child: Text(
                      '加入我的收藏',
                    ),
                    onPressed: () {
                      try {
                        throw new Error();
                      } catch (error, stackTrace) {
                        reportError(error, stackTrace);
                      }
                    },
                    color: Colors.pink[300],
                    textColor: Colors.white,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
