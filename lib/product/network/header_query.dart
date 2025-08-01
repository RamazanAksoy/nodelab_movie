enum HeaderQuery { userid, token }

extension HeaderQueryExtension on HeaderQuery {
  MapEntry<String, dynamic> rawValue({String? token, int? userid}) {
    switch (this) {
      case HeaderQuery.userid:
        return MapEntry('userid', '$userid');

      case HeaderQuery.token:
        return MapEntry('Authorization', '$token');
    }
  }
}
