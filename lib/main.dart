import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cookbook/model/model.dart' as model;

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<model.Cart>(
      create: (context) => model.Cart(),
      child: const MaterialApp(
        home: Catalog(),
      ),
    );
  }
}

class Catalog extends StatelessWidget {
  const Catalog({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Catalog'),
        actions: <Widget>[
          IconButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Cart()),
            ),
            icon: Icon(Icons.shopping_cart),
          ),
        ],
      ),
      body: ListView.builder(
        itemBuilder: (context, i) => Item(
          item: model.Catalog.item(i),
        ),
      ),
    );
  }
}

class Cart extends StatelessWidget {
  const Cart({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: Consumer<model.Cart>(
        builder: (context, cart, child) => ListView.builder(
          itemCount: cart.items.length,
          itemBuilder: (context, i) => Item(
            item: cart.items[i],
          ),
        ),
      ),
    );
  }
}

class Item extends StatelessWidget {
  const Item({
    Key key,
    @required this.item,
  }) : super(key: key);

  final model.Item item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 8.0,
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 48.0,
            height: 48.0,
            color: item.color,
          ),
          const SizedBox(width: 24.0),
          Expanded(
            child: Text(
              item.name,
              style: Theme.of(context).textTheme.subtitle,
            ),
          ),
          AddOrRemoveButton(
            item: item,
          ),
        ],
      ),
    );
  }
}

class AddOrRemoveButton extends StatelessWidget {
  const AddOrRemoveButton({
    Key key,
    @required this.item,
  }) : super(key: key);

  final model.Item item;

  @override
  Widget build(BuildContext context) => Consumer<model.Cart>(
        builder: (context, cart, child) => FlatButton(
          onPressed: cart.items.contains(item)
              ? () => cart.remove(item)
              : () => cart.add(item),
          splashColor: Theme.of(context).primaryColor,
          child: cart.items.contains(item)
              ? const Icon(
                  Icons.done,
                  semanticLabel: 'Added',
                )
              : const Text('Add'),
        ),
      );
}
