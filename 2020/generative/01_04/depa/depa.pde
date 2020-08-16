import org.processing.wiki.triangulate.*;
import toxi.math.noise.SimplexNoise;

int seed = int(random(999999));

float nwidth =  960;
float nheight = 960;
float swidth = 960; 
float sheight = 960;
float scale  = 1;

boolean export = false;

void settings() {
  scale = nwidth/swidth;
  size(int(swidth*scale), int(sheight*scale), P3D);
  smooth(8);
  pixelDensity(2);
}

void setup() {

  generate();
  if (export) {
    saveImage();
    exit();
  }
}

void draw() {
  //generate();
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
  background(255);

  int cw = 120*2; 
  int ch = 60*2;

  int values[][] = new int[cw][ch];

  for (int j = 0; j < ch; j++) {
    for (int i = 0; i < cw; i++) {
      values[i][j] = 0;
    }
  }

  for (int k = 0; k < 100; k++) {
    int ww = int(random(12, 40));
    int hh = int(random(12, 40));
    int xx = int(random(0, cw-ww-1));
    int yy = int(random(0, ch-hh-1));
    int val = int(random(50));
    for (int j = 0; j < hh; j++) {
      for (int i = 0; i < ww; i++) {
        values[xx+i][yy+j] = val;
      }
    }
  }

  float ww = width*(2./cw);
  float hh = height*(2./ch);

  float bb = min(ww, hh)*0.1;

  lights();


  float fov = PI/random(2, 3);
  float cameraZ = (height/2.0) / tan(fov/2.0);
  perspective(fov, float(width)/float(height), 
    cameraZ/10.0, cameraZ*10.0);

  float maxRot = 0.5;

  translate(width*0.5, height*0.5, 0);

  rotateX(random(-maxRot, maxRot));
  rotateY(random(-maxRot, maxRot));
  rotateZ(random(-maxRot, maxRot));

  noStroke();
  for (int j = 0; j < ch; j++) {
    for (int i = 0; i < cw; i++) {

      float x1 = (i+0-cw*0.5)*ww;
      float x2 = (i+1-cw*0.5)*ww;
      float y1 = (j+0-ch*0.5)*hh;
      float y2 = (j+1-ch*0.5)*hh;

      fill(255);
      if (i < cw-1 && j < ch-1) {
        beginShape();
        vertex(x2, y1, values[i][j]*ww);
        vertex(x2, y2, values[i][j]*ww);
        vertex(x2, y2, values[i+1][j]*ww);
        vertex(x2, y1, values[i+1][j]*ww);
        endShape();


        beginShape();
        vertex(x1, y2, values[i][j]*ww);
        vertex(x2, y2, values[i][j]*ww);
        vertex(x2, y2, values[i][j+1]*ww);
        vertex(x1, y2, values[i][j+1]*ww);
        endShape();
      }

      pushMatrix();
      translate(0, 0, ww*values[i][j]);
      fill(255);
      rect(x1, y1, ww, hh);
      translate(0, 0, 0.001);
      fill(0);
      rect(x1+bb, y1+bb*2, ww-bb*2, hh-bb*4);
      popMatrix();
    }
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2); 
  saveFrame(timestamp+"-"+seed+".png");
}

//int colors[] = {#7D7FD8, #F7AA06, #EA79B7, #FF0739, #12315E};
//int colors[] = {#354998, #D0302B, #F76684, #FCFAEF, #FDC400};
//int colors[] = {#F7F5E8, #F1D7D7, #6AA6CB, #3E4884, #E36446, #BBCAB1};
//int colors[] = {#6402F7, #F7A4EF, #F62C64, #00DACA};
//int colors[] = {#2B349E, #F57E15, #ED491C, #9B407D, #B48DC0, #E3E8EA};
int colors[] = {#F3B2DB, #518DB2, #02B59E, #DCE404, #82023B};
//int colors[] = {#FFFFFF, #000000};//, #02B59E, #DCE404, #82023B};
//int colors[] = {#9C0106, #8A8F32, #8277EE, #B58B17, #5F5542};
int rcol() {
  return colors[int(random(colors.length))];
}

int getColor() {
  return getColor(random(colors.length));
}

int getColor(float v) {
  v = abs(v); 
  v = v%(colors.length); 
  int c1 = colors[int(v%colors.length)]; 
  int c2 = colors[int((v+1)%colors.length)]; 
  return lerpColor(c1, c2, pow(v%1, 0.6));
} 
