class Episode {
  var title = '';
  var cover = '';
  var longTitle = '';
  var uuid = '';
  var biliUrl = '';

  var logStatus = '';

  Episode({this.uuid, this.title, this.cover, this.longTitle, this.biliUrl});

  factory Episode.fromJson(Map<String, dynamic> json) {
    return Episode(
      uuid: json['uuid'],
      title: json['title'],
      cover: json['cover'],
      longTitle: json['longTitle'],
      biliUrl: json['biliUrl'],
    );
  }
}
