import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import '../context/flucumber_context.dart';
import 'background_runner.dart';
import 'step_runner.dart';

class ScenarioRunner {
  final List<StepRunner> steps;
  final String scenarioName;

  ScenarioRunner({required this.scenarioName, required this.steps});

  void runScenario(
    Function appMainFunction, [
    BackgroundRunner? backgroundRunner,
  ]) {
    IntegrationTestWidgetsFlutterBinding.ensureInitialized();

    testWidgets(scenarioName, (tester) async {
      appMainFunction();
      final context = FlucumberContext(tester);

      if (backgroundRunner != null) {
        await backgroundRunner.runBackground(appMainFunction, context);
      }

      for (final step in steps) {
        await step.runStep(context);
      }
    });
  }
}
