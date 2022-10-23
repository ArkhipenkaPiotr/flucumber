enum GameProgress {
  low(0),
  medium(20),
  good(50),
  excellent(70);

  const GameProgress(this.clicksToAchieve);
  final int clicksToAchieve;
}