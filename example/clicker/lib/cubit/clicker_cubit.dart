import 'package:clicker/cubit/clicker_state.dart';
import 'package:clicker/model/game_progress.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ClickerCubit extends Cubit<ClickerState> {
  ClickerCubit() : super(InitialClickerState());

  final _gameProgressValuesDesc = GameProgress.values.toList()
    ..sort((value1, value2) => value2.clicksToAchieve - value1.clicksToAchieve);

  var _clicksCounter = 0;
  var _bestResult = 0;

  void startGame() {
    _clicksCounter = 0;
    emit(GameInActionClickerState(clicks: _clicksCounter, progress: GameProgress.low));
  }

  void onGameTimeout() {
    if (_clicksCounter > _bestResult) {
      _bestResult = _clicksCounter;
    }

    emit(GameResultsClickerState(
      clicks: _clicksCounter,
      bestResult: _bestResult,
    ));
  }

  void processClick() {
    emit(GameInActionClickerState(
        clicks: ++_clicksCounter, progress: _getProgressByClicks(_clicksCounter)));
  }

  GameProgress _getProgressByClicks(int clicks) {
    for (final value in _gameProgressValuesDesc) {
      if (clicks > value.clicksToAchieve) {
        return value;
      }
    }
    return GameProgress.low;
  }
}
