import 'package:bangumi/model/Anime.dart';
import 'package:bangumi/pages/AnimeDetailPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AnimeListItem extends StatelessWidget {
  Anime anime;

  AnimeListItem({this.anime}) {}

  goDetail(context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AnimeDetailPage()),
    );
  }

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
                  GestureDetector(
                    child: Text(
                      anime.desc,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                    ),
                    onTap: () {
                      print('Tapped');
                    },
                    onLongPress: () {
                      print('Long Pressed');
                    },
                  ),
                  RaisedButton(
                    child: Text(
                      '加入我的收藏',
                    ),
                    onPressed: () {
                      goDetail(context);
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
