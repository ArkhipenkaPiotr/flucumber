import 'package:flucumber_generator/src/config_snippet_generator/config_snippet_generator.dart';
import 'package:flucumber_generator/src/parsing/runnables/step.dart';
import 'package:flucumber_generator/src/steps_file_reference.dart';

class StepGenerator extends ConfigSnippetGenerator {
  final StepRunnable _stepRunnable;

  StepGenerator(this._stepRunnable);

  @override
  String generate(List<StepsDefinitionFileMetadata> definitions) {
    final stringBuffer = StringBuffer();

    final stepMetadata = _findStepMetadata(definitions);

    stringBuffer
      ..writeln('StepRunner(')
      ..writeln("actualStep: '${_stepRunnable.name}',")
      ..writeln("stepDefinition: '${stepMetadata.stepDefinition}',")
      ..writeln('runnerFunction: ${stepMetadata.stepMethodReference},')
      ..writeln('),');
    return stringBuffer.toString();
  }

  StepMetadata _findStepMetadata(
    List<StepsDefinitionFileMetadata> definitions,
  ) {
    for (final fileMetadata in definitions) {
      final stepMetadata = fileMetadata.findStep(_stepRunnable.name);
      if (stepMetadata != null) return stepMetadata;
    }

    throw Exception('Step definition for ${_stepRunnable.name} is not found');
  }
}
