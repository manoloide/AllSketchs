import org.processing.wiki.triangulate.*;
import toxi.math.noise.SimplexNoise;

int seed = int(random(999999));


boolean export = false;
void setup() {

  size(1280, 720);
  //smooth(8);
  noSmooth();
  //tpixelDensity(2);

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

  background(50);


  noStroke();
  fill(0, 50);
  float ss = height-100;
  rect(width*(0.5)-ss*0.5-50, 10, ss+60, ss+60);
  //noSmooth();



  int ww = 128;
  int hh = 128;

  ArrayList<Rect> rects = new ArrayList<Rect>(); 
  for (int i = 0; i < 18; i++) {
    int w = int(random(random(4, 20), 30));
    int h = int(random(random(4, 20), 30));
    int ix = int(random(1, ww-w));
    int iy = int(random(1, hh-h));

    ix -= ix%2;
    ix += 1;
    iy -= iy%2;
    iy += 1;

    rects.add(new Rect(ix, iy, w, h));
  }

  ArrayList<PVector> points = new ArrayList<PVector>(); 
  for (int i = 0; i < rects.size(); i++) {
    Rect r = rects.get(i);
    points.add(new PVector(r.x+r.w*0.5, r.y+r.h*0.5));
  }

  ArrayList<Triangle> triangles = Triangulate.triangulate(points);

  PGraphics aux = createGraphics(ww, hh);
  //aux.beginDraw();

  /*
  aux.background(#53B5FF);
   aux.stroke(255);
   for (int j = 0; j < triangles.size(); j++) {
   Triangle t = triangles.get(j);
   
   //if (random(1) < 0.5) {
   aux.line(t.p1.x, t.p1.y, min(t.p1.x, t.p2.x), t.p1.y);
   aux.line(t.p2.x, t.p2.y, t.p2.x, min(t.p1.y, t.p2.y));
   //} else {
   aux.line(t.p1.x, t.p1.y, t.p1.x, max(t.p1.y, t.p2.y));
   aux.line(t.p2.x, t.p2.y, max(t.p1.x, t.p2.x), t.p2.y);
   //}
   //aux.line(t.p2.x, t.p2.y, max(t.p1.x, t.p2.x), min(t.p1.y, t.p2.y));
   //}
   }
   for (int i = 0; i < rects.size(); i++) {
   aux.stroke(255);
   aux.noFill();
   aux.stroke(0);
   aux.noStroke();
   aux.fill(rcol());
   Rect r = rects.get(i);
   aux.rect(r.x, r.y, r.w, r.h);
   }
   
   
   for (int j = 0; j < 100; j++) {
   int ix = int(random(1, ww-1));
   int iy = int(random(1, hh-1));
   aux.fill(rcol());
   aux.rect(ix, iy, 1, 1);
   }
   aux.endDraw();
   aux.save("tiles.png");
   image(aux.get(), (width-512-128)*0.5, (height-512-128)*0.5, 512+128, 512+128);
   */

  aux.beginDraw();
  aux.clear();
  for (int k = 0; k < 60; k++) {
    int ix = int(random(1, ww-1));
    int iy = int(random(1, hh-1));
    for (int j = 0; j < 50; j++) {
      float ang = random(TAU);
      float dis = random(8)*random(0.8, 1);
      int nx = int(ix+cos(ang)*dis);
      int ny = int(iy+sin(ang)*dis);
      float brig = brightness(aux.get(nx, ny));
      if (brig > 40 && brig < 240) {
        aux.fill(40, 190, 140);
        aux.rect(nx, ny, 1, 1);
      }
    }
  }
  
  for (int j = 0; j < 100; j++) {
    int ix = int(random(1, ww-1));
    int iy = int(random(1, hh-1));
    float brig = brightness(aux.get(ix, iy));
    if (brig > 40 && brig < 240) {
      aux.fill(240, 200, 10);
      aux.rect(ix, iy, 1, 1);
    }
  }
  aux.endDraw();
  aux.save("item.png");
  image(aux.get(), (width-512-128)*0.5, (height-512-128)*0.5, 512+128, 512+128);
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2); 
  saveFrame(timestamp+"-"+seed+".png");
}

//int colors[] = {#030005, #0E263F, #F91800, #F6E479, #F0F2F5};
int colors[] = {#F6E8EA, #EF8F96, #162051, #312F2F, #9CDB62};
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
  return lerpColor(c1, c2, pow(v%1, 1.2));
} 
