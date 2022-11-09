import 'package:clicker/main.dart' as app;
import 'package:flucumber_annotations/flucumber_annotations.dart';

import 'app_test.flucumber.dart';

@Flucumber(
  scenariosPath: 'integration_test/en/scenarios',
  language: 'en',
)
void main() {
  runIntegrationTests(app.main);
}
