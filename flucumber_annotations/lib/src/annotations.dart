class FlucumberStep {
  final String definition;

  const FlucumberStep(this.definition);
}

class When extends FlucumberStep {
  const When(String definition) : super(definition);
}

class Then extends FlucumberStep {
  const Then(String definition) : super(definition);
}

class Given extends FlucumberStep {
  const Given(String definition) : super(definition);
}

class And extends FlucumberStep {
  const And(String definition) : super(definition);
}

class But extends FlucumberStep {
  const But(String definition) : super(definition);
}

class Flucumber {
  final String scenariosPath;
  final String language;

  const Flucumber({
    required this.scenariosPath,
    this.language = 'en',
  });
}
