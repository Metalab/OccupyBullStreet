class Student extends BoundingBox {
  color col;
  float speed = int(random(10, 40));

  Student() {
    super(int(random(0, 200)), 0, 20, 20);
    col = color(0, 200, 0);
  }

  // update the position
  void update() {
    y += speed;
  }

  void draw() {
    ellipseMode(CORNER);
    stroke(col);
    fill(col);
    ellipse(x, y, w, h);
  }
}
