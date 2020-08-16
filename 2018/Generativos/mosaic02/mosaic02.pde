import org.processing.wiki.triangulate.*;
import toxi.math.noise.SimplexNoise;

int seed = int(random(999999));
float det, des;
PShader post;

void setup() {
  size(960, 960, P3D);
  smooth(8);
  pixelDensity(2);

  post = loadShader("post.glsl");

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


ArrayList<Rect> rects;

class Rect {
  float x, y, w, h;
  Rect(float x, float y, float w, float h) {
    this.x = x; 
    this.y = y; 
    this.w = w; 
    this.h = h;
  }
}


void subdivide(Rect r) {

  float mw = r.w*0.5;
  float mh = r.h*0.5;
  rects.add(new Rect(r.x, r.y, mw, mh));
  rects.add(new Rect(r.x+mw, r.y, r.w-mw, mh));
  rects.add(new Rect(r.x+mw, r.y+mh, r.w-mw, r.h-mh));
  rects.add(new Rect(r.x, r.y+mh, mw, r.h-mh));

  rects.remove(r);
}



void generate() { 

  randomSeed(seed);
  background(rcol());

  resetShader(LINES);

  rects = new ArrayList<Rect>();
  rects.add(new Rect(0, 0, width, height));

  for (int i = 0; i < 100; i++) {
    Rect r = rects.get(int(random(rects.size()*0.5))); 
    subdivide(r);
  }

  ArrayList<PVector> points = new ArrayList<PVector>();


  ArrayList<PVector>[] group = (ArrayList<PVector>[])new ArrayList[4];

  for (int i = 0; i < group.length; i++) {
    group[i] = new ArrayList<PVector>();
  }

  strokeWeight(0.8);

  for (int i = 0; i < rects.size(); i++) {
    Rect r = rects.get(i);
    fill(rcol());
    rect(r.x, r.y, r.w, r.h);
    int col = rcol();
    shadow(r.x, r.y, r.w, r.h, col);
    float s = min(r.w, r.h)*0.5;
    fill(rcol());
    ellipse(r.x+r.w*0.5, r.y+r.h*0.5, s, s);
    fill(rcol());
    ellipse(r.x+r.w*0.5, r.y+r.h*0.5, s*0.1, s*0.1);
    PVector p = new PVector(r.x+r.w*0.5, r.y+r.h*0.5, s);
    points.add(p);

    int g = int(random(4));
    group[g].add(p);
  }

  for (int i = 0; i < group.length; i++) {
    ArrayList<PVector> aux = new ArrayList<PVector>();
    for (int j = 0; j < group[i].size(); j++) {
      PVector n = group[i].get(j).copy(); 
      n.z = 0;
      aux.add(n);
    }

    ArrayList triangles = Triangulate.triangulate(aux);
    // draw the mesh of triangles
    stroke(0, 40);
    fill(255, 40);
    beginShape(TRIANGLES);
    for (int k = 0; k < triangles.size(); k++) {
      if(random(1) < 0.9) continue;
      Triangle t = (Triangle)triangles.get(k);
      vertex(t.p1.x, t.p1.y);
      vertex(t.p2.x, t.p2.y);
      vertex(t.p3.x, t.p3.y);
    }
    endShape();
  }

  post = loadShader("post.glsl");


  //filter(post);
}

void shadow(float x, float y, float w, float h, int col) {
  boolean des = random(1) < 0.5;
  beginShape();
  fill(col, 180);
  vertex(x, y);
  fill(col, 180);
  if (des) fill(col, 0);
  vertex(x+w, y);
  fill(col, 0);
  vertex(x+w, y+h);
  fill(col, 0);
  if (des) fill(col, 180);
  vertex(x, y+h);
  endShape(CLOSE);
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}
int colors[] = {#DFAB56, #E5463E, #366A51, #2884BC};
//int colors[] = {#043387, #0199DC, #BAD474, #FBE710, #FFE032, #EB8066, #E7748C, #DF438A, #D9007E, #6A0E80, #242527, #FCFCFA};
//int colors[] = {#687FA1, #AFE0CD, #FDECB4, #F63A49, #FE8141};
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
