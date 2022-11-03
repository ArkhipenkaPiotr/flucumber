import 'package:flucumber_generator/src/steps_file_reference.dart';

abstract class ConfigSnippetGenerator {
  String generate(List<StepsDefinitionFileMetadata> definitions);
}
