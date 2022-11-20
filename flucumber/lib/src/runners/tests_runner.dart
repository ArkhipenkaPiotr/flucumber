import 'package:flucumber/flucumber.dart';
import 'package:flucumber/src/runners/feature_file_runner.dart';

void runFlucumberIntegrationTests({
  required Function appMainFunction,
  required List<FeatureFileRunner> featureFiles,
  List<String> filesToRun = const [],
}) {
  final Iterable<FeatureFileRunner> featureFilesToRun;
  if (filesToRun.isEmpty) {
    featureFilesToRun = featureFiles;
  } else {
    featureFilesToRun =
        featureFiles.where((featureName) => filesToRun.contains(featureName.fileName));
  }

  for (final feature in featureFilesToRun) {
    feature.run(appMainFunction);
  }
}
