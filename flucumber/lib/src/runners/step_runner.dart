import '../context/flucumber_context.dart';

class StepRunner {
  final String actualStep;
  final String stepSource;
  final dynamic runnerFunction;

  StepRunner({
    required this.actualStep,
    required this.runnerFunction,
    required this.stepSource,
  });

  Future runStep(FlucumberContext context) async {
    if (runnerFunction is Future Function()) {
      await (runnerFunction as Function).call();
    }
  }
}
