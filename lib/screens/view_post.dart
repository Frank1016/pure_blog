import 'package:flutter/material.dart';
import 'package:pure_blog/db/post_service.dart';
import 'package:pure_blog/screens/edit_post.dart';
import '../models/post.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../db/post_service.dart';
import 'home.dart';

class ViewPost extends StatefulWidget {
  Post post;
  ViewPost({super.key, required this.post});

  @override
  State<ViewPost> createState() => _ViewPostState();
}

class _ViewPostState extends State<ViewPost> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(widget.post.title as String),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    timeago.format(DateTime.fromMicrosecondsSinceEpoch(
                        int.parse(widget.post.date as String))),
                    style: TextStyle(fontSize: 14.0, color: Colors.grey),
                  ),
                ),
              ),
              IconButton(
                  onPressed: () {
                    PostService postService = PostService(widget.post.toMap());
                    postService.deletePost();
                    //Navigator.pop(context);
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                      (Route<dynamic> route) => false,
                    );
                  },
                  icon: Icon(Icons.delete)),
              IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditPost(
                                  post: widget.post,
                                )));
                  },
                  icon: Icon(Icons.edit)),
            ],
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(widget.post.body as String),
          ),
        ],
      ),
    );
  }
}
