import 'package:flutter_test/flutter_test.dart';

class FlucumberContext {
  final WidgetTester tester;
  final Map<String, dynamic> _storage = {};

  FlucumberContext(this.tester);

  void save(String key, String value) {
    _storage[key] = value;
  }

  dynamic get(String key, [dynamic defaultValue]) {
    if (!_storage.containsKey(key)) {
      return defaultValue;
    }
    return _storage[key];
  }
}
