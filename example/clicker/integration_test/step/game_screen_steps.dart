import 'package:flucumber/flucumber.dart';
import 'package:flucumber_generator/flucumber_generator.dart';

@Then('Assert that game is started')
Future assertThatGameIsStarted(FlucumberContext context) async {}

@Then('Assert that game title is {string}')
Future assertThatGameTitleIs(FlucumberContext context, String title) async {}

@Then('Click to counter {int} times')
Future clickToCounterNTimes(FlucumberContext context, int times) async {}

@Then('Assert that number on screen is {int}')
Future assertThanNumberOnScreenIsN(FlucumberContext context, int times) async {}

@Then('Wait for the end of the game')
Future waitForTheEndOfTheGame(FlucumberContext context) async {}