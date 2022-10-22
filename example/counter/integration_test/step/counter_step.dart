import 'package:flucumber/flucumber.dart';
import 'package:flucumber_generator/flucumber_generator.dart';
import 'package:flutter_test/flutter_test.dart';

@Then('Click {int} times to plus button')
Future thenClickNTimesToPlusButton(FlucumberContext context, int times) async {}

@When('App is opened')
Future whenAppIsOpened(FlucumberContext context) async {}

@Then('Assert that number on screen is not {int}')
Future assertThatNumberOnScreenIsNot(FlucumberContext context) async {}

@Then('Assert that number on screen is {int}')
Future assertThatNumberOnScreenIs(FlucumberContext context) async {}

@Then('Assert that timer value is {double}')
Future assertThatTimerValueIs(FlucumberContext context) async {}

