import 'dart:convert';
import 'dart:io';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:flucumber_generator/flucumber_generator.dart';
import 'package:glob/glob.dart';
import 'package:path/path.dart';
import 'package:source_gen/source_gen.dart';

class FlucumberGenerator extends GeneratorForAnnotation<Flucumber> {
  final Map<String, String> _stepsMethods = {};

  @override
  generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) async {

    final configFiles = Glob('integration_test/**.flucumber_steps.json');
    final ids = buildStep.findAssets(configFiles);

    final result = StringBuffer();
    result.writeln("import 'package:flucumber/flucumber.dart';");

    await for (final id in ids) {
      await _writeImportOfAssets(result, id);
      await _addStepsToMap(buildStep, id);
    }

    result.writeln('void runIntegrationTest([List<String>? scenariosToRun]) {');

    _generateFeatures(result, annotation);

    result.writeln('}');

    return result.toString();
  }

  Future _writeImportOfAssets(StringBuffer resultBuffer, AssetId assetId) async {
    resultBuffer.writeln("import '${assetId.package}';");
  }

  Future _addStepsToMap(BuildStep step, AssetId id) async {
    final content = await step.readAsString(id);
    final stepsMap = jsonDecode(content) as Map<String, String>;
    _stepsMethods.addAll(stepsMap);
  }

  void _generateFeatures(StringBuffer resultBuffer, ConstantReader annotation) {
    final featuresPath = annotation.read('scenariosPath').stringValue;
    final directory = Directory(featuresPath);
    if (!directory.existsSync()) {
      throw Exception("Directory ${directory.absolute.path} doesn't exist");
    }

    resultBuffer.writeln('final features = {');
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
    scenarios.forEach((element) {
      _generateScenario(resultBuffer, element);
    });
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
    resultBuffer.writeln('StepRunner(');
    resultBuffer.writeln("actualStep: '$step',");
    resultBuffer.writeln("stepSource: 'stepSource',");
    resultBuffer.writeln("runnerFunction: () {},");
    resultBuffer.writeln("),");
  }
}
