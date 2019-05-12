class Pacer {
  
  PVector loc;
  PVector old_loc;
  float speed;
  float path_radius = width/4;
  float angle;
  float mass = 1;
  PVector acc;
  PVector vel;
  
  Pacer(float _speed, float _radius) {
    angle = 0;
    path_radius = _radius;
    loc = new PVector(cos(angle) * path_radius, sin(angle) * path_radius);
    speed = _speed;
    acc = new PVector(0,0);
    vel = new PVector(0,0);
    
  }
  
  void apply_frc(PVector frc) {
    PVector f = PVector.div(frc, mass); 
    acc.add(f);
    
  }
  
  void update_path() {
    old_loc = loc.copy();
    
    angle += speed * (TWO_PI/(frameRate*frameRate));
    loc = new PVector(cos(angle) * path_radius, sin(angle) * path_radius);
  }
  
  void update() {
   old_loc = loc.copy();
   
   vel.add(acc);
   loc.add(vel);
   acc.mult(0);
   vel.mult(0);
   path_radius += random(-1, 1);
}
  
  
  
  void display() {    
    noStroke();
    fill(30, 80, 85, 27);
    circle(loc.x, loc.y, 5);
    
  }
  
}
