import 'package:clicker/model/game_progress.dart';

class ClickerState {}

class InitialClickerState extends ClickerState {}

class GameInActionClickerState extends ClickerState {
  final int clicks;
  final GameProgress progress;

  GameInActionClickerState({
    required this.clicks,
    required this.progress,
  });
}

class GameResultsClickerState extends ClickerState {
  final int clicks;
  final int bestResult;

  GameResultsClickerState({
    required this.clicks,
    required this.bestResult,
  });
}
