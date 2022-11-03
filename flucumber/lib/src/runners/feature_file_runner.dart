import 'feature_runner.dart';

class FeatureFileRunner {
  final String fileName;
  final List<FeatureRunner> features;

  FeatureFileRunner({
    required this.fileName,
    required this.features,
  });

  void run(Function appMainFunction) async {
    for (final feature in features) {
      feature.run(appMainFunction);
    }
  }
}
