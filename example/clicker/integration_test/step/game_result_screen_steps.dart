import 'package:flucumber/flucumber.dart';
import 'package:flucumber_generator/flucumber_generator.dart';

@Then('Assert that result of game is {int} clicks')
Future assertThatResultOfGameIsNClicks(FlucumberContext context, int clicks) async {}
