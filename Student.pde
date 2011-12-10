class Student extends BoundingBox {
  color col;
  float speed = 5;//int(random(1, 10));
  PImage alienImg;
  int imgIndex;
  int laneIndex;
  boolean alive;
  int lane;
  boolean outsideScreen;

  String[] images = {"protestor.03","protestor.02","protestor.01"};
  int[] lanes = {100,200,300,400,500};

  Student() {
    super(0, 0, 20, 20);
    imgIndex = int(random(images.length));
    laneIndex = int(random(lanes.length));
    col = color(0, 200, 0);
    alive = true;
    outsideScreen = false;
    x = lanes[laneIndex];
    alienImg = loadImage(images[imgIndex]+".up.png");
  }

  // update the position
  void update() {
    y += speed;
    if(y-h/2 >= height) {
      outsideScreen=true;
    }
  }

  boolean isOutsideScreen(){
    if(outsideScreen) return true;
    else return false;
  }

 void die(){
   this.alive = false;
   alienImg = loadImage(images[imgIndex]+".down.png");
 }

  void draw() {
      w = alienImg.width;
      h = alienImg.height;
      //stroke(204, 102, 0);
      //rect(x, y, w, h);
      imageMode(CENTER);
      image(alienImg, x, y);
      //noStroke();
  }
}
