import 'package:bangumi/src/components/StatusSelectButton.dart';
import 'package:bangumi/src/model/Anime.dart';
import 'package:bangumi/src/pages/AnimeDetailPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AnimeListItem extends StatelessWidget {
  Anime anime;

  AnimeListItem({this.anime});

  goDetail(context) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => AnimeDetailPage(uuid: anime.uuid)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, top: 10, right: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          GestureDetector(
            onTap: () => goDetail(context),
            child: Container(
              width: 100,
              child: Image.network(anime.cover),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.only(left: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  GestureDetector(
                    onTap: () => goDetail(context),
                    child: Container(
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
                  ),
                  GestureDetector(
                    onTap: () => goDetail(context),
                    child: Text(
                      anime.desc,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                    ),
                  ),
                  StatusSelectButton(uuid: anime.uuid)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
