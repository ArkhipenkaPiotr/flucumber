import 'package:source_gen/source_gen.dart';

extension LibraryExtension on LibraryReader {
  Iterable<AnnotatedElement> allAnnotatedWith(
    TypeChecker checker, {
    bool throwOnUnresolved = true,
  }) sync* {
    for (final element in allElements) {
      final annotations = checker.annotationsOf(
        element,
        throwOnUnresolved: throwOnUnresolved,
      );
      for (final annotation in annotations) {
        yield AnnotatedElement(ConstantReader(annotation), element);
      }
    }
  }
}
