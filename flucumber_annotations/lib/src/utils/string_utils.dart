extension StringExtension on String {
  List<int> allIndexesOf(Pattern string) {
    final indexes = <int>[];
    int? lastIndex;
    do {
      if (lastIndex != null && lastIndex > length) {
        return indexes;
      }

      lastIndex = lastIndex == null ? indexOf(string) : indexOf(string, lastIndex + 1);

      if (lastIndex != -1) {
        indexes.add(lastIndex);
      }
    } while (lastIndex != -1);

    return indexes;
  }
}
