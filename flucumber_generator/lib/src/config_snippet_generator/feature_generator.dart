import 'package:flucumber_generator/src/config_snippet_generator/background_generator.dart';
import 'package:flucumber_generator/src/config_snippet_generator/config_snippet_generator.dart';
import 'package:flucumber_generator/src/config_snippet_generator/scenario_generator.dart';
import 'package:flucumber_generator/src/parsing/runnables/feature.dart';
import 'package:flucumber_generator/src/steps_file_reference.dart';

class FeatureGenerator extends ConfigSnippetGenerator {
  final FeatureRunnable featureRunnable;

  FeatureGenerator(this.featureRunnable);

  @override
  String generate(List<StepsDefinitionFileMetadata> definitions) {
    final stringBuffer = StringBuffer();

    stringBuffer
      ..writeln('FeatureRunner(')
      ..writeln("name: '${featureRunnable.name}',");

    final background = featureRunnable.background;
    if (background != null) {
      final generator = BackgroundGenerator(background);
      stringBuffer.writeln('background: ');
      stringBuffer.write(generator.generate(definitions));
    }

    stringBuffer.writeln('scenarios: [');

    for (final scenario in featureRunnable.scenarios) {
      final generator = ScenarioGenerator(scenario);
      stringBuffer.writeln(generator.generate(definitions));
    }

    stringBuffer.writeln('],');

    stringBuffer.writeln('),');

    return stringBuffer.toString();
  }
}
