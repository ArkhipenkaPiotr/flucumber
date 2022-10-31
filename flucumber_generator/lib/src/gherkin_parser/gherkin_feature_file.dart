import 'keywords/gherkin_feature.dart';

class GherkinFeatureFile {
  final String fileName;
  final List<GherkinFeature> features;

  GherkinFeatureFile({
    required this.fileName,
    required this.features,
  });
}
