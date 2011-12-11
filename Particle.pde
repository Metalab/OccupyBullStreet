// A simple Particle class

class Particle {
  PVector loc;
  PVector vel;
  PVector acc;
  float r;
  float timer;

  // Another constructor (the one we are using here)
  Particle(PVector l) {
    acc = new PVector(-0.1,0,0);
    vel = new PVector(random(-10,0),random(-0,0),0);
    loc = l.get();
    r = 4.0;
    timer = 100.0;
  }

  void run() {
    update();
    render();
  }

  // Method to update location
  void update() {
    vel.add(acc);
    loc.add(vel);
    timer -= 1.0;
  }

  // Method to display
  void render() {
    ellipseMode(CENTER);
    stroke(255,random(100));
    fill(0,0 ,100);
    ellipse(loc.x,loc.y,r,r);
  }

  // Is the particle still useful?
  boolean dead() {
    if (timer <= 0.0) {
      return true;
    } 
    else {
      return false;
    }
  }

  void displayVector(PVector v, float x, float y, float scayl) {
    pushMatrix();
    // Translate to location to render vector
    translate(x,y);
    stroke(255);
    // Call vector heading function to get direction (note that pointing up is a heading of 0) and rotate
    rotate(v.heading2D());
    // Calculate length of vector & scale it to be bigger or smaller if necessary
    float len = v.mag()*scayl;
    popMatrix();
  } 

}

