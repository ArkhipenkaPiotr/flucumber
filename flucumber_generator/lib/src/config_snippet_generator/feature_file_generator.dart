import 'package:flucumber_generator/src/config_snippet_generator/config_snippet_generator.dart';
import 'package:flucumber_generator/src/config_snippet_generator/feature_generator.dart';
import 'package:flucumber_generator/src/steps_file_reference.dart';

import '../parsing/runnables/feature_file.dart';

class FeatureFileGenerator extends ConfigSnippetGenerator {
  final FeatureFile featureFileRunner;

  FeatureFileGenerator(this.featureFileRunner);

  @override
  String generate(List<StepsDefinitionFileMetadata> definitions) {
    final stringBuffer = StringBuffer()
      ..writeln('FeatureFileRunner(')
      ..writeln("fileName: '${featureFileRunner.name}',")
      ..writeln('features: [');

    for (final feature in featureFileRunner.features) {
      final generator = FeatureGenerator(feature);
      stringBuffer.writeln(generator.generate(definitions));
    }

    stringBuffer
      ..writeln('],')
      ..writeln('),');

    return stringBuffer.toString();
  }
}
