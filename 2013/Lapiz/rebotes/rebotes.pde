void setup() {
  size(800, 800);
  thread("dibujar");
}

void draw() {
}

void dibujar() {
  background(255);
  stroke(0,20);
  for (int i = 0; i < 2000; i++) {
    float cx = random(width);
    float cy = random(height);
    float rad = random(20, 80);
    float ang = 0;
    float x = cx + cos(ang)*rad;
    float y = cy + sin(ang)*rad;
    float ax, ay;
    for (int j = 1; j < rad*2; j++) {
      ax = x;
      ay = y;
      ang = map(j, 0, rad*2, TWO_PI, PI);
      x = cx + cos(ang)*rad;
      y = cy + sin(ang)*rad;
      linea(ax,ay,x,y,0.8,5);
      linea(ax,ay,x,y,2,2);
    }
  }
}


void linea(float x1, float y1, float x2, float y2, float noise, float det) {
  float dis = dist(x1, y1, x2, y2);
  float ang = atan2(y2-y1, x2-x1);
  float ax = x1;
  float ay = y1;
  for (int i = 1; i < dis; i+=det) {
    float ra = random(TWO_PI);
    float rd = random(noise);
    float x = x1+cos(ang)*i+cos(ra)*rd;
    float y = y1+sin(ang)*i+sin(ra)*rd;
    line(ax, ay, x, y);
    ax = x;
    ay = y;
  }
}
