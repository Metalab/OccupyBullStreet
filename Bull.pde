class Bull extends BoundingBox{  
  color col;
  PImage bullImg;
  
  Bull(float x, float y){
    super(x, y, 150, 200);
    bullImg = loadImage("bull.png");
    col = color(126, 255, 102);
  }
  
  void update() {
  
  }

  void setPosition(float x, float y){
    this.x = x;
    this.y = y;
  }
  
  void draw()
  {
    w = bullImg.width-10;
    h = bullImg.height;
    stroke(204, 102, 0);
    //rectMode(CENTER);
    //rect(x, y, w, h);
    imageMode(CENTER);
    image(bullImg, this.x-5, this.y);
    //noStroke();
  }
}
