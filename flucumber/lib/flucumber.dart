library flucumber;

import 'package:build/build.dart';
import 'package:flucumber/src/generator.dart';
import 'package:source_gen/source_gen.dart';

Builder flucumberBuilder(BuilderOptions options) =>
    SharedPartBuilder([FlucumberGenerator()], 'generator');
