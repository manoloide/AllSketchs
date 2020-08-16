import org.processing.wiki.triangulate.*;
import toxi.math.noise.SimplexNoise;

int seed = int(random(999999));

float nwidth =  960; 
float nheight = 960;
float swidth = 960; 
float sheight = 960;
float scale = 1;

boolean export = false;

void settings() {
  scale = nwidth/swidth;
  size(int(swidth*scale), int(sheight*scale), P2D);
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

  background(#EF002C);
  
  int ccc = int(random(12, 69));
  float sss = width*1./ccc;
  
  noStroke();
  for(int j = 0; j < ccc; j++){
     for(int i = 0; i < ccc; i++){
       fill(255, random(255));
       rect(i*sss+1, j*sss+1, sss-2, sss-2, 2);
     }
  }

  strokeWeight(1);
  for (int i = 0; i < 80; i++) {
    float s = width*random(0.2)*random(0.2, 1)*random(1)*3;
    float x = random(s, width-s);
    float y = random(s, height-s);
    stroke(0, 140);

    float ss = s;
    float as = s;
    noStroke();
    while (ss > s*0.1) {
      as = ss;
      ss *= random(0.4, 0.9);

      int rnd = int(random(3));
      
      stroke(0);
      if(random(1) < 0.5) noStroke();

      if (rnd == 0) {
        fill(rcol());
        ellipse(x, y, as, as);
      } 
      if (rnd == 1) {
        fill(rcol(), random(250));
        int sub = int(random(3, 17));
        float ang = random(TAU);
        float bb = random(0.06);
        float amp = TAU;
        if (random(1) < 0.5) {
          amp = random(TAU);
        }
        float da = amp/sub;
        for (int j = 0; j < sub; j++) {
          float a1 = ang+(j+0+bb)*da;
          float a2 = ang+(j+1-bb)*da;
          arc(x, y, as, as, a1, a2);
        }
      } else {
        fill(rcol(), random(250));
        int sub = int(random(3, 17));
        float ang = random(TAU);
        float bb = random(0.35, 0.46);
        float amp = TAU;
        if (random(1) < 0.5) {
          amp = random(TAU);
        }
        float da = amp/sub;
        for (int j = 0; j < sub; j++) {
          float a1 = ang+(j+0+bb)*da;
          float a2 = ang+(j+1-bb)*da;
          arc(x, y, as, as, a1, a2);
        }
      }
    }


    fill(rcol());
    ellipse(x, y, s*0.05, s*0.05);
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+"-"+seed+".png");
}

//int colors[] = {#E1E8E0, #F5CE4B, #FC5801, #025DC4, #02201A, #489B4D};
//int colors[] = {#F0C7C0, #F65A5C, #3080E9, #50E2C6, #F7D3C3, #F41B9C};
int colors[] = {#E9C500, #DB92AE, #E44509, #42A1C1, #37377A, #D87291, #D65269};
//int colors[] = {#FFF2E1, #EBDDD0, #F1C98E, #E0B183, #C2B588, #472F18, #0F080F};
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
