import 'package:clicker/main.dart' as app;
import 'package:flucumber_annotations/flucumber_annotations.dart';

import 'app_test.flucumber.dart';

@Flucumber(
  scenariosPath: 'integration_test/ru/scenarios',
  language: 'ru',
)
void main() {
  runIntegrationTests(app.main);
}
