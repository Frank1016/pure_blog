import 'package:flutter/material.dart';
import 'package:pure_blog/db/post_service.dart';
import 'package:pure_blog/screens/home.dart';

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
                autovalidateMode: AutovalidateMode.onUserInteraction,
                onSaved: ((newValue) {
                  post.title = newValue;
                }),
                decoration: InputDecoration(
                    labelText: 'Post title', border: OutlineInputBorder()),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'title field cannot be empty';
                  } else if (value.length > 16) {
                    return 'title cannot have more than 16 characters';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
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
                  return null;
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          insertPost();
          //Navigator.pop(context);
        },
        backgroundColor: Colors.red,
        tooltip: 'add this post',
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
      PostService postService =
          PostService(post.toMap() as Map<String, Object?>);
      postService.addPost();

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
        (Route<dynamic> route) => false,
      );
    }
  }
}
