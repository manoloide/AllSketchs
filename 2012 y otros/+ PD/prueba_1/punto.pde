class Punto{
  float x,y,vel;
  
  Punto(float nx, float ny){
    x = nx;
    y = ny;
    vel = 1; 
  }
  
  void draw(){
    noStroke();
    ellipse(x,y,5,5);
  }
  
  void mover(){
    float distx,disty,ang;
    
    distx = x-width/2;
    disty = y-height/2;
    ang = atan2(disty, distx);
    x -= cos(ang)*vel;
    y -= sin(ang)*vel;
  }
}
