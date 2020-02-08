import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class NormalImage extends StatefulWidget {
  String url;

  NormalImage({this.url, Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _NormalImage();
  }
}

class _NormalImage extends State<NormalImage> {
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      placeholder: (context, url) => Image(
          image: AssetImage('assets/images/placeholder.jpg'),
          fit: BoxFit.cover),
      errorWidget: (context, url, error) => Image(
          image: AssetImage(
            'assets/images/placeholder-work.jpg',
          ),
          fit: BoxFit.cover),
      imageUrl: widget.url == null ? '' : widget.url,
      fit: BoxFit.cover,
    );
  }
}
