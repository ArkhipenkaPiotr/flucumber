import 'package:flucumber_generator/src/config_snippet_generator/config_snippet_generator.dart';
import 'package:flucumber_generator/src/config_snippet_generator/step_generator.dart';
import 'package:flucumber_generator/src/parsing/runnables/scenario.dart';
import 'package:flucumber_generator/src/parsing/runnables/scenario_outline.dart';
import 'package:flucumber_generator/src/steps_file_reference.dart';

class ScenarioGenerator extends ConfigSnippetGenerator {
  final ScenarioRunnable _scenarioRunnable;

  ScenarioGenerator(this._scenarioRunnable);

  @override
  String generate(List<StepsDefinitionFileMetadata> definitions) {
    final stringBuffer = StringBuffer()
      ..writeln('ScenarioRunner(')
      ..writeln("scenarioName: '${_scenarioRunnable.name}',");

    _generateExamples(stringBuffer);

    _generateSteps(stringBuffer, definitions);

    stringBuffer.writeln('),');

    return stringBuffer.toString();
  }

  void _generateExamples(StringBuffer stringBuffer) {
    final runnable = _scenarioRunnable;
    if (runnable is! ScenarioOutlineRunnable) {
      return;
    }
    final example = runnable.examples.first;
    final table = example.table;

    stringBuffer
      ..writeln('examples: Examples(')
      ..writeln("name: '${example.name}',")
      ..writeln('variables: [');

    for (var i = 0; i < (table?.variablesLength ?? 0); i++) {
      final variableName = table?.header?.columns.toList()[i];
      final values = table?.rows.map((e) => e.columns.toList()[i]);

      stringBuffer
        ..writeln('ExampleVariable(')
        ..writeln("variableName: '$variableName',")
        ..writeln('values: [${values?.map((e) => "'$e'").join(',')},],')
        ..writeln('),');
    }

    stringBuffer.writeln('],),');
  }

  void _generateSteps(
    StringBuffer stringBuffer,
    List<StepsDefinitionFileMetadata> definitions,
  ) {
    stringBuffer.writeln('steps: [');

    for (final step in _scenarioRunnable.steps) {
      final generator = StepGenerator(step);
      stringBuffer.writeln(generator.generate(definitions));
    }

    stringBuffer.writeln('],');
  }
}
