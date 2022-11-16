import 'package:flucumber/src/model/example_value.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import '../context/flucumber_context.dart';
import '../model/examples.dart';
import 'background_runner.dart';
import 'step_runner.dart';

class ScenarioRunner {
  final List<StepRunner> steps;
  final String scenarioName;
  final Examples? examples;

  ScenarioRunner({required this.scenarioName, required this.steps, this.examples});

  void runScenario(
    Function appMainFunction, [
    BackgroundRunner? backgroundRunner,
  ]) {
    IntegrationTestWidgetsFlutterBinding.ensureInitialized();

    final examples = this.examples;

    if (examples == null) {
      _runStepsInScenario(appMainFunction, backgroundRunner, []);
      return;
    }

    for (var i = 0; i < examples.variables.length; i++) {
      final exampleValues = examples.getValuesOf(i);
      _runStepsInScenario(appMainFunction, backgroundRunner, exampleValues);
    }
  }

  void _runStepsInScenario(
    Function appMainFunction, [
    BackgroundRunner? backgroundRunner,
    List<ExampleValue>? exampleValues,
  ]) async {
    testWidgets(scenarioName, (tester) async {
      appMainFunction();
      final context = FlucumberContext(tester);

      if (backgroundRunner != null) {
        await backgroundRunner.runBackground(appMainFunction, context);
      }

      for (final step in steps) {
        await step.runStep(context, exampleValues);
      }
    });
  }
}
