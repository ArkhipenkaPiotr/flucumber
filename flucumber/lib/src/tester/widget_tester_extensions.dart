import 'package:flutter_test/flutter_test.dart';

extension WidgetTesterExtensions on WidgetTester {
  Future<bool> pumpUntilVisible(
    Finder target, {
    Duration timeout = _defaultPumpTimeout,
    bool doThrow = true,
  }) async {
    bool condition() => target.evaluate().isNotEmpty;
    final found = await pumpUntilCondition(condition, timeout: timeout);
    if (!found && doThrow) {
      throw TestFailure('Target was not found ${target.toString()}');
    }
    return found;
  }

  Future<bool> pumpUntilCondition(
    bool Function() condition, {
    Duration timeout = _defaultPumpTimeout,
  }) {
    return TestAsyncUtils.guard<bool>(() async {
      final endTime = binding.clock.fromNowBy(timeout);
      var instant = true;
      do {
        if (condition()) {
          if (!instant) await pumpAndSettle();
          return true;
        }
        await pump(_minimalPumpDelay);
        instant = false;
      } while (binding.clock.now().isBefore(endTime));
      return false;
    });
  }
}

const Duration _defaultPumpTimeout = Duration(seconds: 45);

const Duration _minimalPumpDelay = Duration(milliseconds: 100);
