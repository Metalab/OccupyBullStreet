class Road
{
  PImage roadImg;
  float speed;
  int w;
  int h;
  float x;
  float y;
  
  Road()
  {
    speed = 4.0;
  }
  
  void setup(String imageName)
  {
    roadImg = loadImage(imageName);
    w = roadImg.width;
    h = roadImg.height;
    x = 0;
    y = -480;
  }
  
  void resetPos()
  {
    y = -480;
  }
  
  void update()
  {
    y += speed;
    if (y >= 24)
    {
      resetPos();
    }
  }
  
  void draw()
  {
    imageMode(CORNER);
    image(roadImg, x, y);
  }
}
