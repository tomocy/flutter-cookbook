import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  FlutterDriver driver;
  setUpAll(() async => driver = await FlutterDriver.connect());
  tearDown(() async => driver?.close());

  test('does the list contain the specific item?', () async {
    final itemListFinder = find.byValueKey('item_list');
    final itemFinder = find.byValueKey('item_5');

    await driver.scrollUntilVisible(
      itemListFinder,
      itemFinder,
      dyScroll: -100,
    );

    expect(await driver.getText(itemFinder), 'Item 5');
  });
}
