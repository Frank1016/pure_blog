import 'package:firebase_database/firebase_database.dart';

class Post {
  static const KEY = 'key';
  static const DATE = 'date';
  static const TITLE = 'title';
  static const BODY = 'body';

  String? date;
  String? key;
  String? title;
  String? body;

  Post(this.date, this.key, this.title, this.body);

  // String? get key => _key;
  // String? get date => _date;
  // String? get title => _title;
  // String? get body => _body;

  Post.fromSnapshot(DataSnapshot snap)
      : key = snap.key,
        body = (snap.value as Map<String, dynamic>?)?[BODY] ?? '',
        date = (snap.value as Map<String, dynamic>?)?[DATE] ?? '',
        title = (snap.value as Map<String, dynamic>?)?[TITLE] ?? '';

  Map toMap() {
    return {
      BODY: body,
      TITLE: title,
      DATE: date,
    };
  }
}
