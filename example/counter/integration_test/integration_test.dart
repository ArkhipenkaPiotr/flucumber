import 'package:flucumber/flucumber.dart';
import 'package:flucumber_generator/flucumber_generator.dart';

import 'integration_test.flucumber.dart';

@Flucumber(scenariosPath: 'integration_test/scenarios')
void main() {
  runIntegrationTest();
}
