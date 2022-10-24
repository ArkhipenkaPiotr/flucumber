import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import '../context/flucumber_context.dart';
import 'step_runner.dart';

class ScenarioRunner {
  final List<StepRunner> steps;
  final String scenarioName;

  ScenarioRunner({required this.scenarioName, required this.steps});

  void runScenario(Function appMainFunction) {
    IntegrationTestWidgetsFlutterBinding.ensureInitialized();

    testWidgets(scenarioName, (tester) async {
      print('Scenatio running');
      appMainFunction();
      final context = FlucumberContext(tester);
      for (final step in steps) {
        await step.runStep(context);
      }
    });
  }
}
