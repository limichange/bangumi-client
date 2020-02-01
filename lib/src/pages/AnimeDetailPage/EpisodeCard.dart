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
      await launch(url, forceSafariVC: false);
    } else {
//      todo
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          margin: EdgeInsets.only(right: 10),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            border: Border.all(
                color: Colors.black12, width: 1, style: BorderStyle.solid),
          ),
          width: 200,
          height: 88,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(episode.title == null ? ' ' : '第' + episode.title + '话',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  )),
              Container(
                margin: new EdgeInsets.only(top: 5),
                child: Text(
                  episode.longTitle == null ? ' ' : episode.longTitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black38,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
