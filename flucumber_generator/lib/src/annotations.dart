class FlucumberStep {
  const FlucumberStep();
}

class When {
  final String definition;

  const When(this.definition);
}

class Then {
  final String definition;

  const Then(this.definition);
}

class Flucumber {
  final String scenariosPath;

  const Flucumber({required this.scenariosPath});
}
