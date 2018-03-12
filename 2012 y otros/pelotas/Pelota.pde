class Pelota {
  float x, y, rad;

  Pelota(float nx, float ny) {
    x = nx;
    y = ny;
    rad = 10;
  }
  
  void draw(){
     ellipse(x,y,rad,rad); 
  }
  void actualizar(){
    Pelota aux;
    float ang;
    for(int i = 0; i < pelotas.size();i++){
       aux = (Pelota) pelotas.get(i);
       if ((dist(x,y,aux.x,aux.y) < (rad + aux.rad))&&this!=aux){
         ang = atan2(aux.y-y,aux.x-x);
         x -= cos(ang)*0.5;
         y -= sin(ang)*0.5;
       }  
    }
  }
}

