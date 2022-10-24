import 'dart:convert';
import 'dart:io';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:flucumber_generator/flucumber_generator.dart';
import 'package:flucumber_generator/src/steps_file_reference.dart';
import 'package:glob/glob.dart';
import 'package:path/path.dart';
import 'package:source_gen/source_gen.dart';

class FlucumberGenerator extends GeneratorForAnnotation<Flucumber> {
  final List<StepsFileMetadata> _stepsFileMetadatas = [];

  @override
  generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) async {
    final configFiles = Glob('**.flucumber_steps.json');
    final ids = buildStep.findAssets(configFiles);

    final result = StringBuffer();
    result.writeln("import 'package:flucumber/flucumber.dart';");

    await for (final id in ids) {
      final stepsFileReference = await StepsFileMetadata.fromAssetId(buildStep, id);
      result.writeln(stepsFileReference.importString);
      _stepsFileMetadatas.add(stepsFileReference);
    }

    result.writeln(
        'void runIntegrationTests(Function appMainFunction, [List<String> featuresToRun = const []]) {');
    result.writeln(
        'runFlucumberIntegrationTests(appMainFunction: appMainFunction, allFeatures: _features, featuresToRun: featuresToRun);');
    result.writeln('}\n');

    _generateFeatures(result, annotation);

    return result.toString();
  }

  void _generateFeatures(StringBuffer resultBuffer, ConstantReader annotation) {
    final featuresPath = annotation.read('scenariosPath').stringValue;
    final directory = Directory(featuresPath);
    if (!directory.existsSync()) {
      throw Exception("Directory ${directory.absolute.path} doesn't exist");
    }

    resultBuffer.writeln('final _features = {');
    directory.listSync(recursive: true).forEach((element) {
      final fileExtension = extension(element.path);
      if (fileExtension == '.feature') {
        _generateFeature(resultBuffer, element);
      }
    });
    resultBuffer.writeln('};');
  }

  void _generateFeature(StringBuffer resultBuffer, FileSystemEntity file) {
    final featureFileName = basenameWithoutExtension(file.path);
    final featureContent = File(file.path).readAsStringSync();
    final featureName = featureContent
        .split('\n')
        .firstWhere((element) => element.contains('Feature:'))
        .replaceFirst('Feature:', '')
        .trim();

    resultBuffer.writeln("'$featureFileName': FeatureRunner(");
    resultBuffer.writeln("name: '$featureName',");
    resultBuffer.writeln("scenarios: [");
    _generateScenarios(resultBuffer, featureContent);
    resultBuffer.writeln("],");
    resultBuffer.writeln("),");
  }

  void _generateScenarios(StringBuffer resultBuffer, String featureContent) {
    final scenarios = featureContent.split('Scenario:')..removeAt(0);
    for (final scenario in scenarios) {
      _generateScenario(resultBuffer, scenario);
    }
  }

  void _generateScenario(StringBuffer resultBuffer, String scenarioContent) {
    final scenarioName = scenarioContent.split('\n').first.trim();
    resultBuffer.writeln('ScenarioRunner(');
    resultBuffer.writeln("scenarioName: '$scenarioName',");
    resultBuffer.writeln("steps: [");
    _generateSteps(resultBuffer, scenarioContent);
    resultBuffer.writeln("],");
    resultBuffer.writeln('),');
  }

  void _generateSteps(StringBuffer resultBuffer, String scenarioContent) {
    scenarioContent
        .split('\n')
        .where((element) => element.contains('When') || element.contains('Then'))
        .forEach((element) {
      _generateStep(resultBuffer, element);
    });
  }

  void _generateStep(StringBuffer resultBuffer, String stepContent) {
    final step = stepContent.replaceFirst('When', '').replaceFirst('Then', '').trim();

    StepsFileMetadata? accordingStepsFile;
    StepMetadata? accordingStep;
    for (final stepsFile in _stepsFileMetadatas) {
      final methodReference = stepsFile.findStep(step);
      if (methodReference != null) {
        accordingStepsFile = stepsFile;
        accordingStep = methodReference;
        break;
      }
    }
    if (accordingStepsFile == null || accordingStep == null) {
      throw Exception(
          'Method reference for $step step is not found. \n Check is your step has according method');
    }
    final methodReference = accordingStepsFile.getMethodReferenceToStep(accordingStep);

    resultBuffer.writeln('StepRunner(');
    resultBuffer.writeln("actualStep: '$step',");
    resultBuffer.writeln("stepSource: '${accordingStep.stepDefinition}',");
    resultBuffer.writeln("runnerFunction: $methodReference,");
    resultBuffer.writeln("),");
  }
}
