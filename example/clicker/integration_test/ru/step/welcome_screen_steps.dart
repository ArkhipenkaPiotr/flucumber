import 'package:clicker/screen/clicker_welcome_screen.dart';
import 'package:flucumber/flucumber.dart';
import 'package:flucumber_annotations/flucumber_annotations.dart';
import 'package:flutter_test/flutter_test.dart';

@Given('Приветственный экран открыт')
Future welcomeScreenIsOnDisplay(FlucumberContext context) async {
  expect(find.byType(ClickerWelcomeScreen).hitTestable(), findsOneWidget);
}

@Then('Нажать на кнопку старта игры')
Future clickToStartButton(FlucumberContext context) async {
  await context.tester.tap(find.byKey(ClickerWelcomeScreen.startGameKey));
}
