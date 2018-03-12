void setup() {
  size(800, 800);
  background(0);
  stroke(255,28);
  noFill();
  crearCirculo(width/2, height/2, height*2, 7);
  saveFrame("f_"+random(100));
}

void crearCirculo(float x, float y, float d, float n) {
  line(x,y-d/20,x,y+d/20);
  line(x-d/20,y,x+d/20,y);
  ellipse(x, y, d, d);
  n--;
  if (n > 0) {
    int cant = int(random(3,8));
    float da = TWO_PI/cant;
    beginShape();
    for(int i = 0; i < cant; i++){
      float ax = x+cos(da*i)*d/4; 
      float ay = y+sin(da*i)*d/4;
      vertex(ax,ay);
      crearCirculo(ax, ay, d/2, n);
    }
    endShape(CLOSE);
  }
}
