class Punto{
  float x,y;
  
  Punto(float nx, float ny){
    x = nx;
    y = ny; 
  }
  
  void draw(){
    ellipse(x,y,5,5);
  }
  
  void mover(){
    x = x + random(-0.8,0.8);
    if(x > width){
      x = width;
    }else if(x<0){
      x = 0; 
    }
    y = y + random(-0.8,0.8);
    if(y > height){
      y = height;
    }else if(y<0){
      y = 0; 
    }
  }
}
