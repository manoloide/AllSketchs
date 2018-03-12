class Punto {
  float x, y;

  Punto(float nx,float ny) {
    x = nx;
    y = ny;
  }
  
  void draw(){
    ellipse(x,y,5,5);
  }
}

