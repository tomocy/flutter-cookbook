import 'package:test/test.dart';
import 'package:cookbook/counter.dart';

void main() {
  group('Counter', () {
    final counter = Counter();
    test('does the counter start at 0', () {
      expect(counter.count, 0);
    });

    test('does the counter increment', () {
      counter.increment();
      expect(counter.count, 1);
    });

    test('does the counter decrement', () {
      counter.decrement();
      expect(counter.count, 0);
    });
  });
}
