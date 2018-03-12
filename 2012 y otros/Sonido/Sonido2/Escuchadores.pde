class Escuchador {
  float x, y, rad;
  color col;
  Escuchador(float nx, float ny) {
    x = nx;
    y = ny;
    rad = 10;
    col = color(random(256), 255, 255, 100);
  }

  void draw() {
    fill(col);
    ellipse(x, y, rad, rad);
  }

  void variarRad() {
    rad = in.left.get(511)*200;
  }
  void mover() {
    x += random(-1, 1);
    y += random(-1, 1);
    if(x < -20){
       x = width+20; 
    }
    if(x > width+20){
       x = -20; 
    }
    if(y < -20){
       y = height+20; 
    }
    if(y > height+20){
       y = -20; 
    }
  }
}

