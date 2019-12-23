import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Page(
        client: http.Client(),
      ),
    );
  }
}

class Page extends StatefulWidget {
  const Page({
    Key key,
    @required this.client,
  }) : super(key: key);

  final http.Client client;

  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<Page> {
  Future<Post> _post;

  @override
  void initState() {
    super.initState();
    _post = fetchPost(widget.client);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post'),
      ),
      body: Center(
        child: FutureBuilder<Post>(
          future: _post,
          builder: (context, snapshot) {
            if (snapshot.hasData)
              return ListTile(
                title: Text(snapshot.data.title),
                subtitle: Text(snapshot.data.body),
              );
            if (snapshot.hasError) return Text(snapshot.error.toString());

            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}

Future<Post> fetchPost(http.Client client) async {
  final response =
      await client.get('https://jsonplaceholder.typicode.com/posts/1');
  if (response.statusCode != 200) {
    throw Exception('failed to fetch post');
  }

  return Post.fromJson(json.decode(response.body));
}

class Post {
  const Post({
    this.id,
    this.userId,
    this.title,
    this.body,
  });

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        id: json['id'],
        userId: json['userId'],
        title: json['title'],
        body: json['body'],
      );

  final int id;
  final int userId;
  final String title;
  final String body;
}
