import 'dart:io';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:flucumber_generator/flucumber_generator.dart';
import 'package:path/path.dart';
import 'package:source_gen/source_gen.dart';

class FlucumberGenerator extends GeneratorForAnnotation<Flucumber> {
  @override
  generateForAnnotatedElement(Element element, ConstantReader annotation, BuildStep buildStep) {
    print('Try to generate flucumber');
    final result = StringBuffer();
    result.writeln("import 'package:flucumber/flucumber.dart';\n");
    result.writeln('void runIntegrationTest([List<String>? scenariosToRun]) {');

    _generateFeatures(result, annotation);

    result.writeln('}');

    return result.toString();
  }

  void _generateFeatures(StringBuffer resultBuffer, ConstantReader annotation) {
    final featuresPath = annotation.read('scenariosPath').stringValue;
    final directory = Directory(featuresPath);
    if (!directory.existsSync()) {
      throw Exception("Directory ${directory.absolute.path} doesn't exist");
    }

    resultBuffer.writeln('final features = {');
    directory.listSync(recursive: true).forEach((element) {
      print('File ${element.path}');
      final fileExtension = extension(element.path);
      if (fileExtension == '.feature') {
        print('Parsing... ${element.path}');
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
    resultBuffer.writeln(')');
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
