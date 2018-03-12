int seed = int(random(9999999));
float det = 0;

void setup() {
  size(displayWidth, displayHeight);
  smooth(16);
  frameRate(30);
}

void draw() {
  if (frameCount < 120) {
    translate(width/2, height/2);
    scale(frameCount/120.);
  }

  if (frameCount > 300) {
    translate(width/2, height/2);
    scale(map(frameCount, 300, 330, 1, 0));
  }
  if (frameCount%int(random(30, 60)) == 0) det += 1;
  det += 0.004;
  fondo();
  randomSeed(seed);
  noiseSeed(seed);
  int cant = 10;
  float x = noise(det)*width;
  float y = noise(det+10)*height;
  float d = map(noise(det*0.5+20), 0, 1, 140, 220);
  int c = 4;
  float ang = 0;
  for (int i = cant; i >= 0; i--) {
    float a = noise(det+i*0.01)*TWO_PI*2;
    float dx = cos(a)*40*i;
    float dy = sin(a)*40*i;
    stroke(8, 8);
    noFill();
    for (int j = 1; j <= 6; j++) {
      strokeWeight(j);
      poly(x+dx, y+dy, d, c, ang);
    }
    noStroke();
    fill(random(10, 250));
    poly(x+dx, y+dy, d, c, ang);
  }
  //saveFrame("####.png");
  if(frameCount >= 330) exit(); 
}

void keyPressed() {
  seed = int(random(9999999));
}

void poly(float x, float y, float d, int cant, float ang) {
  float r = d/2;
  float da = TWO_PI/cant;
  beginShape();
  for (int i = 0; i < cant; i++) {
    vertex(x+cos(ang+da*i)*r, y+sin(ang+da*i)*r);
  }
  endShape(CLOSE);
}

void fondo() {
  background(#36FF70);
  pushMatrix();
  float x = width/2;
  float y = height/2;
  float diag = dist(0, 0, width, height);
  float tt = 200;
  int dcant = (int(diag/tt)+1);
  float ang = TWO_PI*det*0.4;
  translate(x, y);
  rotate(ang);
  for (int j = -dcant; j <= dcant; j++) {
    for (int i = -dcant; i <= dcant; i++) {
      noStroke();
      fill(noise(det+i*dcant*2+j)*256);
      poly(i*tt, j*tt, tt, 4, PI/2);
      int cant = 0;
      if (frameCount > 180) cant = int((noise(det+i*dcant*2+j+20) - 0.4) * 10);
      float dt = tt/cant;
      for (int k = 1; k < cant; k++) {
        fill(noise(det+i*dcant*2+j+k)*256);
        poly(i*tt, j*tt, tt-dt*k, 4, PI/2);
      }
    }
  }
  popMatrix();
}
