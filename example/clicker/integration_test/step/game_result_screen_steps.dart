import 'package:clicker/screen/game_over_screen.dart';
import 'package:flucumber/flucumber.dart';
import 'package:flucumber_annotations/flucumber_annotations.dart';
import 'package:flutter_test/flutter_test.dart';

@But('Make sure that result of game is {int} clicks')
@But('Убедиться, что результат игры - {int} кликов')
Future assertThatResultOfGameIsNClicks(
    FlucumberContext context, int clicks,) async {
  final finder = find.text('Your result: $clicks');
  expect(finder, findsOneWidget);
}

@Then('Make sure the best result is {int}')
@Then('Убедиться, что лучший результат - {int}')
Future assertThatBestResultOfGameIsNClicks(
    FlucumberContext context, int clicks,) async {
  final finder = find.text('Best result: $clicks');
  expect(finder, findsOneWidget);
}

@Then('Start the game again')
@Then('Начать игру заново')
Future startGameAgain(FlucumberContext context) async {
  final button = find.byKey(GameOverScreen.restartGameButtonKey).hitTestable();
  await context.tester.tap(button);
}
