import 'package:flutter_test/flutter_test.dart';

import 'scenario_runner.dart';

class FeatureRunner {
  final String name;
  final List<ScenarioRunner> scenarios;

  const FeatureRunner({required this.scenarios, required this.name});

  void run() async {
    print('Feature $name');
    group(name, () {
      for (final scenario in scenarios) {
        scenario.runScenario();
      }
    });
  }
}
