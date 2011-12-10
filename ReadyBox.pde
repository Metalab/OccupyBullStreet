class ReadyBox {
  color col;

  ReadyBox() {
    col = color(255, 0, 0);
  }

  void move() {
    col = color(240, 226, 80);
  }

  void ready() {
    col = color(0, 255, 0);
  }

  // update the position
  void draw() {
    ellipseMode(CENTER);
    stroke(col);
    fill(col);
    ellipse(516, 447, 16, 16);
  }
}
