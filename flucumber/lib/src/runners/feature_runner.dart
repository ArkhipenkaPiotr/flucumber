import 'package:flucumber/src/runners/scenario_runner.dart';
import 'package:flutter_test/flutter_test.dart';

class FeatureRunner {
  final String name;
  final List<ScenarioRunner> scenarios;

  FeatureRunner({required this.scenarios, required this.name});

  void run() async {
    group(name, () {
      for (final scenario in scenarios) {
        scenario.runScenario();
      }
    });
  }
}
