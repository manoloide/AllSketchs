boolean fullscreen = true;

boolean crucess = false;
boolean polys = false;

int paleta[] = {
  #ECD078, 
  #D95B43, 
  #C02942, 
  #542437, 
  #53777A
};

void setup() {
  if (fullscreen) {
    size(displayWidth, displayHeight);
  } else {
    size(800, 600);
  }
}

void draw() {
  if (crucess) cruces();
  if (polys) polys();
}

void keyPressed() {
  if (key == 'b') back();
  else if (key == 'c') crucess = !crucess;
  else if (key == 'p') polys();
}


void back() {
  background(rcol());
}

void cruces() {
  int tt = 50;
  noStroke();
  fill(128-cos(frameCount*0.06)*127, 130);
  for (int j = -tt; j < height+tt; j+=tt) {
    for (int i = -tt; i < width+tt; i+=tt) {
      cross(i+frameCount%tt, j+frameCount%tt, tt*0.7, 0.3, 0);
    }
  }
}

void polys() {
  float x = random(width);
  float y = random(height);
  float d = random(height)*random(1);
  int c = int(random(3, 10));
  float a = random(TWO_PI);
  int cc = int(random(d)/30);
  cc += int(random(1,4));
  noStroke();
  float dd = d/cc;
  for (int i = cc; i > 0; i--) {
    fill(rcol());
    poly(x, y, dd*i, c, a);
  }
} 


int rcol() {
  return paleta[int(random(paleta.length))];
}

