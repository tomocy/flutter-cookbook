// Imports the Flutter Driver API.
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('is the count incremeneted?', () {
    final counterTextFinder = find.byValueKey('count');
    final buttonFinder = find.byValueKey('increment button');

    FlutterDriver driver;
    setUpAll(() async => driver = await FlutterDriver.connect());
    tearDownAll(() async => driver?.close());

    test(
      'starts at 0',
      () async => expect(await driver.getText(counterTextFinder), '0'),
    );

    test('increments the counter', () async {
      await driver.tap(buttonFinder);
      expect(await driver.getText(counterTextFinder), '1');
    });
  });
}
