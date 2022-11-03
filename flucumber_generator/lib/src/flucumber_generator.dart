import 'dart:io';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:flucumber_annotations/flucumber_annotations.dart';
import 'package:flucumber_generator/src/config_snippet_generator/feature_file_generator.dart';
import 'package:flucumber_generator/src/parsing/languages/language_service.dart';
import 'package:flucumber_generator/src/parsing/parser.dart';
import 'package:flucumber_generator/src/steps_file_reference.dart';
import 'package:glob/glob.dart';
import 'package:path/path.dart';
import 'package:source_gen/source_gen.dart';

class FlucumberGenerator extends GeneratorForAnnotation<Flucumber> {
  final List<StepsDefinitionFileMetadata> _stepsFileMetadatas = [];

  @override
  generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) async {
    final configFiles = Glob('**.flucumber_steps.json');
    final ids = buildStep.findAssets(configFiles);

    final result = StringBuffer();
    result.writeln("import 'package:flucumber/flucumber.dart';");

    await for (final id in ids) {
      final stepsFileReference = await StepsDefinitionFileMetadata.fromAssetId(buildStep, id);
      result.writeln(stepsFileReference.importString);
      _stepsFileMetadatas.add(stepsFileReference);
    }

    result.writeln(
        'void runIntegrationTests(Function appMainFunction, [List<String> filesToRun = const []]) {');
    result.writeln(
        'runFlucumberIntegrationTests(appMainFunction: appMainFunction, featureFiles: _featureFiles, filesToRun: filesToRun,);');
    result.writeln('}\n');

    await _generateFeatures(result, annotation);

    return result.toString();
  }

  Future _generateFeatures(StringBuffer resultBuffer, ConstantReader annotation) async {
    final featuresPath = annotation.read('scenariosPath').stringValue;
    final directory = Directory(featuresPath);
    if (!directory.existsSync()) {
      throw Exception("Directory ${directory.absolute.path} doesn't exist");
    }

    resultBuffer.writeln('final _featureFiles = <FeatureFileRunner>[');

    await for (final file in directory.list(recursive: true)) {
      final fileExtension = extension(file.path);
      if (fileExtension == '.feature') {
        await _generateFeatureFile(resultBuffer, file);
      }
    }

    resultBuffer.writeln('];');
  }

  Future _generateFeatureFile(StringBuffer resultBuffer, FileSystemEntity file) async {
    final parser = GherkinParser();
    final languageService = LanguageService()..initialise();

    final featureContent = File(file.path).readAsStringSync();
    print('Feature file generation');
    final featureFile = await parser.parseFeatureFile(featureContent, file.path, languageService);
    print('Feature file parsed');
    final generator = FeatureFileGenerator(featureFile);
    print('Feature file generated');

    resultBuffer.writeln(generator.generate(_stepsFileMetadatas));
  }
}
