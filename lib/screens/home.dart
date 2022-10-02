import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:pure_blog/screens/add_post.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:pure_blog/screens/view_post.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../models/post.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FirebaseDatabase _database = FirebaseDatabase.instance;
  List<Post> postsList = <Post>[];
  String nodeName = 'posts';

  @override
  void initState() {
    _database.ref().child(nodeName).onChildAdded.listen(_childAdded);
    //_database.ref().child(nodeName).onChildRemoved.listen(_childRemoves);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pure blog'),
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
      ),
      body: Container(
        color: Colors.black87,
        child: Column(
          children: [
            Visibility(
                visible: postsList.isEmpty,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Center(
                    child: Text(
                      'No posts found',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                )),
            Visibility(
              visible: postsList.isNotEmpty,
              child: Flexible(
                  child: FirebaseAnimatedList(
                      query: _database.ref().child('posts'),
                      itemBuilder: (_, DataSnapshot snap,
                          Animation<double> animation, int index) {
                        return Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Card(
                              child: ListTile(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ViewPost(post: postsList[index])));
                            },
                            title: Text(
                              postsList[index].title as String,
                              style: TextStyle(
                                  fontSize: 22.0, fontWeight: FontWeight.bold),
                            ),
                            trailing: Text(
                              timeago.format(
                                  DateTime.fromMicrosecondsSinceEpoch(int.parse(
                                      postsList[index].date as String))),
                              style:
                                  TextStyle(fontSize: 14.0, color: Colors.grey),
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(bottom: 14.0),
                              child: Text(postsList[index].body as String),
                            ),
                          )),
                        );
                      })),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddPost()));
        },
        backgroundColor: Colors.red,
        tooltip: 'write a new post',
        child: const Icon(
          Icons.edit,
          color: Colors.white,
        ),
      ),
    );
  }

  _childAdded(event) {
    setState(() {
      postsList.add(Post.fromSnapshot(event.snapshot));
    });
  }

  void _childRemoves(DatabaseEvent event) {
    setState(() {
      // postsList
      //     .removeWhere((post) => post.key == event.snapshot.key);
    });
  }
}
