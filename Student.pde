class Student extends BoundingBox {
  color col;
  float speed;
  PImage alienImg;
  int imgIndex;
  int laneIndex;
  boolean alive;
  int lane;
  boolean outsideScreen;
  AudioPlayer dieSound;
  Frames explosionFrames;
  int currentFrame = 0;
  int frameCounter = 0;

  String[] images = {"03","02","01"};
  int[] lanes = {100,200,300,400,500};

  Student(Minim minim, int speed) {
    super(0, 0, 20, 20);
    imgIndex = int(random(images.length));
    laneIndex = int(random(lanes.length));
    col = color(0, 200, 0);
    alive = true;
    outsideScreen = false;
    this.speed = speed;
    x = lanes[laneIndex];
    y = int(random(-800, 0));
    alienImg = loadImage("protestor." + images[imgIndex] + ".up.png");
    dieSound = minim.loadFile("hit." + images[imgIndex] + ".aif");
    explosionFrames = new Frames("explosion_", "png", 3);
  }

  PImage nextFrameImage() {
    PImage currentImage = explosionFrames.images[currentFrame];
    if (frameCounter % 4 == 0) {
      currentFrame++;
    }
    frameCounter++;
    return currentImage;
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
   dieSound.play();
   alienImg = loadImage("protestor." + images[imgIndex] + ".down.png");
 }

  void draw() {
      w = alienImg.width;
      h = alienImg.height;
      //stroke(204, 102, 0);
      //rect(x, y, w, h);
      imageMode(CENTER);
      image(alienImg, x, y);
      if (this.alive == false && currentFrame <= 2)
      {
         PImage explosionImg = nextFrameImage();
         image(explosionImg, x, y);
      }
      //noStroke();
  }
}
