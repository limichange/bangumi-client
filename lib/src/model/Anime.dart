class Anime {
  var name = '';
  var desc = '';
  var cover = '';
  var uuid = '';

  Anime({this.uuid, this.name, this.desc, this.cover});

  factory Anime.fromJson(Map<String, dynamic> json) {
    return Anime(
      uuid: json['uuid'],
      name: json['name'],
      cover: json['cover'],
      desc: json['desc'],
    );
  }
}
