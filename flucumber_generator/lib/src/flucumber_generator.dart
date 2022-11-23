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
  @override
  dynamic generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) async {
    final configFiles = Glob('**.flucumber_steps.json');
    final stepDefinitionFiles = buildStep.findAssets(configFiles);

    final result = StringBuffer()
      ..writeln('// ignore_for_file: directives_ordering')
      ..writeln("import 'package:flucumber/flucumber.dart';");

    final filePath = element.source?.uri;

    final stepsFileMetadatas = <StepsDefinitionFileMetadata>[];

    await for (final id in stepDefinitionFiles) {
      final stepsFileReference = await StepsDefinitionFileMetadata.fromAssetId(
          buildStep, id, filePath!,);
      result.writeln(stepsFileReference.importString);
      stepsFileMetadatas.add(stepsFileReference);
    }

    result
      ..writeln(
        'void runIntegrationTests(Function appMainFunction, [List<String> filesToRun = const [],]) {',
      )
      ..writeln(
        'runFlucumberIntegrationTests(appMainFunction: appMainFunction, featureFiles: _featureFiles, filesToRun: filesToRun,);',
      )
      ..writeln('}\n');

    await _generateFeatures(result, annotation, stepsFileMetadatas);

    return result.toString();
  }

  Future _generateFeatures(
    StringBuffer resultBuffer,
    ConstantReader annotation,
    List<StepsDefinitionFileMetadata> stepDefinitionFileMetadatas,
  ) async {
    final language = annotation.read('language').stringValue;
    final featuresPath = annotation.read('scenariosPath').stringValue;
    final directory = Directory(featuresPath);
    if (!directory.existsSync()) {
      throw Exception("Directory ${directory.absolute.path} doesn't exist");
    }

    resultBuffer.writeln('final _featureFiles = <FeatureFileRunner>[');

    await for (final file in directory.list(recursive: true)) {
      final fileExtension = extension(file.path);
      if (fileExtension == '.feature') {
        await _generateFeatureFile(
            resultBuffer, file, language, stepDefinitionFileMetadatas,);
      }
    }

    resultBuffer.writeln('];');
  }

  Future _generateFeatureFile(
    StringBuffer resultBuffer,
    FileSystemEntity file,
    String language,
    List<StepsDefinitionFileMetadata> stepDefinitionFileMetadatas,
  ) async {
    final parser = GherkinParser();
    final languageService = LanguageService()..initialise(language);

    final featureContent = File(file.path).readAsStringSync();
    final featureFile = await parser.parseFeatureFile(
        featureContent, file.path, languageService,);
    final generator = FeatureFileGenerator(featureFile);

    resultBuffer.writeln(generator.generate(stepDefinitionFileMetadatas));
  }
}
