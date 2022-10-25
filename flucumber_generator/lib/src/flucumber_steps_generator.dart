import 'dart:async';
import 'dart:convert';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:flucumber_annotations/flucumber_annotations.dart';
import 'package:source_gen/source_gen.dart';

const TypeChecker _whenChecker = TypeChecker.fromRuntime(When);
const TypeChecker _thenChecker = TypeChecker.fromRuntime(Then);

class FlucumberStepsGenerator extends Generator {
  static const _variablesPatterns = {
    '{int}': '[-0-9]+',
    '{double}': '[-.0-9]+',
    '{string}': '\\"(.*?)\\"',
  };

  @override
  FutureOr<String?> generate(LibraryReader library, BuildStep buildStep) async {
    if (library.annotatedWithExact(_whenChecker).isEmpty &&
        library.annotatedWithExact(_thenChecker).isEmpty) {
      return null;
    }
    final resultMap = <String, String>{};
    for (final element in library.allElements) {
      final annotation;

      if (_whenChecker.hasAnnotationOfExact(element)) {
        annotation = _whenChecker.firstAnnotationOf(element);
      } else if (_thenChecker.hasAnnotationOfExact(element)) {
        annotation = _thenChecker.firstAnnotationOf(element);
      } else {
        break;
      }

      _validateMethod(element);
      final definition = annotation.getField('definition')!.toStringValue();
      resultMap[_prepareDefinition(definition!)] = element.displayName;
    }
    return jsonEncode(resultMap);
  }

  void _validateMethod(Element element) {
    if (element is! ExecutableElement) {
      throw('${element.displayName} is not a method');
    }

    _checkIsMethodPublic(element);
    _checkFirstParamIsContext(element);
  }

  void _checkIsMethodPublic(Element element) {
    if (!element.isPublic) {
      Exception('Method ${element.displayName} must be public');
    }
  }

  void _checkFirstParamIsContext(ExecutableElement element) {
    final firstParam = element.parameters.first;
    if (firstParam.runtimeType.toString() != 'FlucumberContext') {
      throw 'First parameter of ${element.displayName} must be a FlucumberContext';
    }
  }

  String _prepareDefinition(String definition) {
    String result = definition;
    for (final varType in _variablesPatterns.keys) {
      if (definition.contains(varType)) {
        result = definition.replaceAll(varType, _variablesPatterns[varType]!);
      }
    }
    return result;
  }

}
