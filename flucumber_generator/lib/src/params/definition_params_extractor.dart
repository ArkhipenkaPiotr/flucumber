import 'package:flucumber_generator/src/params/flucumber_parameter.dart';
import 'package:flucumber_generator/src/string_utils.dart';

class DefinitionParamsExtractor {
  List<Type> getExpectedParams(String definition) {
    final appearances = <ParamAppearance>[];
    for (final param in FlucumberParameter.allSupportedParams) {
      for (final index in definition.allIndexesOf(param.name)) {
        appearances.add(ParamAppearance(param, index));
      }
    }
    final sortedByIndexAsc = appearances..sort((a, b) => a.appearanceIndex - b.appearanceIndex);

    return sortedByIndexAsc.map((e) => e.parameter.dartType).toList();
  }
}

class ParamAppearance {
  final FlucumberParameter parameter;
  final int appearanceIndex;

  ParamAppearance(this.parameter, this.appearanceIndex);
}
