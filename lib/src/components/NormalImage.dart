import 'package:flutter/material.dart';

class NormalImage extends StatelessWidget {
  String url;
  NormalImage({this.url, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (url == null || url == '') return new Container();

    return FadeInImage.assetNetwork(
      placeholder: "assets/images/placeholder.jpg",
      image: url,
      fit: BoxFit.cover,
    );
  }
}
