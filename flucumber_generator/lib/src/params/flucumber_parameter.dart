class FlucumberParameter {
  static List<FlucumberParameter> allSupportedParams = [
    FlucumberParameter(
      name: '{int}',
      matcher: '[-0-9]+',
      dartType: int,
    ),
    FlucumberParameter(
      name: '{double}',
      matcher: '[-.0-9]+',
      dartType: double,
    ),
    FlucumberParameter(
      name: '{string}',
      matcher: '\\"(.*?)\\"',
      dartType: String,
    ),
  ];

  final String name;
  final String matcher;
  final Type dartType;

  FlucumberParameter({
    required this.name,
    required this.matcher,
    required this.dartType,
  });
}
