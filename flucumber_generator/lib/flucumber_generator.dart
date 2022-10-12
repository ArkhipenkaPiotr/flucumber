/// Support for doing something awesome.
///
/// More dartdocs go here.
library flucumber_generator;

import 'package:build/build.dart';
import 'package:flucumber_generator/src/generator.dart';
import 'package:source_gen/source_gen.dart';

export 'package:flucumber_generator/src/annotations.dart';
// export '../../flucumber_runners/lib/src/runners/feature_runner.dart';
// export 'package:flucumber/src/runners/scenario_runner.dart';
// export 'package:flucumber/src/runners/step_runner.dart';

Builder flucumberBuilder(BuilderOptions options) => LibraryBuilder(FlucumberGenerator(), generatedExtension: '.flucumber.dart');

