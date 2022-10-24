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
    await context.tester.pumpAndSettle();
    if (runnerFunction is Future Function()) {
      await runnerFunction.call();
    }
    if (runnerFunction is Future Function(FlucumberContext)) {
      await runnerFunction.call(context);
    }
    await context.tester.pumpAndSettle();
  }
}
