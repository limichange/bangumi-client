import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class NormalImage extends StatelessWidget {
  String url;
  NormalImage({this.url, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (url == null || url == '') return new Container();

    return CachedNetworkImage(
      key: ValueKey(url),
      placeholder: (context, url) => Image(
          image: AssetImage('assets/images/placeholder.jpg'),
          fit: BoxFit.cover),
      errorWidget: (context, url, error) => Image(
          image: AssetImage(
            'assets/images/placeholder-work.jpg',
          ),
          fit: BoxFit.cover),
      imageUrl: url,
      fit: BoxFit.cover,
    );
  }
}
