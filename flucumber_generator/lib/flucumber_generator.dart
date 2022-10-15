/// Support for doing something awesome.
///
/// More dartdocs go here.
library flucumber_generator;

import 'package:build/build.dart';
import 'package:flucumber_generator/src/flucumber_generator.dart';
import 'package:flucumber_generator/src/flucumber_steps_generator.dart';
import 'package:source_gen/source_gen.dart';

export 'package:flucumber_generator/src/annotations.dart';

Builder flucumberBuilder(BuilderOptions options) =>
    LibraryBuilder(FlucumberGenerator(), generatedExtension: '.flucumber.dart');

Builder flucumberStepsBuilder(BuilderOptions options) {
  return LibraryBuilder(
    FlucumberStepsGenerator(),
    formatOutput: (generated) => generated.replaceAll(RegExp(r'//.*|\n'), ''),
    generatedExtension: '.flucumber_steps.json',
  );
}
