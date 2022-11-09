import 'package:clicker/screen/clicker_game_in_action_screen.dart';
import 'package:clicker/screen/game_over_screen.dart';
import 'package:flucumber/flucumber.dart';
import 'package:flucumber_annotations/flucumber_annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

@Then('Убедиться, что игра запущена')
Future assertThatGameIsStarted(FlucumberContext context) async {
  expect(find.byType(ClickerGameInActionScreen).hitTestable(), findsOneWidget);
}

@And('Убедиться, что заголовок игры {string}')
Future assertThatGameTitleIs(FlucumberContext context, String title) async {
  final widget = find.byKey(ClickerGameInActionScreen.gameTitleKey).evaluate().first.widget as Text;
  expect(widget.data, equals(title));
}

@And('Нажать на счётчик {int} раз')
Future clickToCounterNTimes(FlucumberContext context, int times) async {
  for (var i = 0; i < times; i++) {
    final finder = find.byKey(ClickerGameInActionScreen.clickSpaceKey).hitTestable();
    await context.tester.tap(finder);
    await context.tester.pump();
  }
}

@And('Убедиться, что номер на экране - {int}')
Future assertThanNumberOnScreenIsN(FlucumberContext context, int times) async {
  expect(find.text('Clicks: $times'), findsOneWidget);
}

@Then('Подождать окончания игры')
Future waitForTheEndOfTheGame(FlucumberContext context) async {
  await context.tester.pumpUntilVisible(find.byKey(GameOverScreen.screenKey));
}
