import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:flucumber/src/annotations.dart';
import 'package:source_gen/source_gen.dart';


class FlucumberGenerator extends GeneratorForAnnotation<FlucumberStep> {
  @override
  generateForAnnotatedElement(Element element, ConstantReader annotation, BuildStep buildStep) {
    print('Try to generate flucumber');
    final classBuffer = StringBuffer();
    classBuffer.writeln('class FlucumberGenerated {');
    classBuffer.writeln('}');

    return classBuffer.toString();
  }
}
