import 'package:shared_preferences/shared_preferences.dart';

abstract class GameStatisticsRepository {
  const factory GameStatisticsRepository() = _PrefsGameStatisticsRepository;

  Future<int> get bestResult;

  Future<void> setBestResult(int result);
}

class _PrefsGameStatisticsRepository implements GameStatisticsRepository {
  static const _bestResultPrefsKey = 'best_result.feature';

  const _PrefsGameStatisticsRepository();

  Future<SharedPreferences> get _prefs => SharedPreferences.getInstance();

  @override
  Future<int> get bestResult async =>
      (await _prefs).getInt(_bestResultPrefsKey) ?? 0;

  @override
  Future<void> setBestResult(int result) async {
    await (await _prefs).setInt(_bestResultPrefsKey, result);
  }
}
