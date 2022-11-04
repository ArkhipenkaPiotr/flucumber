import 'package:flucumber/flucumber.dart';
import 'package:flutter_test/flutter_test.dart';

class BackgroundRunner {
  final String? name;
  final List<StepRunner> steps;

  BackgroundRunner({
    required this.steps,
    this.name,
  });

  Future runBackground(Function appMainFunction, FlucumberContext context) async {
    for (final step in steps) {
      await step.runStep(context);
    }
  }
}
