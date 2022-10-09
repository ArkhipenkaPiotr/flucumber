import 'package:flucumber_annotations/flucumber_annotations.dart';

part 'counter_step.g.dart';

@FlucumberStep()
class CounterStep {
  @When('App is opened')
  void whenAppIsOpened() {}

  @Then('Click {int} times to plus button')
  void thenClickNTimesToPlusButton(int times) {}
}
