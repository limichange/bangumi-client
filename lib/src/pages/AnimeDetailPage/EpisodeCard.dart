import 'package:bangumi/src/model/Episode.dart';
import 'package:bangumi/src/utils/Utils.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class EpisodeCard extends StatelessWidget {
  Episode episode;

  EpisodeCard({this.episode});

  onTap() async {
    var url = episode.biliUrl;

    if (await canLaunch(url)) {
      await launch(url);
    } else {
//      todo
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: new EdgeInsets.only(right: 10),
        padding: EdgeInsets.all(10),
        decoration: new BoxDecoration(
          border: new Border.all(
              color: Colors.black12, width: 1, style: BorderStyle.solid),
        ),
        width: 200,
        height: 85,
        child: GestureDetector(
          onTap: onTap,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '第' + episode.title + '话',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Container(
                margin: new EdgeInsets.only(top: 5),
                child: Text(
                  episode.longTitle,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black38,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
