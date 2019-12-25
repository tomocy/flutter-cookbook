import 'dart:math';
import 'package:flutter/material.dart';

class Catalog {
  static const _items = <String>[
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
      );
}

class Cart extends ChangeNotifier {
  final List<Item> items = [];

  void add(Item item) {
    items.add(item);
    notifyListeners();
  }

  void remove(Item item) {
    items.remove(item);
    notifyListeners();
  }
}

@immutable
class Item {
  Item({
    @required this.id,
    @required this.name,
    @required this.price,
  }) : color = Colors.primaries[id % Colors.primaries.length];

  final int id;
  final String name;
  final double price;
  final Color color;
}
