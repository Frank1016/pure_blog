import 'package:firebase_database/firebase_database.dart';

import '../models/post.dart';

class PostService {
  String nodeName = 'posts';
  FirebaseDatabase database = FirebaseDatabase.instance;
  late DatabaseReference _databaseReference;
  Map<String, Object?> post;
  PostService(this.post);

  addPost() {
    // this is going to give a reference to the posts node
    _databaseReference = database.ref().child(nodeName);
    _databaseReference.push().set(post);
  }

  deletePost() {
    database.ref().child('$nodeName/${post['key']}').remove();
  }

  updatePost() {
    database.ref().child('$nodeName/${post['key']}').update(post);
  }
}
