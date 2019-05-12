
float r;
ArrayList<Attractor> attrs;
Pacer p;

void setup() {
  colorMode(HSB, 360, 100, 100);
  size(900,900);
  background(200, 10, 10);
  r = width/3.5;
  
  //initialize attractors
  attrs = new ArrayList<Attractor>();
  for (int n = 0; n < 360; n += 70) {      
      PVector l = new PVector(cos(radians(n)) * r, sin(radians(n)) * r);
      pushMatrix();
      translate(width/2, height/2);
        attrs.add(new Attractor(l, random(-5, 5)));
        fill(100,100,100);
        //circle(l.x, l.y, 30);
      popMatrix();
  }
    attrs.add(new Attractor(new PVector(width/2, height/2), 10));
  
  //how wide will the path be?
  
  //new path follower
  p = new Pacer(9, width/2.9);
}

void draw() {
    //background(200, 10, 10);
    
    
    //move along path 
    p.update_path();
    //distort because of attrs
    for (Attractor a : attrs) {
       p.apply_frc(a.attract(p)); 
    }
    
    //apply everything
    p.update();
    //println(p.loc.x, p.loc.y);
    
    //draw 
    pushMatrix();
      translate(width/2, height/2);
      p.display();     
    popMatrix();
}
