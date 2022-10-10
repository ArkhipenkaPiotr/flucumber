import 'package:flucumber/src/context/flucumber_context.dart';

class StepRunner {
  final String name;
  final dynamic _runnerFunction;

  StepRunner(this.name, this._runnerFunction);

  Future runStep(FlucumberContext context) async {
    if (_runnerFunction is Future Function()) {
      (_runnerFunction as Function).call();
    }
  }
}
