import 'package:bangumi/src/components/NormalImage.dart';
import 'package:bangumi/src/components/StatusSelectButton.dart';
import 'package:bangumi/src/model/Anime.dart';
import 'package:bangumi/src/pages/AnimeDetailPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AnimeListItem extends StatefulWidget {
  final Anime anime;

  AnimeListItem({Key key, this.anime}) : super(key: key);

  @override
  _AnimeListItem createState() {
    return _AnimeListItem();
  }
}

class _AnimeListItem extends State<AnimeListItem> {
  goDetail(context) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => AnimeDetailPage(uuid: widget.anime.uuid)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 10, top: 10, right: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              GestureDetector(
                onTap: () => goDetail(context),
                child: Container(
                  width: 100,
                  height: 136,
                  child: NormalImage(
                    key: ValueKey(widget.anime.cover),
                    url: widget.anime.cover,
                  ),
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
                            widget.anime.name,
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
                          widget.anime.desc,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                        ),
                      ),
                      StatusSelectButton(
                        key: ObjectKey(widget.anime),
                        uuid: widget.anime.uuid,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
