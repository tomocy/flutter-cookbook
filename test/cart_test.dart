import 'package:flutter_test/flutter_test.dart';
import 'package:cookbook/model/model.dart';

void main() {
  test('add item to cart', () {
    final cart = Cart();
    cart.addListener(() => expect(cart.items.length, 1));
    cart.add(Item(
      id: 1,
      name: 'item',
      price: 1.0,
    ));
  });
}
