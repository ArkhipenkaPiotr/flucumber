import 'dart:async';
import 'dart:convert';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:collection/collection.dart';
import 'package:flucumber_annotations/flucumber_annotations.dart';
import 'package:flucumber_annotations/src/params/definition_params_extractor.dart';
import 'package:flucumber_generator/src/utils/library_extensions.dart';
import 'package:source_gen/source_gen.dart';

const TypeChecker _stepChecker = TypeChecker.fromRuntime(FlucumberStep);

class FlucumberStepsGenerator extends Generator {
  @override
  FutureOr<String?> generate(LibraryReader library, BuildStep buildStep) async {
    final annotatedElements = library.allAnnotatedWith(_stepChecker);

    if (annotatedElements.isEmpty) return null;

    final resultMap = <String, String>{};
    for (final annotatedElement in annotatedElements) {
      final element = annotatedElement.element;
      final annotation = annotatedElement.annotation;

      _validateMethod(element);

      final definition = annotation.read('definition').stringValue;
      _checkParametersMatching(element as ExecutableElement, definition);

      resultMap[definition] = element.displayName;
    }
    return jsonEncode(resultMap);
  }

  void _validateMethod(Element element) {
    if (element is! ExecutableElement) {
      throw ('${element.displayName} is not a method');
    }

    _checkIsMethodPublic(element);
    _checkFirstParamIsContext(element);
    _checkParamsCount(element);
  }

  void _checkIsMethodPublic(Element element) {
    if (!element.isPublic) {
      Exception('Method ${element.displayName} must be public');
    }
  }

  void _checkFirstParamIsContext(ExecutableElement element) {
    final firstParam = element.parameters.first;
    if (firstParam.type.toString() != 'FlucumberContext') {
      throw 'First parameter of ${element.name} must be a FlucumberContext';
    }
  }

  void _checkParamsCount(ExecutableElement element) {
    if (element.parameters.length > 10) {
      throw 'Error in ${element.name} method\nMaximum numbers of parameters is 7';
    }
  }

  void _checkParametersMatching(ExecutableElement element, String stepDefinition) {
    final definitionParamExtractor = DefinitionParamsExtractor();

    final expectedTypes = definitionParamExtractor
        .getExpectedParamsTypes(stepDefinition)
        .map((e) => e.toString())
        .toList();
    final actualTypes = element.parameters.map((e) => e.type.toString()).toList();

    final listEquality = ListEquality<String>();
    if (!listEquality.equals(expectedTypes, actualTypes..removeAt(0))) {
      throw 'Wrong parameter types in ${element.name}\n'
          'According to step definition, params should have types:\n'
          'FlucumberContext, ${expectedTypes.join(", ")}';
    }
  }
}
