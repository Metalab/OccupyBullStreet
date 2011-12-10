class BoundingBox {
  // variables
  float x;
  float y;
  float w;
  float h;

  // constructor
  BoundingBox(float x, float y, int w, int h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }

  // returns true if the given box overlaps
  boolean overlaps(BoundingBox box) {
   return (y+h/2 >= int(box.y-box.h/2) &&
     x-w/2 <= int(box.x+box.w/2) &&
     x+w/2 >= int(box.x-box.w/2));
  }
}
