import org.processing.wiki.triangulate.*;
import toxi.math.noise.SimplexNoise;

// añadir textura serpiente
// añadir gradient de fondo para dar luz
// saltear alguno de los petalos, buscar mariposas
// deformar la malla

int seed = int(random(999999));

float nwidth =  960; 
float nheight = 960;
float swidth = 960; 
float sheight = 960;
float scale = 1;

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

  background(getColor());

  hint(DISABLE_DEPTH_TEST);
  stroke(255, 20);
  for (int j = 0; j <= height; j+=20) {
    for (int i = 0; i <= width; i+=20) {
      noFill();
      rect(i, j, 20, 20); 
      fill(rcol());
      rect(i+9, j+9, 2, 2);
    }
  }

  hint(DISABLE_DEPTH_TEST);
  noStroke();
  for (int i = 0; i < 70; i++) {
    float xx = random(width);
    float yy = random(height);
    float ss = random(120, 240)*random(0.5, 2);

    xx -= xx%20;
    yy -= yy%20;

    fill(rcol(), random(20, 180));
    ellipse(xx, yy, ss, ss);
    fill(rcol());
    ellipse(xx, yy, ss*0.2, ss*0.2);
  }

  noStroke();
  for (int i = 0; i < 220; i++) {
    float xx = random(width);
    float yy = random(height);

    float ss = 20;

    xx -= xx%ss;
    yy -= yy%ss;

    arc2(xx, yy, ss-2, random(ss-2, ss*2), 0, TAU, rcol(), random(0, 50), 0);
    fill(rcol());
    ellipse(xx, yy, ss-2, ss-2);
    fill(rcol());
    ellipse(xx, yy, ss*0.4, ss*0.4);
  }


  hint(ENABLE_DEPTH_TEST);


  for (int i = 0; i < 40; i++) {
    float xx = random(width);
    float yy = random(height);

    xx -= xx%40;
    yy -= yy%40;

    int cc = int(random(6, random(12, 42)));
    float da = TAU/cc;
    float ss = random(20, random(60, 180)*random(0.1, 1));
    pushMatrix();
    translate(xx, yy, -120);
    arc2(xx, yy, ss-2, random(ss*1.5, ss*3), 0, TAU, rcol(), random(80, 150), 0);
    popMatrix();

    pushMatrix();
    translate(xx, yy);
    rotateZ(random(TAU));
    float maxRot = random(0.1, 0.3);
    rotateX(HALF_PI*random(-maxRot, maxRot));
    rotateY(HALF_PI*random(-maxRot, maxRot));
    int col = rcol();
    int ant = rcol();
    for (int k = 0; k < 5; k++) {
      float s2 = k*ss;
      for (int j = 0; j < cc; j++) {
        ant = col;
        while (ant == col) col = rcol();
        fill(col);
        rotateZ(da);
        pushMatrix();
        rotateX(0.1);
        rotateZ(HALF_PI);
        ellipse(ss*0.6*s2, 0, ss*s2, ss*0.6*s2);
        popMatrix();
      }
    }
    popMatrix();
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
int colors[] = {#EF3621, #295166, #C9E81E, #0F190C, #F5FFFF};
//int colors[] = {#333A95, #FFDC15, #FC9CE6, #31F5C2, #1E9BF3};
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
