import 'package:flucumber/flucumber.dart';
import 'package:integration_test/integration_test.dart';

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

  for (final feature in allFeatures.values) {
    feature.run(appMainFunction);
  }
}
