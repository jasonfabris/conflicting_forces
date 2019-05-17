class Attractor {
//blob that attracts passing agents

float str;
PVector loc;

Attractor(PVector _loc, float _str) {
    loc = _loc.copy();
    str = _str;
    
}
 
PVector attract(Pacer p) {
  PVector frc = PVector.sub(loc, p.loc);
    float distance = frc.mag();
    distance = constrain(distance, .25, 1.25);
    
    frc.normalize();
  //  strength = get_cur_frc();// * (distance * distance);
    frc.mult(str);
     
  //println("Frc: ", frc.x, frc.y); 
    return frc;
}

void display() {
  
}
  
}
