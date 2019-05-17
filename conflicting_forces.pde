
float r;
ArrayList<Attractor> attrs;
float[] attr_str;
Pacer p;
String fname = String.format("C:/Users/Jason/Documents/Processing Projects/Output/conflict_frcs_v1_%d%d%d%d%d.tif", year(), month(), day(), hour(), minute(), second());
String str1;
String str2;


void setup() {
  
  long seed = (long)random(1000);
  randomSeed(seed);
  
  colorMode(HSB, 360, 100, 100);
  size(2000, 1600);
  background(200, 10, 10);
  r = width/2.55;
  int step = 103;  //113
  
  //initialize attractors
  attrs = new ArrayList<Attractor>();
  attr_str = new float[360/step + 1];
  int i = 0;
  for (int n = 0; n < 360; n += step) {      
      PVector l = new PVector(cos(radians(n)) * r, sin(radians(n)) * r);
      pushMatrix();
      translate(width/2, height/2);
        float s = random(-625, 625);
        attr_str[i] = s;  //so we can output all the strengths later
        attrs.add(new Attractor(l, s));
        fill(100,100,100);
        //circle(l.x, l.y, 30);
      popMatrix();
      i++;
  }
    //add an extra in the middle
    float s = random(-30, 30);
    attr_str[360/step] = s;
    attrs.add(new Attractor(new PVector(width/2, height/2), s));
  
  //how wide will the path be?
  
  //new path follower
  float p_rad = width/4.2;
  float p_speed = 30;
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
    
  }
  
}
