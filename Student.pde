class Student extends BoundingBox {
  color col;
  float speed = int(random(1, 10));
  PImage alienImg;
  boolean alive;

  Student() {
    super(int(random(0, 300)), 0, 20, 20);
    col = color(0, 200, 0);
    alive = true;
    alienImg = loadImage("protestor.03.up.png");
  }

  // update the position
  void update() {
    y += speed;
    if(y >= height) y = 0;
  }

  void draw() {
      w = alienImg.width;
      h = alienImg.height;
      image(alienImg, x, y);
  }
}
