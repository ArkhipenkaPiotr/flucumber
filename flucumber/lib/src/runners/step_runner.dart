import 'package:flucumber_annotations/flucumber_annotations.dart';

import '../context/flucumber_context.dart';
import '../model/example_value.dart';

class StepRunner {
  final String actualStep;
  final String stepDefinition;
  final Function runnerFunction;

  final _paramsExtractor = DefinitionParamsExtractor();

  StepRunner({
    required this.actualStep,
    required this.runnerFunction,
    required this.stepDefinition,
  });

  Future runStep(FlucumberContext context, [List<ExampleValue>? exampleValues]) async {
    await context.tester.pumpAndSettle();

    await invokeRunnerFunction(context, exampleValues ?? []);

    await context.tester.pumpAndSettle();
  }

  String _replaceExampleVariablesWithValues(List<ExampleValue> exampleValues) {
    String result = actualStep;
    for (final exampleValue in exampleValues) {
      result = result.replaceAll('<${exampleValue.variableName}>', exampleValue.variableValue);
    }
    return result;
  }

  Future invokeRunnerFunction(FlucumberContext context, List<ExampleValue> exampleValues) async {
    if (runnerFunction is Future Function()) {
      await runnerFunction();
      return;
    }

    final actualStep = _replaceExampleVariablesWithValues(exampleValues);

    final params = _paramsExtractor.extractParams(stepDefinition, actualStep);

    switch (params.length) {
      case 0:
        await runnerFunction(context);
        break;
      case 1:
        await runnerFunction(
          context,
          params[0],
        );
        break;
      case 2:
        await runnerFunction(
          context,
          params[0],
          params[1],
        );
        break;
      case 3:
        await runnerFunction(
          context,
          params[0],
          params[1],
          params[2],
        );
        break;
      case 4:
        await runnerFunction(
          context,
          params[0],
          params[1],
          params[2],
          params[3],
        );
        break;
      case 5:
        await runnerFunction(
          context,
          params[0],
          params[1],
          params[2],
          params[3],
          params[4],
        );
        break;
      case 6:
        await runnerFunction(
          context,
          params[0],
          params[1],
          params[2],
          params[3],
          params[4],
          params[5],
        );
        break;
      case 7:
        await runnerFunction(
          context,
          params[0],
          params[1],
          params[2],
          params[3],
          params[4],
          params[5],
          params[6],
        );
        break;
    }
  }
}
