import 'package:flutter/material.dart';

class NormalImage extends StatelessWidget {
  String url;

  NormalImage({this.url});

  @override
  Widget build(BuildContext context) {
    return FadeInImage.assetNetwork(
      placeholder: "assets/images/placeholder.jpg",
      image: url,
      fit: BoxFit.cover,
    );
  }
}
