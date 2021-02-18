import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'main.dart';


class HomePage extends StatefulWidget {
  final title;

  HomePage(this.title);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Post> posts = [];

  @override
  void initState() {
    SampleService().getPosts().then((response) {
      final list = json.decode(response.body);
      if (list is List) {
        setState(() {
          posts = list.map((post) => Post.fromJson(post)).toList();
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: ListView.builder(
          padding: EdgeInsets.all(10),
          itemCount: posts.length,
          itemBuilder: (context, int index) {
            return Column(children: <Widget>[
              ListTile(title: Text(posts[index].body)),
              Divider(height: 2.0, color: Colors.grey),
            ]);
          },
        ),
      ),
    );
  }
}
