import 'package:flucumber/flucumber.dart';

void runFlucumberIntegrationTests({
  required Function appMainFunction,
  required Map<String, FeatureRunner> allFeatures,
  List<String> featuresToRun = const [],
}) {
  final Iterable<FeatureRunner> features;
  if (featuresToRun.isEmpty) {
    features = allFeatures.values;
  } else {
    features = allFeatures.keys
        .where((featureName) => featuresToRun.contains(featureName))
        .map((featureName) => allFeatures[featureName]!);
  }

  print('Attempt to call main function');

  for (final feature in features) {
    feature.run();
  }
}
