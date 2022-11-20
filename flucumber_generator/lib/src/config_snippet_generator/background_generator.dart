import 'package:flucumber_generator/src/config_snippet_generator/config_snippet_generator.dart';
import 'package:flucumber_generator/src/config_snippet_generator/step_generator.dart';
import 'package:flucumber_generator/src/parsing/runnables/background.dart';
import 'package:flucumber_generator/src/steps_file_reference.dart';

class BackgroundGenerator extends ConfigSnippetGenerator {
  final BackgroundRunnable _backgroundRunnable;

  BackgroundGenerator(this._backgroundRunnable);

  @override
  String generate(List<StepsDefinitionFileMetadata> definitions) {
    final stringBuffer = StringBuffer()
      ..writeln('BackgroundRunner(')
      ..writeln("name: '${_backgroundRunnable.name}',")
      ..writeln('steps: [');

    for (final step in _backgroundRunnable.steps) {
      final generator = StepGenerator(step);
      stringBuffer.writeln(generator.generate(definitions));
    }

    stringBuffer
      ..writeln('],')
      ..writeln('),');
    return stringBuffer.toString();
  }
}
