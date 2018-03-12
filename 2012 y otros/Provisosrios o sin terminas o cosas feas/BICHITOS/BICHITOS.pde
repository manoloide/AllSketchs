
Particula[] p;
int cant = 100;
float variacion = 0.1;

void setup() {
  size(400, 400);
  p = new Particula[cant];
  for (int i = 0; i < cant; i++) {
    p[i] = new Particula(random(width), random(height));
  }
  noStroke();
}
void draw() {
  variacion += 0.1;
  fill(0, 5);
  rect(0, 0, width, height);
  fill(255);
  for (int i = 0; i < cant; i++) {
    p[i].act();
  }
}


class Particula {
  float x, y, ang;
  Particula(float nx, float ny) {
    x = nx; 
    y = ny;
    ang = random(2*PI);
  }
  void act() {
    ang += noise(variacion+((x-y)/10))-0.5;
    x += cos(ang);
    y += sin(ang);
    if (x < 0){
       x = width; 
    }else if ( x > width){
       x = 0;
    } 
    if (y < 0){
       y = height; 
    }else if ( y > height){
       y = 0;
    }
    draw();
  }

  void draw() {
    ellipse(x, y, 2, 2);
  }
}

