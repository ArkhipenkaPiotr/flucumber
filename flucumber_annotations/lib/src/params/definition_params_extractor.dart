import 'package:flucumber_annotations/src/utils/string_utils.dart';

import 'flucumber_parameter.dart';

class DefinitionParamsExtractor {
  List<TypeAppearance> _getExpectedTypes(String definition) {
    final appearances = <TypeAppearance>[];
    for (final param in FlucumberType.allSupportedTypes) {
      for (final index in definition.allIndexesOf(param.name)) {
        appearances.add(TypeAppearance(param, index));
      }
    }
    final sortedByIndexAsc = appearances..sort((a, b) => a.appearanceIndex - b.appearanceIndex);

    return sortedByIndexAsc;
  }

  List<Type> getExpectedParamsTypes(String definition) {
    final params = _getExpectedTypes(definition);

    return params.map((e) => e.parameter.dartType).toList();
  }

  List<dynamic> extractParams(String definition, String actualStep) {
    dynamic extractParam(TypeAppearance appearance) {
      final typeRegExp = RegExp(appearance.parameter.matcher);
      final searchString = actualStep.substring(appearance.appearanceIndex);
      final paramString = typeRegExp.stringMatch(searchString);

      return appearance.parameter.fromString(paramString!);
    }

    final appearances = _getExpectedTypes(definition);

    return appearances.map(extractParam).toList();
  }

  String definitionToRegexpFormat(String definition) {
    String resultString = definition;
    for (final param in FlucumberType.allSupportedTypes) {
      resultString = resultString.replaceAll(param.name, param.matcher);
    }

    return resultString;
  }
}

class TypeAppearance {
  final FlucumberType parameter;
  final int appearanceIndex;

  TypeAppearance(this.parameter, this.appearanceIndex);
}