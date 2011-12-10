class BoundingBox {
  // variables
  float x;
  float y;
  float w;
  float h;

  // constructor
  BoundingBox(int x, int y, int w, int h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }

  // returns true if the given box overlaps
  boolean overlaps(BoundingBox box) {
    return (box.x+box.w >= x && // does box's right edge overlap the other's left edge
      box.x <= x+w && // does box's left edge overlap the other's right edge
      box.y+box.h >= y && // does box's bottom edge overlap the other's top edge
      box.y <= y+h); // does box's top edge overlap the other's bottom edge
  }
  
}
