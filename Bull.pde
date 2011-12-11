class Bull extends BoundingBox{  
  color col;
  Frames bullFrames;
  int currentFrame = 0;
  int frameCounter = 0;
  
  Bull(float x, float y){
    super(x, y, 150, 200);
    bullFrames = new Frames("bull_", "png", 8);
    col = color(126, 255, 102);
  }
  
  PImage nextFrameImage() {
    PImage currentImage = bullFrames.images[currentFrame];

    if (frameCounter % 4 == 0) {
      currentFrame++;
    }

    frameCounter++;

    if (currentFrame >= bullFrames.size()) {
      currentFrame = 0;
      frameCounter = 0;
    }

    return currentImage;
  }

  void setPosition(float x, float y){
    this.x = x;
    this.y = y;
  }
  
  void draw()
  {
    PImage bullImg = nextFrameImage();
    w = bullImg.width/1.5-10;
    h = bullImg.height/1.5;
    stroke(204, 102, 0);
    noFill();
    rectMode(CENTER);
    rect(x, y, w, h);
    imageMode(CENTER);
    image(bullImg, this.x-5, this.y, w,h);
    noStroke();
  }
}
