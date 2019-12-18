import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Page(
        channel: IOWebSocketChannel.connect('ws://echo.websocket.org'),
      ),
    );
  }
}

class Page extends StatefulWidget {
  const Page({
    Key key,
    @required this.channel,
  }) : super(key: key);

  final WebSocketChannel channel;

  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<Page> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    widget.channel.sink.close();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Form(
              key: _formKey,
              child: TextFormField(
                controller: _controller,
                validator: (text) =>
                    text.isEmpty ? 'Please enter some field' : null,
                decoration: InputDecoration(
                  labelText: 'Send a message',
                ),
              ),
            ),
            StreamBuilder(
              stream: widget.channel.stream,
              builder: (context, snapshot) => Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(snapshot.hasData ? snapshot.data : ''),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (!_formKey.currentState.validate()) return;
          if (_controller.text.isEmpty) return;

          widget.channel.sink.add(_controller.text);
          _controller.clear();
        },
        child: Icon(Icons.send),
      ),
    );
  }
}
