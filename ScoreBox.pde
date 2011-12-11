class ScoreBox {
  int score;
  boolean hasScoredYet = false;
  PImage dollarBill;

  ScoreBox() {
    score = 0;
    dollarBill = loadImage("dollarbill.jpg");
  }

  void scoreFuckYeah() {
    hasScoredYet = true;
    score += 1000 + int(random(1, 100));;
  }

  void draw() {
    image(dollarBill, 420, 20);
    text("" + score, 530, 45);
  }
}
