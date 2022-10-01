import 'package:flutter/material.dart';
import 'package:pure_blog/screens/add_post.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
          children: const [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Card(
                  child: ListTile(
                title: Text(
                  'POST',
                  style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
                ),
                subtitle: Text('bla bla bla'),
              )),
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
        tooltip: 'add a post',
        child: const Icon(
          Icons.edit,
          color: Colors.white,
        ),
      ),
    );
  }
}
