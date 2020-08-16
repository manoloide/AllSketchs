import org.processing.wiki.triangulate.*;
import toxi.math.noise.SimplexNoise;

int seed = int(random(999999));

float nwidth =  960; 
float nheight = 960;
float swidth = 960; 
float sheight = 960;
float scale = 1;

boolean export = false;

PShader noise;

void settings() {
  scale = nwidth/swidth;
  size(int(swidth*scale), int(sheight*scale), P2D);
  smooth(8);
  pixelDensity(2);
}

void setup() {

  noise = loadShader("noiseTextureFrag.glsl");

  generate();

  if (export) {
    saveImage();
    exit();
  }
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

class Rect {
  float x, y, w, h;
  Rect(float x, float y, float w, float h) {
    this.x = x;
    this.y = y; 
    this.w = w; 
    this.h = h;
  }
}

void generate() { 

  randomSeed(seed);
  noiseSeed(seed);

  background(255);

  rectMode(CENTER);

  shader(noise);

  noStroke();
  for (int j = 0; j < height; j+= 20) {
    for (int i = 0; i < width; i+=20) {
      noise.set("displace", random(100));
      pushMatrix();
      translate(i, j);
      //rotate(random(TAU));
      if (random(1) < 0.06) {
        fill(rcol(), random(200)*random(1));
        noise.set("displace", random(100));
        rect(0, 0, 180, 180);
        noise.set("displace", random(100));
        gradient(0, 0, 180, 180, rcol(), random(40), rcol(), random(40));

        fill(rcol(), random(200)*random(1));
        rect(0, 0, 20, 20);
      }
      if (random(1) < 0.2) {
        fill(rcol());
        float ss = (random(1) < 0.5)? 10 : 5;
        rect(0, 0, ss, ss);
      }
      fill(0, 12);
      rect(0, 0, 4, 4);
      rect(0, 0, 2, 2);
      popMatrix();
    }
  }

  for (int i = 0; i < 1000; i++) {
    float x = random(width);
    float y = random(height);
    float w = 10*int(random(1, 9));
    float h = 10*int(random(1, 9));

    x -= x%20;
    y -= y%20;
    stroke(rcol());
    if (random(1) < 0.5) {
      line(x-w, y, x+w, y);
    } else {
      line(x, y-h, x, y+h);
    }
  }

  float det = random(0.01, 0.02)*0.1;
  float des = random(1000);


  for (int i = 0; i < 40; i++) {
    float x = random(width);
    float y = random(height);
    float s = width*random(0.01, 0.1)*0.3;

    s = noise(des+x*det, des+y*det)*width*0.02;

    if (random(1) < 0.8) s *= 6;

    x -= x%20; 
    y -= y%20;

    noStroke();

    int cc = int(random(-5, 3));
    for (int j = 0; j < cc; j++) {
      float a1 = random(TAU);
      float a2 = a1+random(PI*0.2);

      fill(rcol(), 200);
      arc(x, y, s*5, s*5, a1, a2); 
      arc2(x, y, s, s*5, a1, a2, rcol(), 250, 0);
    }

    arc2(x, y, s, s*1.2, 0, TAU, color(0), 10, 0);
    fill(rcol());
    ellipse(x, y, s, s);
    fill(rcol());
    ellipse(x, y, s*0.5, s*0.5);
    fill(255);
    ellipse(x, y, s*0.1, s*0.1);
  }
}

void gradient(float x, float y, float w, float h, int c1, float a1, int c2, float a2) {
  float mw = w*0.5; 
  float mh = h*0.5;
  beginShape();
  fill(c1, a1);
  vertex(x-mw, y-mh);
  vertex(x+mw, y-mh);
  fill(c2, a2);
  vertex(x+mw, y+mh);
  vertex(x-mw, y+mh);
  endShape(CLOSE);
}

void arc2(float x, float y, float s1, float s2, float a1, float a2, int col, float alp1, float alp2) {
  float r1 = s1*0.5;
  float r2 = s2*0.5;
  int cc = (int) max(2, PI*pow(max(s1, s2)*0.1, 2));

  beginShape(QUADS);
  for (int i = 0; i < cc; i++) {
    float ang1 = map(i+0, 0, cc, a1, a2); 
    float ang2 = map(i+1, 0, cc, a1, a2);
    fill(col, alp1);
    vertex(x+cos(ang1)*r1, y+sin(ang1)*r1);
    vertex(x+cos(ang2)*r1, y+sin(ang2)*r1);
    fill(col, alp2);
    vertex(x+cos(ang2)*r2, y+sin(ang2)*r2);
    vertex(x+cos(ang1)*r2, y+sin(ang1)*r2);
  }
  endShape();
}


void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+"-"+seed+".png");
}

//int colors[] = {#E1E8E0, #F5CE4B, #FC5801, #025DC4, #02201A, #489B4D};
//int colors[] = {#F0C7C0, #F65A5C, #3080E9, #50E2C6, #F7D3C3, #F41B9C};
int colors[] = {#333A95, #FFDC15, #FC9CE6, #31F5C2, #1E9BF3};
//int colors[] = {#333A95, #F6C806, #F789CA, #1E9BF3};
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
  return lerpColor(c1, c2, pow(v%1, 2));
}
