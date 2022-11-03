import 'package:flucumber_generator/src/config_snippet_generator/config_snippet_generator.dart';
import 'package:flucumber_generator/src/config_snippet_generator/step_generator.dart';
import 'package:flucumber_generator/src/parsing/runnables/scenario.dart';
import 'package:flucumber_generator/src/steps_file_reference.dart';

class ScenarioGenerator extends ConfigSnippetGenerator {
  final ScenarioRunnable _scenarioRunnable;

  ScenarioGenerator(this._scenarioRunnable);

  @override
  String generate(List<StepsDefinitionFileMetadata> definitions) {
    final stringBuffer = StringBuffer();
    stringBuffer
      ..writeln('ScenarioRunner(')
      ..writeln("scenarioName: '${_scenarioRunnable.name}',")
      ..writeln('steps: [');

    for (final step in _scenarioRunnable.steps) {
      final generator = StepGenerator(step);
      stringBuffer.writeln(generator.generate(definitions));
    }

    stringBuffer.writeln('],');
    stringBuffer.writeln('),');

    return stringBuffer.toString();
  }
}
