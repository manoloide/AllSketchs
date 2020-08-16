import org.processing.wiki.triangulate.*;

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

  int back = rcol();

  background(back);
  translate(width*0.5, height*0.5);

  float des = random(1000);
  float det = random(0.001);
  for (int i = 0; i < 24000; i++) {
    float x = width*random(-0.55, 0.55);
    float y = height*random(-0.55, 0.55);

    float lar = random(20, random(100, 400))*random(1);
    beginShape();
    noFill();
    stroke(getColor());
    strokeWeight(random(0.8, 2));
    for (int j = 0; j < lar; j++) {
      float ang = noise(des+x*det, des+y*det)*TAU*2;
      vertex(x, y);
      x += cos(ang);
      y += sin(ang);
    }
    endShape();
  }

  strokeWeight(1);



  ArrayList<Rect> rects = new ArrayList<Rect>();
  rects.add(new Rect(0, 0, width, height));

  int div = int(random(18, 30));
  for (int i = 0; i < div; i++) {
    int ind = int(random(rects.size()*random(1)));
    Rect r = rects.get(ind);
    if (r.w < 4 || r.h < 4) continue;
    rects.add(new Rect(r.x-r.w*0.25, r.y-r.h*0.25, r.w*0.5, r.h*0.5));
    rects.add(new Rect(r.x+r.w*0.25, r.y-r.h*0.25, r.w*0.5, r.h*0.5));
    rects.add(new Rect(r.x+r.w*0.25, r.y+r.h*0.25, r.w*0.5, r.h*0.5));
    rects.add(new Rect(r.x-r.w*0.25, r.y+r.h*0.25, r.w*0.5, r.h*0.5));
    rects.remove(ind);
  }



  ArrayList<PVector> datas = new ArrayList<PVector>();

  int c = int(rects.size()*random(0.1, 0.3));
  for (int i = 0; i < c; i++) {
    int ind = int(random(rects.size()));
    Rect r = rects.get(ind);
    datas.add(new PVector(r.x, r.y, r.w));
    rects.remove(ind);
  }

  rectMode(CENTER);
  for (int i = 0; i < rects.size(); i++) {
    Rect r = rects.get(i);
    noStroke();
    fill(back);
    rect(r.x, r.y, r.w, r.h);
    stroke(0, 4);
    fill(getColor(), 250);
    rect(r.x, r.y, r.w-2, r.h-2);

    for (int j = 0; j < 8; j++) {
      float x = random(-0.45, 0.45)*r.w*0.8;
      float y = random(-0.45, 0.45)*r.h*0.8;
      float s = random(2.5, 3)*0.3;
      s = random(r.w)*random(0.4)*random(0.5, 1);
      noStroke();
      fill(255, random(40, 120));
      ellipse(r.x+x, r.y+y, s, s);
    }

    noStroke();
    arc2(r.x, r.y, r.w*0.0, r.h*1.2, 0, TAU, color(0), 50, 0);
  }


  for (int i = 0; i < 0; i++) {
    float x = random(-0.55, 0.55)*width;
    float y = random(-0.55, 0.55)*height;
    float s = random(2.5, 3)*0.3;
    s = random(90)*random(1);

    noStroke();
    fill(rcol());
    ellipse(x, y, s, s);
  }


  for (int i = 0; i < rects.size(); i++) {
    Rect r = rects.get(i);



    float dim = r.w*random(0.2, 0.5);

    int cc = int(random(5, random(50, 180)*random(0.5, 1)));
    for (int j = 0; j < cc; j++) {
      float a1 = random(TAU);
      float ang = random(1)*random(0.9, 1);
      float a2 = a1+random(HALF_PI)*ang;
      float amp = random(random(0.8, 0.9), 1)*0.8; 
      fill(getColor());
      stroke(0, 4);
      arc(r.x, r.y, r.w*amp*(1-ang*0.4), r.h*amp*(1-ang*0.4), a1, a2);
      noStroke();
      arc2(r.x, r.y, dim, r.w*amp*(1-ang*0.4), a1, a2, color(0), 20, 0);
    }

    fill(0, 16);
    ellipse(r.x+r.w*random(-0.2, 0.2), r.y+r.h*random(-0.2, 0.2), dim, dim);

    fill(getColor());
    ellipse(r.x, r.y, dim, dim);

    //fill(getColor());
    //ellipse(r.x, r.y, dim*0.05, dim*0.05);
  }

  ArrayList<PVector> points = new ArrayList<PVector>();
  for (int i = 0; i < rects.size(); i++) {
    Rect r = rects.get(i);
    points.add(new PVector(r.x, r.y));
  }

  ArrayList triangles = Triangulate.triangulate(points);

  for (int i = 0; i < triangles.size(); i++) {

    if (random(1) < 0.6) continue;
    Triangle t = (Triangle)triangles.get(i);

    beginShape(TRIANGLES);
    fill(rcol());
    vertex(t.p1.x, t.p1.y);
    fill(rcol(), random(180, 255));
    vertex(t.p2.x, t.p2.y);
    vertex(t.p3.x, t.p3.y);
    endShape();

    PVector cen = t.p1.copy().add(t.p2).add(t.p3).div(3);
    noStroke();
    fill(255);
    ellipse(cen.x, cen.y, 2, 2);
  }

  for (int i = 0; i < rects.size(); i++) {
    Rect r = rects.get(i);

    float s = r.w*random(0.8, 0.9);

    stroke(255, 240);
    noFill();
    ellipse(r.x, r.y, s, s);
    noStroke();
    arc2(r.x, r.y, s, s*1.4, 0, TAU, color(255), 10, 0);

    noStroke();
    fill(255);
    ellipse(r.x, r.y, 4, 4);
  }

  stroke(255);
  for (int i = 0; i < datas.size(); i++) {
    PVector r1 = datas.get(i);
    for (int j = 0; j < rects.size(); j++) {
      Rect r2 = rects.get(j);
      if (dist(r1.x, r1.y, r2.x, r2.y) < min(r1.z, min(r2.w, r2.h))*1.8) {
        line(r1.x, r1.y, r2.x, r2.y);
      }
    }
  }


  noStroke();
  fill(255);
  for (int i = 0; i < datas.size(); i++) {
    PVector p = datas.get(i);

    fill(getColor(), random(255));
    rect(p.x, p.y, p.z, p.z);
    fill(255, random(120));
    ellipse(p.x, p.y, p.z, p.z);
    fill(255);
    rect(p.x, p.y, p.z*0.4, p.z*0.4, p.z*0.05);
    fill(rcol());
    rect(p.x, p.y, p.z*0.2, p.z*0.2, p.z*0.025);
  }
}


void arc2(float x, float y, float s1, float s2, float a1, float a2, int col, float alp1, float alp2) {
  float r1 = s1*0.5;
  float r2 = s2*0.5;
  int cc = (int) max(4, PI*pow(max(s1, s2)*0.1, 1)*3);

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

//int colors[] = {#001077, #FA1359, #EA6395, #E8E7E9, #DDBD00, #007F4B};
int colors[] = {#1E1119, #061EC9, #EFABC5, #F7D83B, #F3E6D8};
//int colors[] = {#EFE5D1, #F09BC4, #F54034, #1F43B1, #02ADDC};
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
