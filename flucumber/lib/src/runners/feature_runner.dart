import 'package:flutter_test/flutter_test.dart';

import 'background_runner.dart';
import 'scenario_runner.dart';

class FeatureRunner {
  final String name;
  final BackgroundRunner? background;
  final List<ScenarioRunner> scenarios;

  const FeatureRunner({
    required this.scenarios,
    required this.name,
    this.background,
  });

  void run(Function appMainFunction) {
    group(name, () {
      for (final scenario in scenarios) {
        scenario.runScenario(appMainFunction, background);
      }
    });
  }
}
