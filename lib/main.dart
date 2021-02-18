import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app_test_app/home_page.dart';
import 'package:flutter_app_test_app/sample.dart';
import 'package:http/http.dart' as http;
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage("おは"),
    );
  }
}


class SampleService extends http.BaseClient {
  static SampleService _instance;

  final _inner = http.Client();

  factory SampleService() => _instance ??= SampleService._internal();

  SampleService._internal();

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    request.headers['User-Agent'] = 'Sample Flutter App.';
    print('----- API REQUEST ------');
    print(request.toString());
    if (request is http.Request && request.body.length > 0) {
      print(request.body);
    }

    return _inner.send(request);
  }

  /// APIコール
  Future<http.Response> getPosts() async {
    if (STUB_MODE) {
      // スタブ
      final res = http.Response(stubPostsResponse, 200, headers: {
        HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'
      });
      return Future.delayed(const Duration(seconds: 5), () => res);
    } else {
      // APIサーバアクセス
      final url = 'https://jsonplaceholder.typicode.com/posts';
      return get(url);
    }
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class Post {
  int userId;
  int id;
  String title;
  String body;

  Post(this.userId, this.id, this.title, this.body);

  // Named constructor
  Post.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    id = json['id'];
    title = json['title'];
    body = json['body'];
  }
}