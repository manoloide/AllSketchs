float time;

void setup() {
  size(960, 560, P2D);
}

void draw() {

  float time = millis()*0.0002;
  time = pow(time%1, 1.2);

  background(210);

  float ix = width*0.5;
  float iy = height*0.8;

  line(ix, iy, ix, iy-time*height*0.6);
}

class Rama {
  ArrayList<Rama> ramas;
  float ix, iy, ss, aa;
  Rama parent; 
  float time; 
  //float ix, iy;
  Rama(float ix, float iy, float ss, float aa) {
    this.ix = ix; 
    this.iy = iy;
  }
}
