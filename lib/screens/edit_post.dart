import 'package:flutter/material.dart';

import '../db/post_service.dart';
import '../models/post.dart';
import 'home.dart';

class EditPost extends StatefulWidget {
  final Post post;
  const EditPost({super.key, required this.post});

  @override
  State<EditPost> createState() => _EditPostState();
}

class _EditPostState extends State<EditPost> {
  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Theme.of(context).primaryColor,
        title: Text('edit post'),
      ),
      body: Form(
        key: formkey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                initialValue: widget.post.title,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                onSaved: ((newValue) {
                  widget.post.title = newValue;
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
                initialValue: widget.post.body,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                onSaved: (newValue) {
                  widget.post.body = newValue;
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
          updatePost();
          //Navigator.pop(context);
        },
        backgroundColor: Colors.red,
        tooltip: 'update the post',
        child: const Icon(
          Icons.publish,
          color: Colors.white,
        ),
      ),
    );
  }

  void updatePost() {
    final FormState form = formkey.currentState as FormState;

    if (form.validate()) {
      form.save();
      form.reset();
      widget.post.date = DateTime.now().microsecondsSinceEpoch.toString();
      PostService postService =
          PostService(widget.post.toMap() as Map<String, Object?>);
      postService.updatePost();

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
        (Route<dynamic> route) => false,
      );
    }
  }
}
