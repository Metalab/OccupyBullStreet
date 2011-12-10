class ScoreBox {
  double score;
  boolean hasScoredYet = false;

  ScoreBox() {
    score = 0;
  }

  void scoreFuckYeah() {
    hasScoredYet = true;
    score += 1000;
  }

  void draw() {
    text("Score: " + score, 480, 30);
  }
}
