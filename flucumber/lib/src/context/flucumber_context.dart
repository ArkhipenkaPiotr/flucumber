import 'package:flutter_test/flutter_test.dart';

/// This class presents a set of fields/methods that can be used from step definition method
/// Example:
/// ```dart
/// @Then('Click on continue button')
/// Future clickOnContinueButton(FlucumberContext context) async {
///   await context.tester.pumpAndSettle();
///   final clicksAmount = context.get('continue_button_clicks_amount');
///   context.save('continue_button_clicks_amount', clicksAmount++);
/// }
/// ```
class FlucumberContext {
  /// Link to [WidgetTester] from running test
  final WidgetTester tester;
  final Map<String, dynamic> _storage = {};

  /// Object of this class is created for every scenario
  FlucumberContext(this.tester);

  /// Use this method to save some scenario variables
  void save(String key, dynamic value) {
    _storage[key] = value;
  }

  /// Use this method to get some scenario variables
  dynamic get(String key, [dynamic defaultValue]) {
    if (!_storage.containsKey(key)) {

      return defaultValue;
    }

    return _storage[key];
  }
}
