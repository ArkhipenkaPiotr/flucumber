import 'package:clicker/screen/clicker_game_in_action_screen.dart';
import 'package:clicker/screen/game_over_screen.dart';
import 'package:flucumber/flucumber.dart';
import 'package:flucumber_annotations/flucumber_annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

@Then('Make sure that game is started')
@Then('Убедиться, что игра запущена')
Future assertThatGameIsStarted(FlucumberContext context) async {
  expect(find.byType(ClickerGameInActionScreen).hitTestable(), findsOneWidget);
}

@And('Make sure that game title is {string}')
@And('Убедиться, что заголовок игры {string}')
Future assertThatGameTitleIs(FlucumberContext context, String title) async {
  final widget = find
      .byKey(ClickerGameInActionScreen.gameTitleKey)
      .evaluate()
      .first
      .widget as Text;
  expect(widget.data, equals(title));
}

@And('Click to counter {int} times')
@And('Нажать на счётчик {int} раз')
Future clickToCounterNTimes(FlucumberContext context, int times) async {
  for (var i = 0; i < times; i++) {
    final finder =
    find.byKey(ClickerGameInActionScreen.clickSpaceKey).hitTestable();
    await context.tester.tap(finder);
    await context.tester.pump();
  }
}

@And('Make sure that number on screen is {int}')
@And('Убедиться, что номер на экране - {int}')
Future assertThanNumberOnScreenIsN(FlucumberContext context, int times) async {
  expect(find.text('Clicks: $times'), findsOneWidget);
}

@Then('Wait for the end of the game')
@Then('Подождать окончания игры')
Future waitForTheEndOfTheGame(FlucumberContext context) async {
  await context.tester.pumpUntilVisible(find.byKey(GameOverScreen.screenKey));
}
