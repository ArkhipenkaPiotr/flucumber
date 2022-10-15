import 'dart:async';
import 'dart:convert';

import 'package:build/build.dart';
import 'package:flucumber_generator/src/annotations.dart';
import 'package:source_gen/source_gen.dart';

const TypeChecker _whenChecker = TypeChecker.fromRuntime(When);
const TypeChecker _thenChecker = TypeChecker.fromRuntime(Then);

class FlucumberStepsGenerator extends Generator {
  @override
  FutureOr<String?> generate(LibraryReader library, BuildStep buildStep) async {
    if (library.annotatedWithExact(_whenChecker).isEmpty &&
        library.annotatedWithExact(_thenChecker).isEmpty) {
      return null;
    }
    final resultMap = <String, String>{};
    for (final element in library.allElements) {
      if (_whenChecker.hasAnnotationOfExact(element)) {
        final annotation = _whenChecker.firstAnnotationOf(element);
        final definition = annotation!.getField('definition')!.toStringValue();
        resultMap[definition!] = element.displayName;
      }
      if (_thenChecker.hasAnnotationOfExact(element)) {
        final annotation = _thenChecker.firstAnnotationOf(element);
        final definition = annotation!.getField('definition')!.toStringValue();
        resultMap[definition!] = element.displayName;
      }
    }
    return jsonEncode(resultMap);
  }
}
