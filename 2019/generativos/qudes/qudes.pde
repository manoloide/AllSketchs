import org.processing.wiki.triangulate.*;
import toxi.math.noise.SimplexNoise;


// add more contraste subdivision
// fixed angles the lines

int seed = int(random(999999));

float nwidth =  960; 
float nheight = 960;
float swidth = 960; 
float sheight = 960;
float scale  = 1;

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

  background(rcol());

  ArrayList<Rect> rects = new ArrayList<Rect>();
  rects.add(new Rect(10, 10, width-20, height-20));

  float det = random(0.6, 1)*0.001;
  float des = random(1000); 

  for (int i = 0; i < 10; i++) {
    Rect r = rects.get(i);
    float val = pow(noise(des+r.x*det, des+r.y*det)+random(0.1), 1.8);

    float ss = pow(r.w*0.5, 1.2);

    if (2+val*500 > ss) continue;

    float mw = r.w*0.5;
    float mh = r.h*0.5;

    rects.add(new Rect(r.x, r.y, mw, mh));
    rects.add(new Rect(r.x+mw, r.y, mw, mh));
    rects.add(new Rect(r.x+mw, r.y+mh, mw, mh));
    rects.add(new Rect(r.x, r.y+mh, mw, mh));

    rects.remove(i--);
  }

  /* old subdivision
   int sub = 120;
   for (int i = 0; i < sub; i++) {
   int ind = int(random(rects.size()));
   if (random(1) < 0.6) ind = i;
   ind = i;
   Rect r = rects.get(i);
   
   float mw = r.w*0.5;
   float mh = r.h*0.5;
   
   rects.add(new Rect(r.x, r.y, mw, mh));
   rects.add(new Rect(r.x+mw, r.y, mw, mh));
   rects.add(new Rect(r.x+mw, r.y+mh, mw, mh));
   rects.add(new Rect(r.x, r.y+mh, mw, mh));
   
   //if (random(1) < 0.9)  
   rects.remove(ind);
   }
   */

  float detAngle = random(0.001);
  float desAngle = random(10000);


  float detAmp = random(0.001);
  float desAmp = random(10000);

  int view = rects.size(); //int(rects.size()*random(0.2, 1));
  for (int i = 0; i < view; i++) {
    Rect r = rects.get(i);
    noStroke();
    if (random(1) < 0.8) {
      fill(0, 10);
      rect(r.x+2, r.y+2, r.w-2, r.h-2);
      fill(rcol());
      rect(r.x+1, r.y+1, r.w-2, r.h-2);
      beginShape(); 
      fill(0, 0);
      vertex(r.x, r.y);
      vertex(r.x+r.w, r.y);
      fill(0, 4);
      vertex(r.x+r.w, r.y+r.h);
      vertex(r.x, r.y+r.h);
      endShape();

      float sep = random(20, 40);
      int cc = int(min(r.w, r.h)/sep);
      fill(rcol());

      if (random(1) < 0.2) {
        float s1 = sep;
        float s2 = sep*random(0.6);
        if (random(1) < 0.5) s2 = sep;
        if (random(1) < 0.5) s1 = 0;
        if (random(1) < 0.5) s2 = 0;
        float prob = random(0.2, 0.8);
        noStroke();
        float dd = 0;//(r.w-cc*s1)+0.5;
        rectMode(CENTER);
        for (int k = 1; k < cc-1; k++) {
          for (int j = 1; j < cc-1; j++) {
            float sss = (random(1) < prob)? s1 : s2;
            //stroke(0);
            rect(r.x+(j+0.5)*sep+dd, r.y+(k+0.5)*sep+dd, sss, sss);
          }
        }
        rectMode(CORNER);
      }
    }

    if (random(1) < 0.4) {
      fill(rcol());
      ellipse(r.x+r.w*0.5, r.y+r.h*0.5, r.w*0.8, r.h*0.8);
    }
    if (random(1) < 0.4) {
      fill(rcol());
      ellipse(r.x+r.w*0.5, r.y+r.h*0.5, r.w*0.2, r.h*0.2);
    }


    if (random(1) < 0.7) {
      PVector p1 = new PVector(lerp(r.x, r.x+r.w, random(0.1, 0.9)), r.y);
      PVector p2 = new PVector(r.x+r.w, lerp(r.y, r.y+r.h, random(0.1, 0.9)));
      PVector p3 = new PVector(lerp(r.x, r.x+r.w, random(0.1, 0.9)), r.y+r.h);
      PVector p4 = new PVector(r.x, lerp(r.y, r.y+r.h, random(0.1, 0.9)));

      float dx = random(1.8);
      float dy = random(1.8);
      fill(0, random(14));
      beginShape();
      vertex(p1.x+dx, p1.y+dy);
      vertex(p2.x+dx, p2.y+dy);
      vertex(p3.x+dx, p3.y+dy);
      vertex(p4.x+dx, p4.y+dy);
      endShape(CLOSE);

      int c1 = rcol();
      int c2 = lerpColor(c1, rcol(), random(0.05));
      fill(c1);
      beginShape();
      vertex(p1.x, p1.y);
      vertex(p2.x, p2.y);
      fill(c2);
      vertex(p3.x, p3.y);
      vertex(p4.x, p4.y);
      endShape(CLOSE);
    }

    if (random(1) < 0.8) {
      float dx = random(1.8);
      float dy = random(1.8);
      fill(0, random(14));
      ellipse(r.x+r.w*0.5+dx, r.y+r.h*0.5+dy, r.w*0.01, r.h*0.01);
      fill(rcol());
      //ellipse(r.x+r.w*0.5, r.y+r.h*0.5, r.w*0.01, r.h*0.01);
    }

    rectMode(CENTER);
    float angle = noise(desAngle+r.x*detAngle, desAngle+r.y*detAngle)*TAU*4;

    float modAngle = angle%(HALF_PI*0.5);


    float va = pow(map(modAngle, 0, HALF_PI*0.5, -1, 1), 30);

    angle -= modAngle*va;

    float sca = noise(desAmp+r.x*detAmp, desAmp+r.y*detAmp)*10-4;
    sca = pow(constrain(sca, 0, 1), random(0.5));
    pushMatrix();
    translate(r.x+r.w*0.5, r.y+r.h*0.5);
    rotate(angle); 
    fill(rcol());
    rect(0, 0, r.w*0.6*sca, r.h*0.06*sca);
    popMatrix();
    rectMode(CORNER);
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2); 
  saveFrame(timestamp+"-"+seed+".png");
}

//https://coolors.co/ed78dd-1c0a26-0029c1-ffea75-eadcd3
//int colors[] = {#ED61DA, #200C2B, #0029BF, #FFE760, #DBD1CB};
int colors[] = {#FEFDFD, #FBAEB9, #FC818F, #A8BAFC, #6398FE, #2656D8, #021D86, #1F1D3E};
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
  return lerpColor(c1, c2, pow(v%1, 0.5));
}
