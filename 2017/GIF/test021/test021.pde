int fps = 30;
float seconds = 6;
boolean export = true;

int frames = int(fps*seconds);
float time = 0;

void setup() {
  size(640, 640, P3D);
  smooth(8);
  frameRate(fps);
}

void draw() {
  if (export) time = map(frameCount-1, 0, frames, 0, 1);
  else time = map((millis()/1000.)%seconds, 0, seconds, 0, 1);

  render();

  if (export) {
    if (time >= 1) exit();
    else saveFrame("export/f####.gif");
  }
}

void keyPressed() {
  seed = int(random(9999999));
  println(seed);
}

int seed = 8056208; 
void render() {

  randomSeed(seed);
  noiseSeed(seed);

  background(#191321);
  translate(width/2, height/1.7);
  float cv = 4; 
  float ca = 50;
  float ct = abs(time*2-1)*0.5;
  translate((noise(ct*cv)*2-1)*ca, (noise(100.2+ct*cv)*2-1)*ca, (noise(4033+ct*cv)*2-1)*ca); 
  scale(1.2-pow(sin(time*PI), 4)*0.4);
  rotateX(HALF_PI*0.55);
  rotateZ(time*HALF_PI);


  int cc = 500; 

  float phi = (sqrt(5)+1.)/2-1;
  float ga = phi*TWO_PI;
  float r = 150;

  strokeWeight(1.4);
  stroke(#21FFB7, 100);
  grid(8000, 8000, 160);
  fill(#21FFB7);
  gridRect(8000, 8000, 40, 4);

  if (time < 0.2 || time >= 0.9) {
    float tt = 0; 
    if (time < 0.2) tt = map(time, 0.1, 0.2, 1, 0);
    if (time >= 0.9) tt = map(time, 0.9, 1, 0, 1);
    tt = constrain(tt, 0, 1);
    tt = Easing.CubicOut(tt, 0, 1, 1);

    noFill();
    for (int i = 1; i <= 7; i++) {
      strokeWeight(0.5+(i%2)*2);
      float alp = tt*180;
      stroke(#21FFB7, alp);
      float ss = 50*(i-0.5)*tt;
      int sub = 16;//int(pow(2, i));
      float da = TWO_PI/sub;
      for (int j = 0; j < sub; j++) {
        arc(0, 0, ss, ss, (j-0.25)*da, (j+0.25)*da);
      }
    }
  }

  if (time >= 0.2 && time <= 0.9) {
    float tt = 0; 
    if (time < 0.5) tt = map(time, 0.2, 0.5, 0, 1);
    if (time >= 0.5) tt = map(time, 0.5, 0.9, 1, 0);
    tt = constrain(tt, 0, 1);
    stroke(#21FFB7, pow(tt*10, 2)*255);
    strokeWeight(2);
    for (float i = 1; i <= cc; i++) {
      float lon = ga*i;
      lon %= TWO_PI;
      if (lon > PI)  lon -= TWO_PI;
      float lat = asin(-1+(2.*i/float(cc)));

      float x = cos(lat)*cos(lon)*r;
      float y = cos(lat)*sin(lon)*r;
      float z = sin(lat)*r+r;

      float ttt = tt*2+random(0.02);
      float xx = x*Easing.ElasticOut(ttt, 0, 1, 1, 1, 20);
      float yy = y*Easing.ElasticOut(ttt, 0, 1, 1, 1, 20);
      float zz = z*Easing.ElasticOut(ttt, 0, 1, 1, 1, 20);

      point(xx, yy, zz);
    }



    for (int j = 0; j < 4; j++) {
      pushMatrix();
      translate(0, 0, r);
      rotateX(random(TWO_PI)+time*random(-5, 5));
      rotateY(random(TWO_PI)+time*random(-5, 5));
      rotateZ(random(TWO_PI)+time*random(-5, 5));
      int sub = int(random(30, 50)*2); 
      float rr = r*1.1;
      float da = TWO_PI/sub;
      float h = random(1, 2);
      float amp = map(tt, 0, 1, 0, 2);
      for (int i = 0; i < sub; i++) {
        strokeWeight(0.5+(i%2));
        float x = cos(da*i)*rr;
        float y = sin(da*i)*rr;
        float hh = h+h*(i%2);
        if (amp > i*1./sub) line(x, y, -hh, x, y, hh);
      }
      popMatrix();
    }
  }
}  

void grid(float w, float h, int c) {
  float dx = w*1./c; 
  float dy = w*1./c; 
  for (int j = 0; j <= c; j++) {
    for (int i = 0; i <= c; i++) {
      float xx = dx*i-w*0.5;
      float yy = dy*j-h*0.5;
      point(xx, yy, 0);
    }
  }
}

void gridRect(float w, float h, int c, float s) {
  float dx = w*1./c; 
  float dy = w*1./c; 
  rectMode(CENTER);
  for (int j = 0; j <= c; j++) {
    for (int i = 0; i <= c; i++) {
      float xx = dx*i-w*0.5;
      float yy = dy*j-h*0.5;
      rect(xx, yy, s, s);
    }
  }
}