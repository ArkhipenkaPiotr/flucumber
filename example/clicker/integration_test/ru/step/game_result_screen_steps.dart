import 'package:flucumber/flucumber.dart';
import 'package:flucumber_annotations/flucumber_annotations.dart';
import 'package:flutter_test/flutter_test.dart';

@But('Убедиться, что результат игры - {int} кликов')
Future assertThatResultOfGameIsNClicks(FlucumberContext context, int clicks) async {
  final finder = find.text('Your result: $clicks');
  expect(finder, findsOneWidget);
}
