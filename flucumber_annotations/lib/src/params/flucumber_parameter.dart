class FlucumberType {
  static List<FlucumberType> allSupportedTypes = [
    FlucumberType(
      name: '{int}',
      matcher: '[-0-9]+',
      dartType: int,
      fromString: int.parse,
    ),
    FlucumberType(
      name: '{double}',
      matcher: '[-.0-9]+',
      dartType: double,
      fromString: double.parse,
    ),
    FlucumberType(
      name: '{string}',
      matcher: '\\"(.*?)\\"',
      dartType: String,
      fromString: (value) => value,
    ),
  ];

  final String name;
  final String matcher;
  final Type dartType;
  final dynamic Function(String value) fromString;

  FlucumberType({
    required this.name,
    required this.matcher,
    required this.dartType,
    required this.fromString,
  });
}
