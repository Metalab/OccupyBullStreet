class Student extends BoundingBox {
  color col;
  float speed = int(random(1, 10));
  PImage alienImg;

  Student() {
    super(int(random(0, 300)), 0, 20, 20);
    col = color(0, 200, 0);
    alienImg = loadImage("man.png");
  }

  // update the position
  void update() {
    y += speed;
  }

  void draw() {
    w = alienImg.width;
    h = alienImg.height;
    image(alienImg, x, y);
  }
}
