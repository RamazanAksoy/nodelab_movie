enum HeaderQuery { token }

extension HeaderQueryExtension on HeaderQuery {
  MapEntry<String, dynamic> rawValue({String? token}) {
    switch (this) {
      case HeaderQuery.token:
        return MapEntry('Authorization', '$token');
    }
  }
}
