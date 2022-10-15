import 'package:flucumber/flucumber.dart';
import 'package:flucumber_generator/flucumber_generator.dart';
import 'package:flutter_test/flutter_test.dart';

// part 'counter_step.g.dart';

@When('App is opened')
void whenAppIsOpened(WidgetTester tester) {}

@Then('Click {int} times to plus button')
void thenClickNTimesToPlusButton(WidgetTester tester, int times) {}
