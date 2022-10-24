import 'package:clicker/screen/clicker_game_in_action_screen.dart';
import 'package:clicker/screen/game_over_screen.dart';
import 'package:flucumber/flucumber.dart';
import 'package:flucumber_annotations/flucumber_annotations.dart';
import 'package:flutter_test/flutter_test.dart';

@Then('Assert that game is started')
Future assertThatGameIsStarted(FlucumberContext context) async {
  expect(find.byType(ClickerGameInActionScreen).hitTestable(), findsOneWidget);
}

@Then('Assert that game title is {string}')
Future assertThatGameTitleIs(FlucumberContext context, String title) async {}

@Then('Click to counter {int} times')
Future clickToCounterNTimes(FlucumberContext context, int times) async {}

@Then('Assert that number on screen is {int}')
Future assertThanNumberOnScreenIsN(FlucumberContext context, int times) async {}

@Then('Wait for the end of the game')
Future waitForTheEndOfTheGame(FlucumberContext context) async {
  await context.tester.pumpUntilVisible(find.byKey(GameOverScreen.screenKey));
}
