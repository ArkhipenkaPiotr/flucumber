import 'package:flucumber/flucumber.dart';
import 'package:flucumber_annotations/flucumber_annotations.dart';
import 'package:flutter_test/flutter_test.dart';

@But('Assert that result of game is {int} clicks')
Future assertThatResultOfGameIsNClicks(FlucumberContext context, int clicks) async {
  final finder = find.text('Your result: $clicks');
  expect(finder, findsOneWidget);
}
