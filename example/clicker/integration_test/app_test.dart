// import 'app_test.flucumber.dart';

import 'package:clicker/main.dart' as app;
import 'package:flucumber_annotations/flucumber_annotations.dart';

import 'app_test.flucumber.dart';

@Flucumber(scenariosPath: 'integration_test/scenarios')
void main() {
  runIntegrationTests(app.main);
}