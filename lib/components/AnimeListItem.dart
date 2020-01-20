import 'package:bangumi/model/Anime.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../reportError.dart';

class AnimeListItem extends StatelessWidget {
  Anime anime;

  AnimeListItem({this.anime}) {}

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, top: 10, right: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 100,
            child: Image.network(anime.cover),
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
                      anime.name,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Text(
                    anime.desc,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
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
