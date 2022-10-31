import 'gherkin_step.dart';

class GherkinScenario {
  final String scenarioName;
  final List<GherkinStep> steps;

  GherkinScenario({
    required this.scenarioName,
    required this.steps,
  });
}
