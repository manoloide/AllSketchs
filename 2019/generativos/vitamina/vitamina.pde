//patas mosca
//sombras angulo


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

  background(lerpColor(color(#02343F), color(0), random(0.2, 0.4)));//getColor());

  for (int j = 0; j <= height; j+=10) {
    for (int i = 0; i <= width; i+=10) {
      stroke(255, random(10, 90));
      point(i, j);
    }
  }

  float det = random(0.003, 0.005);
  float des = random(1000);
  float detMask = random(0.003, 0.005)*0.6;
  float desMask = random(1000);


  noiseDetail(4);

  blendMode(SUBTRACT);//ADD);
  float umb = 0.4;
  for (int j = 0; j < 12000; j++) {
    double x = random(width);
    double y = random(height);
    noFill();
    int col = rcol();
    beginShape();
    for (int i = 0; i < 500; i++) {
      double noi = SimplexNoise.noise(desMask+x*detMask, desMask+y*detMask);
      if (noi > umb) break; 

      float ang = (float)SimplexNoise.noise(des+x*det, des+y*det)*TAU*50;
      x += cos(ang)*5;
      y += sin(ang)*5;

      stroke(col, pow(map((float)noi, 0, umb, 1, 0), 0.7)*3);
      vertex((float)x, (float)y);
    }
    endShape();
  }
  blendMode(NORMAL);


  detMask = random(0.003, 0.005)*0.1;
  desMask = random(1000);
  blendMode(ADD);//ADD);
  umb = 0.9;//random(0.1, 0.2);
  for (int j = 0; j < 12; j++) {
    double x = random(width);
    double y = random(height);
    noFill();
    int col = rcol();
    float lar = random(1, 900*random(1));
    float alp = random(90, 240)*random(0.05, 0.16);
    
    float gor = random(0.2, 0.5);
    
    float ic = random(colors.length);
    float dc = random(0.06)*random(1);

    //beginShape();
    noFill();
    for (int i = 0; i < lar*2; i++) {
      double noi = noise(desMask+(float)x*detMask, desMask+(float)y*detMask);
      if (noi > umb) break; 

      float ang = (float)SimplexNoise.noise(des+x*det*0.2, des+y*det*0.2)*TAU*2;
      x += cos(ang)*0.5;
      y += sin(ang)*0.5;

      float v = pow(map(i, 0, lar*2, 0, 1), 0.5);
      float ss = cos(v*PI*1.5)*lar*gor*(0.2+v*0.8);
      float ampW = 0.2+v*0.6;
      col = getColor(ic+i*dc);
      stroke(col, pow(map((float)noi, 0, umb, 1, 0), 0.1)*alp);
      //vertex((float)x, (float)y);
      pushMatrix();
      translate((float) x, (float) y);
      rotate(ang);
      ellipse(0, 0, ss*ampW, ss);
      popMatrix();
    }
    endShape();
  }
  blendMode(NORMAL);


  noiseDetail(2);
  detMask = random(0.003, 0.005)*1.8;
  desMask = random(1000);
  blendMode(ADD);//ADD);
  umb = random(0.1, 0.2);
  for (int j = 0; j < 80000; j++) {
    double x = random(width);
    double y = random(height);
    noFill();
    int col = rcol();
    beginShape();
    float lar = random(1, 7*random(1));
    float alp = random(90);
    for (int i = 0; i < lar; i++) {
      double noi = noise(desMask+(float)x*detMask, desMask+(float)y*detMask);
      if (noi > umb) break; 

      float ang = (float)SimplexNoise.noise(des+x*det*0.2, des+y*det*0.2)*TAU*2;
      x += cos(ang)*1;
      y += sin(ang)*1;

      stroke(col, pow(map((float)noi, 0, umb, 1, 0), 0.1)*alp);
      vertex((float)x, (float)y);
    }
    endShape();
  }
  blendMode(NORMAL);




  ArrayList points = new ArrayList();
  for (int i = 0; i < 14; i++) {
    float x = width*random(-0.2, 1.2);
    float y = height*random(-0.2, 1.2);
    x -= x%10;
    y -= y%10;
    float s = width*random(0.08, 0.2)*0.8;
    noStroke();
    fill(0, 20);
    ellipse(x+s*0.1, y+s*0.1, s, s); 
    fill(getColor(), random(230));
    ellipse(x, y, s, s); 
    float ss = s*random(0.6);
    fill(getColor(), random(230));
    ellipse(x, y, ss, ss); 
    fill(0);
    //stroke(0);
    ellipse(x, y, s*0.02, s*0.02); 
    points.add(new PVector(x, y, s));

    int cc = int(random(80));
    for (int j = 0; j < cc; j++) {
      float ang = random(TAU);
      float mw = s*0.5;
      float ww = mw*random(0.2);
      pushMatrix();
      translate(x, y);
      rotate(ang);
      translate(mw+ww*0.5, 0);
      fill(rcol());
      rect(0, 0, ww, ww*0.2);
      popMatrix();
    }
  }


  ArrayList triangles = Triangulate.triangulate(points);

  blendMode(ADD);
  stroke(0, 4);
  strokeWeight(0.8);
  beginShape(TRIANGLES);
  for (int i = 0; i < triangles.size(); i++) {
    Triangle t = (Triangle)triangles.get(i);
    stroke(rcol(), random(250)*0.4);
    fill(rcol(), random(12));
    vertex(t.p1.x, t.p1.y);
    //fill(rcol(), 30);
    vertex(t.p2.x, t.p2.y);
    //fill(rcol(), 30);
    vertex(t.p3.x, t.p3.y);
  }
  endShape();
  strokeWeight(1);
  blendMode(NORMAL);

  ArrayList points2 = new ArrayList(points);

  points.clear();
  fill(255);
  for (int i = 0; i < triangles.size(); i++) {
    Triangle t = (Triangle)triangles.get(i);
    PVector cen = (t.p1.copy().add(t.p2).add(t.p3)).div(3);
    points.add(cen);
  }

  triangles = Triangulate.triangulate(points);


  stroke(0, 8);
  noFill();
  //blendMode(ADD);
  beginShape(TRIANGLES);
  for (int i = 0; i < triangles.size(); i++) {
    Triangle t = (Triangle)triangles.get(i);
    fill(255, random(12));
    vertex(t.p1.x, t.p1.y);
    vertex(t.p2.x, t.p2.y);
    vertex(t.p3.x, t.p3.y);
  }
  endShape();
  //blendMode(NORMAL);


  beginShape(TRIANGLES);
  for (int i = 0; i < triangles.size(); i++) {
    Triangle t = (Triangle)triangles.get(i);
    fill(0, random(random(20, 120)));
    vertex(t.p1.x, t.p1.y);
    vertex(t.p2.x, t.p2.y);
    vertex(t.p3.x, t.p3.y);
  }
  endShape();


  stroke(0);
  noStroke();
  fill(0, 20);
  for (int i = 0; i < triangles.size(); i++) {
    Triangle t = (Triangle)triangles.get(i);
    PVector cen = (t.p1.copy().add(t.p2).add(t.p3)).div(3);
    float ss = random(3, 6);
    noStroke();
    fill(0, 20);
    ellipse(cen.x+2, cen.y+2, ss, ss);
    fill(rcol());
    ellipse(cen.x, cen.y, ss, ss);
    fill(rcol());
    ellipse(cen.x, cen.y, ss*0.4, ss*0.4);
    noFill();
    stroke(rcol());
    float sss = ss*random(25);
    if (random(1) < 0.2) ellipse(cen.x, cen.y, sss, sss);
    points.add(cen);
  }

  noStroke();
  for (int i = 0; i < points2.size(); i++) {
    PVector p = (PVector)points2.get(i);
    fill(0);
    //stroke(0);
    ellipse(p.x, p.y, p.z*0.05, p.z*0.05);
  }







  ArrayList<PVector> barcos = new ArrayList<PVector>();

  float det1 = random(0.008, 0.01);
  float des1 = random(1000);
  float det2 = random(0.008, 0.01);
  float des2 = random(1000);

  for (int i = 0; i < 40000; i++) {
    float x = random(width);
    float y = random(height);
    float s = width*random(0.05)*random(0.96)*random(0.4, 1)*16;
    boolean add = true;
    for (int j = 0; j < barcos.size(); j++) {
      PVector o = barcos.get(j);
      if (dist(x, y, o.x, o.y) < (s+o.z)*0.5) {
        add = false;
        break;
      }
    }
    //blendMode(DARKEST);
    rectMode(CENTER);
    if (add) {
      barcos.add(new PVector(x, y, s));

      if (random(1) < 0.6) continue;
      if (noise(des1+x*det1, des1+y*det1) < 0.4) {
        pushMatrix();
        translate(x, y);
        rotate(noise(des2+x*det2, des2+y*det2)*TAU*2);

        noStroke();
        beginShape();
        fill(255, random(10, 60));
        vertex(-s*0.15, -s*0.4);
        vertex(+s*0.15, -s*0.4);
        fill(255, 0);
        float amp = random(0.8, 2.5);
        float amp2 = random(0.42, 0.5);
        vertex(+s*amp2, +s*amp);
        vertex(-s*amp2, +s*amp);
        endShape(CLOSE);

        stroke(0, 40);
        fill(rcol());
        rect(0, 0, s*0.3, s*0.8);

        ArrayList<Rect> rects = new ArrayList<Rect>();
        rects.add(new Rect(0, 0, s*0.29, s*0.79));

        int sub = int(random(5, random(10, 40)));
        for (int k = 0; k < sub; k++) {
          int ind = int(random(rects.size()*random(1)));
          Rect r = rects.get(ind);
          rects.add(new Rect(r.x-r.w*0.25, r.y-r.h*0.25, r.w*0.5, r.h*0.5));
          rects.add(new Rect(r.x+r.w*0.25, r.y-r.h*0.25, r.w*0.5, r.h*0.5));
          rects.add(new Rect(r.x+r.w*0.25, r.y+r.h*0.25, r.w*0.5, r.h*0.5));
          rects.add(new Rect(r.x-r.w*0.25, r.y+r.h*0.25, r.w*0.5, r.h*0.5));
          rects.remove(ind);
        }

        for (int k = 0; k < rects.size(); k++) {
          Rect r = rects.get(k);
          fill(rcol());
          rect(r.x, r.y, r.w, r.h);
        }


        arc(0, -s*0.4, s*0.3, s*0.3, PI, TAU);
        popMatrix();
      } else {
        if (random(1) < 0.5) {
          ellipse(x, y, s*0.5, s*0.5);
          fill(getColor());
          ellipse(x, y, s*0.05, s*0.05);
        }
      }
    }
    //blendMode(NORMAL);
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+"-"+seed+".png");
}

int colors[] = {#1AB8B2, #D92335, #F79040, #04328D, #DFD6DA, #CB6D56};
//int colors[] = {#F0C7C0, #F65A5C, #3080E9, #50E2C6, #F7D3C3, #F41B9C};
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
  return lerpColor(c1, c2, v%1);
}
