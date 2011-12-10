class HighScore {
  String filename = "highscores.txt";
  String[] scores;

  HighScore() {
    scores = loadStrings(filename);
  }

  void addScore(score) {
    scores.add(score=);
    saveStrings(filename, scores);
  }
}
