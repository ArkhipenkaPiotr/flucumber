library flucumber;

import 'package:build/build.dart';
import 'package:flucumber/src/generator.dart';
import 'package:source_gen/source_gen.dart';

export 'package:flucumber/src/annotations.dart';

Builder flucumberBuilder(BuilderOptions options) => LibraryBuilder(FlucumberGenerator(), generatedExtension: '.flucumber.dart');
