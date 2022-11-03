import 'package:flucumber_generator/src/config_snippet_generator/config_snippet_generator.dart';

import '../parsing/runnables/feature_file.dart';

class FeatureFileGenerator extends ConfigSnippetGenerator {
  final FeatureFile featureFileRunner;

  FeatureFileGenerator(this.featureFileRunner);

  @override
  String generate() {
  }
}