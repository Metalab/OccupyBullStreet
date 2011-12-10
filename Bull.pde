class Bull extends BoundingBox{  
  color col;
  
  Bull(){
    super(width/2, height-200/2, 150, 200);
    col = color(126, 255, 102);
  }
  
  void update() {
  
  }

  void setPosition(float x, float y){
    this.x=x;
    this.y=y; 
  }
  
  void draw()
  {
    rectMode(CENTER);
    stroke(col);
    fill(col);
    rect(this.x, this.y, w, h);
  }
}
