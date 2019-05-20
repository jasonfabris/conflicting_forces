
float r;
ArrayList<Attractor> attrs;
float[] attr_str;
Pacer p;
String fname = String.format("C:/Users/Jason/Documents/Processing Projects/Output/conflict_frcs_v1_%d%d%d%d%d.tif", year(), month(), day(), hour(), minute(), second());
String str1;
String str2;
PGraphics pg;

void setup() {
  
  pg = createGraphics(5000,5000);
  pg.beginDraw();
  pg.colorMode(HSB, 360,100,100);
  pg.background(200, 10, 10);
  
  long seed = (long)random(1000000);
  randomSeed(seed);
  
  colorMode(HSB, 360, 100, 100);
  size(2000, 2000);
  background(200, 10, 10);
  r = width/3.95;
  int step = 80;  //113
  
  //initialize attractors
  attrs = new ArrayList<Attractor>();
  attr_str = new float[360/step + 1];
  int i = 0;
  for (int n = 0; n < 360; n += step) {      
      PVector l = new PVector(cos(radians(n)) * r, sin(radians(n)) * r);
      pushMatrix();
        translate(width/2, height/2);
        float s = random(-325, 325);
        attr_str[i] = s;  //so we can output all the strengths later
        attrs.add(new Attractor(l, s));
      popMatrix();  
      i++;
  }
    //add an extra in the middle
    float s = random(-10, 10);
    attr_str[360/step] = s;
    attrs.add(new Attractor(new PVector(width/2, height/2), s));
    attrs.add(new Attractor(new PVector(0,0), 200));
    
    boolean display_attrs = false;
    
    if(display_attrs) {
      for( Attractor a : attrs) {
        pushMatrix();
        translate(width/2, height/2);
          fill(300,100,100,100);
          circle(a.loc.x, a.loc.y, abs(a.str/10));
          println(a.loc.x, a.loc.y);
        popMatrix();
      }
    }
  
  //how wide will the path be?
  
  //new path follower
  float p_rad = width/4.8;
  float p_speed = 4;
  p = new Pacer(p_speed, p_rad);
  
  
  str1 = "w: " + width + " h: " + height + " seed: " + seed + " radius: " + r + " step: " + step + " pacer_spd: " + p_speed + " pacer rad: " + p_rad;
  str2 = join(nf(attr_str), " : ");
  
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
    
    //chg strength of middle attr
   // attrs.get(attrs.size()-1).update(attrs.get(attrs.size()-1).loc, attrs.get(attrs.size()-1).str * random(.999, 1.001));
}

void keyPressed() {
   
  if(key == 's') {
    
    String dte = String.format("%d%d%d%d%d", year() , month() , day() , hour() , minute() , second());
    fname = "C:/Users/Jason/Documents/Processing Projects/Output/conflict_frcs_v1_" + dte + ".tif";
    save(fname); 
     
    String[] lines = new String[2];
    lines[0] = str1;
    lines[1] = str2; 
    saveStrings("C:/Users/Jason/Documents/Processing Projects/Output/conflict_frcs_v1_cfg_" + dte + ".txt", lines);
    
    //pg.save("C:/Users/Jason/Documents/Processing Projects/Output/conflict_frcs_v1_big" + dte + ".tif");
  }
  
}
