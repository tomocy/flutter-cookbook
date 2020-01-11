import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => Cart(),
        child: const MaterialApp(home: CatalogPage()),
      );
}

class CatalogPage extends StatelessWidget {
  const CatalogPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('Catalog'),
          actions: [
            IconButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartPage()),
              ),
              icon: const Icon(Icons.shopping_cart),
            ),
          ],
        ),
        body: SafeArea(
          child: ListView.builder(
            itemBuilder: (context, i) => ItemListTile(item: Catalog.item(i)),
          ),
        ),
      );
}

class CartPage extends StatelessWidget {
  const CartPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text('Cart')),
        body: SafeArea(
          child: Consumer<Cart>(
            builder: (context, cart, child) => ListView.builder(
              itemCount: cart.items.length,
              itemBuilder: (context, i) => ItemListTile(item: cart.items[i]),
            ),
          ),
        ),
      );
}

class ItemListTile extends StatelessWidget {
  const ItemListTile({
    Key key,
    @required this.item,
  })  : assert(item != null),
        super(key: key);

  final Item item;

  @override
  Widget build(BuildContext context) => ListTile(
        leading: Container(
          width: 40,
          height: 40,
          color: item.color,
        ),
        title: Text(item.name),
        subtitle: Text(item.price.toString()),
        trailing: AddOrRemoveItemButton(item: item),
      );
}

class AddOrRemoveItemButton extends StatelessWidget {
  const AddOrRemoveItemButton({
    Key key,
    @required this.item,
  })  : assert(item != null),
        super(key: key);

  final Item item;

  @override
  Widget build(BuildContext context) => Consumer<Cart>(
        builder: (context, cart, child) {
          final contained = cart.items.contains(item);

          return FlatButton(
            onPressed:
                contained ? () => cart.remove(item) : () => cart.add(item),
            splashColor: item.color,
            child: contained
                ? const Icon(Icons.done, semanticLabel: 'Added')
                : const Text('Add'),
          );
        },
      );
}

class Catalog {
  static const List<String> _items = [
    'Code Smell',
    'Control Flow',
    'Interpreter',
    'Recursion',
    'Sprint',
    'Heisenbug',
    'Spaghetti',
    'Hydra Code',
    'Off-By-One',
    'Scope',
    'Callback',
    'Closure',
    'Automata',
    'Bit Shift',
    'Currying',
  ];

  static final _random = Random();

  static Item item(int id) => Item(
        id: id,
        name: _items[id % _items.length],
        price: 100 * _random.nextDouble(),
        color: Colors.primaries[id % Colors.primaries.length],
      );
}

class Cart extends ChangeNotifier {
  List<Item> _items = [];

  List<Item> get items => _items;

  void add(Item item) {
    _items.add(item);
    notifyListeners();
  }

  void remove(Item item) {
    _items.remove(item);
    notifyListeners();
  }
}

class Item {
  const Item({
    this.id,
    this.name,
    this.price,
    this.color,
  });

  final int id;
  final String name;
  final double price;
  final Color color;
}
