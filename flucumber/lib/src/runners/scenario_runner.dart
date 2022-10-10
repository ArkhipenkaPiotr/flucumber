import 'package:flucumber/src/context/flucumber_context.dart';
import 'package:flucumber/src/runners/step_runner.dart';
import 'package:flutter_test/flutter_test.dart';

class ScenarioRunner {
  final List<StepRunner> steps;
  final String scenarioName;

  ScenarioRunner({required this.scenarioName, required this.steps});

  void runScenario() {
    testWidgets(scenarioName, (tester) async {
      final context = FlucumberContext(tester);
      for (final step in steps) {
        await step.runStep(context);
      }
    });
  }
}
