import 'debug_information.dart';
import 'example.dart';
import 'runnable.dart';
import 'scenario.dart';
import 'tags.dart';

class ScenarioOutlineRunnable extends ScenarioRunnable {
  final List<ExampleRunnable> _examples = <ExampleRunnable>[];
  TagsRunnable? _pendingExampleTags;

  Iterable<ExampleRunnable> get examples => _examples;

  ScenarioOutlineRunnable(
    String name,
    String? description,
    RunnableDebugInformation debug,
  ) : super(
          name,
          description,
          debug,
        );

  @override
  void addChild(Runnable child) {
    switch (child.runtimeType) {
      case ExampleRunnable:
        if (_pendingExampleTags != null) {
          (child as ExampleRunnable).addChild(_pendingExampleTags!);
          _pendingExampleTags = null;
        }

        _examples.add(child as ExampleRunnable);
        break;
      case TagsRunnable:
        _pendingExampleTags = child as TagsRunnable;
        break;
      default:
        super.addChild(child);
    }
  }

  @override
  void onTagAdded(TagsRunnable tag) {
    for (final example in examples) {
      example.addTag(tag.clone(inherited: true));
    }
  }
}
