import 'package:flutter/material.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Page(
        items: List<ListItem>.generate(
            100,
            (i) => i % 6 == 0
                ? HeadingItem('Heading $i')
                : MessageItem('Sender $i', 'Body $i')),
      ),
    );
  }
}

class Page extends StatelessWidget {
  const Page({
    Key key,
    @required this.items,
  }) : super(key: key);

  final List<ListItem> items;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, i) {
          final item = items[i];

          if (item is HeadingItem) {
            return ListTile(
              title: Text(
                item.heading,
                style: Theme.of(context).textTheme.headline,
              ),
            );
          }
          if (item is MessageItem) {
            return ListTile(
              title: Text(item.sender),
              subtitle: Text(item.body),
            );
          }

          return null;
        },
      ),
    );
  }
}

abstract class ListItem {
  const ListItem();
}

class HeadingItem extends ListItem {
  const HeadingItem(this.heading);

  final String heading;
}

class MessageItem extends ListItem {
  const MessageItem(this.sender, this.body);

  final String sender;
  final String body;
}
