// A class to describe a group of Particles
// An ArrayList is used to manage the list of Particles 

class ParticleSystem {

  // An arraylist for all the particles
  ArrayList particles;    
  // An origin point for where particles are born
  PVector origin = new PVector(10.0, 20.0);        

  ParticleSystem(int num, PVector v) {
    // Initialize the arraylist
    particles = new ArrayList();             
    
    // Store the origin point 
    origin = v.get();                        
    
    // Add "num" amount of particles to the arraylist
    for (int i = 0; i < num; i++) {
      particles.add(new Particle(origin));    
    }
  }

  void run() {
    // Cycle through the ArrayList backwards b/c we are deleting
    for (int i = particles.size() - 1; i >= 0; i--) {
      Particle p = (Particle) particles.get(i);
      p.run();
      if (p.dead()) {
        particles.remove(i);
      }
    }
  }

  void addParticle() {
    particles.add(new Particle(origin));
  }

  void addParticle(float x, float y) {
    particles.add(new Particle(new PVector(x,y)));
  }

  void addParticle(Particle p) {
    particles.add(p);
  }

  // A method to test if the particle system still has particles
  boolean dead() {
    if (particles.isEmpty()) {
      return true;
    } 
    else {
      return false;
    }
  }
  
}

