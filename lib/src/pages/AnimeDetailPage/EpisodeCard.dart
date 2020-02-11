import 'package:bangumi/src/api/API.dart';
import 'package:bangumi/src/model/Episode.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class EpisodeCard extends StatefulWidget {
  Episode episode;

  EpisodeCard({this.episode});

  @override
  State<StatefulWidget> createState() {
    return _EpisodeCard();
  }
}

class _EpisodeCard extends State<EpisodeCard> {
  onTap() async {
    _settingModalBottomSheet();
  }

  bool _isRead;

  setIsRead(String status) async {
    var res = await api.saveEpisodeLog(widget.episode.uuid, status);

    print(res);

    if (res['status'] == 200) {
      setState(() {
        widget.episode.logStatus = res['data']['status'];
      });
    }
  }

  void _settingModalBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                    title: new Text(_isRead ? '标记为未看' : '标记为已看完'),
                    onTap: () {
                      setIsRead(_isRead ? 'none' : 'done');

                      Navigator.pop(context);
                    }),
//                new ListTile(
//                    title: Row(
//                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                      children: <Widget>[
//                        Text('打开B站'),
////                        Container(
////                          child: Row(
////                            children: <Widget>[
////                              Checkbox(
////                                value: true,
////                              ),
////                              Text('表为已看完')
////                            ],
////                          ),
////                        )
//                      ],
//                    ),
//                    onTap: () async {
//                      var url = widget.episode.biliUrl;
//
//                      if (await canLaunch(url)) {
//                        await launch(url, forceSafariVC: false);
//                      }
//                    }),
                new ListTile()
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    _isRead = widget.episode.logStatus == 'done';

    return GestureDetector(
      onTap: onTap,
      child: Stack(
        overflow: Overflow.visible,
        children: <Widget>[
          Container(
//            color: Colors.pink[300],
            margin: EdgeInsets.only(right: 10),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _isRead ? Color.fromRGBO(235, 123, 153, .9) : Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(5)),
              border: Border.all(
                  color: _isRead ? Colors.white : Colors.black12,
                  width: 1,
                  style: BorderStyle.solid),
            ),
            width: 200,
            height: 88,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                    widget.episode.title == null
                        ? ' '
                        : '第' + widget.episode.title + '话',
                    style: TextStyle(
                      color: _isRead ? Colors.white : Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    )),
                Container(
                  margin: new EdgeInsets.only(top: 5),
                  child: Text(
                    widget.episode.longTitle == null
                        ? ' '
                        : widget.episode.longTitle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12,
                      color: _isRead ? Colors.white : Colors.black38,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
//          Positioned(
//              right: 13.0,
//              top: 3.0,
//              child: Container(
//                padding: EdgeInsets.all(5),
//                width: 60.0,
//                decoration: new BoxDecoration(
//                  color: Colors.pink[300],
//                  borderRadius: new BorderRadius.all(new Radius.circular(4.0)),
//                  boxShadow: [
//                    new BoxShadow(
//                        color: Colors.black26,
//                        blurRadius: 4.0,
//                        spreadRadius: .1)
//                  ],
//                ),
//                child: new Text(
//                  '已看',
//                  textAlign: TextAlign.center,
//                  style: TextStyle(
//                    color: Colors.white,
//                    fontSize: 12,
//                    fontWeight: FontWeight.w600,
//                  ),
//                ),
//              )),
        ],
      ),
    );
  }
}
