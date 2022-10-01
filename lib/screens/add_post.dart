import 'package:flutter/material.dart';
import 'package:pure_blog/db/post_service.dart';

import '../models/post.dart';

class AddPost extends StatefulWidget {
  const AddPost({super.key});

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  final formkey = GlobalKey<FormState>();
  late Post post;

  @override
  void initState() {
    post = Post('', '', '', '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Theme.of(context).primaryColor,
        title: Text('add post'),
      ),
      body: Form(
        key: formkey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                onSaved: ((newValue) {
                  post.title = newValue;
                }),
                decoration: InputDecoration(
                    labelText: 'Post title', border: OutlineInputBorder()),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'title field cannot be empty';
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                onSaved: (newValue) {
                  post.body = newValue;
                },
                decoration: InputDecoration(
                  labelText: 'Post body',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'body field cannot be empty';
                  }
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          insertPost();
        },
        backgroundColor: Colors.red,
        tooltip: 'add a post',
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  void insertPost() {
    final FormState form = formkey.currentState as FormState;

    if (form.validate()) {
      form.save();
      form.reset();
      post.date = DateTime.now().microsecondsSinceEpoch.toString();
      PostService postService = PostService(post.toMap());
      postService.addPost();
    }
  }
}
