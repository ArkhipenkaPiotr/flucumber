import 'package:flucumber/src/model/example_variable.dart';

import 'example_value.dart';

class Examples {
  final String? name;
  final List<ExampleVariable> variables;

  Examples({
    required this.name,
    required this.variables,
  });

  List<ExampleValue> getValuesOf(int index) {
    return variables
        .map((e) => ExampleValue(e.variableName, e.values[index]))
        .toList();
  }
}
