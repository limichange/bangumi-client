class Format {
  String animeStatus(String status) {
    if (status == 'over') {
      return '完结';
    } else if (status == 'now') {
      return '连载中';
    }
  }
}

Format format = new Format();
