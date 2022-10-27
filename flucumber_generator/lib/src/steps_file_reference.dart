import 'dart:convert';

import 'package:build/build.dart';
import 'package:flucumber_annotations/src/params/definition_params_extractor.dart';

class StepsFileMetadata {
  final String packageName;
  final String filePath;
  final String filePseudonym;
  final List<StepMetadata> methodRefs;

  StepsFileMetadata._({
    required this.packageName,
    required this.filePath,
    required this.methodRefs,
    required this.filePseudonym,
  });

  static Future<StepsFileMetadata> fromAssetId(BuildStep buildStep, AssetId id) async {
    final packageName = id.package;
    final filePath =
        id.path.replaceAll('integration_test/', '').replaceAll('.flucumber_steps.json', '.dart');
    final pseudonym = filePath.replaceAll('.dart', '').replaceAll('/', '_');

    final content = await buildStep.readAsString(id);
    final contentMap = jsonDecode(content) as Map<String, dynamic>;
    final refs = contentMap.keys
        .map(
          (e) => StepMetadata(stepDefinition: e, stepMethodName: contentMap[e]!),
        )
        .toList();

    return StepsFileMetadata._(
        packageName: packageName, filePath: filePath, methodRefs: refs, filePseudonym: pseudonym);
  }

  String get importString => "import '$filePath' as $filePseudonym;";

  StepMetadata? findStep(String stepName) {
    final extractor = DefinitionParamsExtractor();

    final matchingRefs = methodRefs.where((element) {
      final definition = extractor.definitionToRegexpFormat(element.stepDefinition);

      // print('Matching $definition with $stepName');
      return RegExp(definition).hasMatch(stepName);
    });
    if (matchingRefs.isEmpty) return null;

    final firstMatchingStepMetadata = matchingRefs.first;
    return firstMatchingStepMetadata;
  }

  String getMethodReferenceToStep(StepMetadata stepMetadata) {
    return '$filePseudonym.${stepMetadata.stepMethodName}';
  }
}

class StepMetadata {
  final String stepDefinition;
  final String stepMethodName;

  StepMetadata({
    required this.stepDefinition,
    required this.stepMethodName,
  });
}
