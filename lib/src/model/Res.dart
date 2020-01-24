class Res {
  var status = 400;
  var message = '';
  var data;

  Res({this.status, this.message, this.data});

  factory Res.fromJson(Map<String, dynamic> json) {
    return Res(
      status: json['status'],
      message: json['message'],
      data: json['data'],
    );
  }
}
