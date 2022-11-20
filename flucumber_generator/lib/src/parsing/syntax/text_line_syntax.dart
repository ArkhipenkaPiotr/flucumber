import '../languages/dialect.dart';

import '../runnables/debug_information.dart';
import '../runnables/text_line.dart';
import 'regex_matched_syntax.dart';

class TextLineSyntax extends RegExMatchedGherkinSyntax<TextLineRunnable> {
  @override

  /// Regex needs to make sure it does not match comment lines or empty whitespace lines
  RegExp pattern(GherkinDialect dialect) => RegExp(
        r'^\s*(?!(\s*#\s*.+)|(\s+)).+$',
        multiLine: false,
        caseSensitive: false,
      );

  @override
  TextLineRunnable toRunnable(
    String line,
    RunnableDebugInformation debug,
    GherkinDialect dialect,
  ) {
    final runnable = TextLineRunnable(debug)
      ..originalText = line
      ..text = line.trim();
    return runnable;
  }
}
