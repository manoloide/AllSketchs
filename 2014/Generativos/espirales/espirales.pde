void setup() {
  size(600, 600);
  smooth(8);
  background(255);
  thread("generar");
}

void draw() {
}

void keyPressed() {
  if (key == 's') {
    saveFrame("#####");
  } 
  if (keyCode != ENTER) {
    noStroke();
    fill(random(240, 256), random(200));
    rect(0, 0, width, height);
    stroke(0,20);
  }  else {
    thread("generar");
  }
}

void generar() {
  stroke(0, 20);
  float ang = random(TWO_PI);
  float des = random(0.001, 0.1);
  int cant = int(random(3, 16));
  for (int i = 0; i < dist(0,0,width,height); i++) {
    figura(width/2, height/2, i, cant, ang);
    ang += des;
  }
}

void figura(float x, float y, float dim, int cant, float ang) {
  float rad = dim/2;
  float da = TWO_PI/cant;
  for (int i = 0; i < cant; i++) {
    line(x+cos(ang+da*i)*rad, y+sin(ang+da*i)*rad, x+cos(ang+da*(i-1))*rad, y+sin(ang+da*(i-1))*rad);
  }
}

void linea(float x1, float y1, float x2, float y2, float noise) {
  float dis = dist(x1, y1, x2, y2);
  float ang = atan2(y2-y1, x2-x1);
  float ax = x1;
  float ay = y1;
  for (int i = 1; i < dis; i++) {
    float ra = random(TWO_PI);
    float rd = random(noise);
    float x = x1+cos(ang)*i+cos(ra)*rd;
    float y = y1+sin(ang)*i+sin(ra)*rd;
    line(ax, ay, x, y);
    ax = x;
    ay = y;
  }
}
