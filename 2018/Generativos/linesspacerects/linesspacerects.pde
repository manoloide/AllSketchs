import org.processing.wiki.triangulate.*;
import toxi.math.noise.SimplexNoise;

int seed = int(random(999999));

void setup() {
  size(960, 960, P3D);
  smooth(8);
  pixelDensity(2);
  generate();
}

void draw() {
}

void keyPressed() {
  if (key == 's') saveImage();
  else {
    seed = int(random(999999));
    generate();
  }
}

void generate() {

  randomSeed(seed);
  noiseSeed(seed);

  background(0);//rcol());

  float time = millis()*0.001;

  float size = 30;

  rotateX(time*random(-0.1, 0.1));
  rotateY(time*random(-0.1, 0.1));
  rotateZ(time*random(-0.1, 0.1));

  translate(width/2, height/2, 0);

  rectMode(CENTER);
  float ic = random(1);
  float dc = random(0.003);
  for (int c = 0; c < 4; c++) {
    for (int i = 0; i < 20; i++) {
      pushMatrix();
      for (int j = 0; j < 10; j++) {
        float des = size*pow(int(random(1, 5)), 2);
        float dx = int(random(2))*2-1;
        float dy = int(random(2))*2-1;
        float dz = int(random(2))*2-1;
        if (random(1) < 0.3333) {
          dy =  dz = 0;
        } else {
          if (random(1) < 0.5) {
            dx = dz = 0;
          } else {
            dx = dy = 0;
          }
        }

        rotateX(dx*HALF_PI);
        rotateY(dy*HALF_PI);
        rotateZ(dz*HALF_PI);

        ic += dc;

        noStroke();
        noFill();
        float rot = random(0.8);
        for (float k = size*0.5; k < des-size*0.5; k+=4) {
          stroke(getColor(ic+dc*k), 200);
          pushMatrix();
          translate(k, 0, 0);
          //rotateY(time*random(-0.1, 0.1));
          rotateY(HALF_PI);
          rotateZ(j*rot);
          rect(0, 0, size*0.1, size*0.1);
          popMatrix();
        }
        stroke(rcol(), 140);
        line(0, 0, 0, des, 0, 0);
        translate(des, 0, 0);
      }
      popMatrix();
    }
  }
}

float desAng = random(1000);
float detAng = random(0.01);
float desDes = random(1000);
float detDes = random(0.01);

PVector desform(float x, float y) {
  float ang = (float) SimplexNoise.noise(desAng+x*detAng, desAng+y*detAng)*TAU*8;
  float des = (float) SimplexNoise.noise(desDes+x*detDes, desDes+y*detDes)*120; 
  return new PVector(x+cos(ang)*des, y+sin(ang)*des);
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

//int colors[] = {#FFFFFF, #FFFFFF, #FFCB43, #FFB9D5, #1DB5E3, #006591, #142B4B};
//int colors[] = {#FFFFFF, #FFC930, #F58B3F, #395942, #212129};
//int colors[] = {#F8F8F9, #FE3B00, #7233A6, #0601FE, #000000};
//int colors[] = {#FFFFFF, #F7C6D9, #F4CA75, #4D67FF, #657F66};
//int colors[] = {#FFFFFF, #FEE71F, #FF7991, #26C084, #0E0E0E};
int colors[] = {#F6C9CC, #119489, #7AC3AB, #F47AD4, #6AC8EC, #5BD5D4, #1E4C5B, #CF350A, #F5A71C};
//int colors[] = {#3102F7, #F6C9CC, #F47AD4, #CF350A, #F5A71C};
//int colors[] = {#FFF4D4, #FD8BA4, #FF5500, #018CC7, #000000, #000000, #000000, #000000, #000000, #000000, #000000, #000000};
//int colors[] = {#FCF0E3, #F3C6BD, #F36B7F, #F8CF61, #3040C4};
//int colors[] = {#FFFFFF, #FFFFFF, #000000, #000000, #000000, #000000, #000000, #000000, #FFFFFF, #000000};
int rcol() {
  return colors[int(random(colors.length))];
}
int getColor() {
  return getColor(random(colors.length));
}
int getColor(float v) {
  v = abs(v)%1;
  int ind1 = int(v*colors.length);
  int ind2 = (int((v)*colors.length)+1)%colors.length;
  int c1 = colors[ind1]; 
  int c2 = colors[ind2]; 
  return lerpColor(c1, c2, (v*colors.length)%1);
}
