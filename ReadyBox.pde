class ReadyBox {
  color col;

  ReadyBox() {
    col = color(255, 0, 0);
  }

  // update the position
  void draw() {
    rectMode(CENTER);
    stroke(col);
    fill(col);
    rect(100, 100, 100, 100);
  }
}
