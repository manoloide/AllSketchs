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
  size(int(swidth*scale), int(sheight*scale));
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
  else if (keyCode == LEFT) {
    seed--;
    generate();
  } else if (keyCode == RIGHT) {
    seed++;
    generate();
  } else {
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

  println(seed);
  randomSeed(seed);
  scale(scale);

  background(20);
  background(rcol());

  noStroke();
  for (int i = 0; i < 200; i++) {
    fill(rcol(), random(180, 255));
    float s = random(1, 3)*random(0.5, 1);
    ellipse(random(width), random(height), s, s);
  }

  fill(255, 30);
  for (int i = 0; i < 200000; i++) {
    float s = random(1, 5)*0.2*random(1);
    ellipse(random(width), random(height), s, s);
  }

  int bb = 10;
  int cc = int(random(10, 22));
  float ss = (width*1.-bb*2)/cc;

  stroke(255, 20);
  strokeWeight(0.11);
  for (int i = 0; i <= cc*10; i++) {
    line(bb+ss*i*0.1, bb+0, bb+ss*i*0.1, height-bb);
    line(bb+0, bb+ss*i*0.1, width-bb, bb+ss*i*0.1);
  }

  strokeWeight(1);
  for (int i = 0; i <= cc; i++) {
    line(bb+ss*i, bb+0, bb+ss*i, height-bb);
    line(bb+0, bb+ss*i, width-bb, bb+ss*i);
  }

  ArrayList<Rect> rects = new ArrayList<Rect>();
  rects.add(new Rect(0, 0, cc, cc));

  for (int i = 0; i < 30; i++) {
    int ind = int(random(rects.size()));
    Rect r = rects.get(ind);
    if (r.w == 1 || r.h == 1) continue;
    int nw = int(random(1, r.w));
    int nh = int(random(1, r.h));
    rects.add(new Rect(r.x, r.y, nw, nh));
    rects.add(new Rect(r.x+nw, r.y, r.w-nw, nh));
    rects.add(new Rect(r.x+nw, r.y+nh, r.w-nw, r.h-nh));
    rects.add(new Rect(r.x, r.y+nh, nw, r.h-nh));
    rects.remove(ind);
  }

  rectMode(CORNER);
  for (int i = 0; i < rects.size(); i++) {
    Rect r = rects.get(i);
    fill(rcol(), random(255)*random(0.6, 1));
    rect(bb+r.x*ss+2, bb+r.y*ss+2, r.w*ss-4, r.h*ss-4);
  }


  ArrayList<PVector> agents = new ArrayList<PVector>();

  for (int i = 0; i < pow(cc*1.2, 0.8); i++) {

    float xx = bb+(int(random(cc))+0.5)*ss;
    float yy = bb+(int(random(cc))+0.5)*ss; 

    boolean add = true;

    for (int j = 0; j < agents.size(); j++) {
      PVector o = agents.get(j);
      if (dist(xx, yy, o.x, o.y) < ss) {
        add = false;
        break;
      }
    }
    if (add)
      agents.add(new PVector(xx, yy));
  }

  rectMode(CENTER);
  for (int i = 0; i < pow(cc, 1.4); i++) {
    float xx = bb+(int(random(cc))+0.5)*ss;
    float yy = bb+(int(random(cc))+0.5)*ss; 
    fill(rcol());
    rect(xx, yy, ss*0.08, ss*0.08);
  }

  ArrayList<PVector> points = new ArrayList<PVector>();
  for (int i = 0; i < pow(cc, 1.4); i++) {
    float xx = bb+(int(random(cc))+0.5)*ss;
    float yy = bb+(int(random(cc))+0.5)*ss; 

    points.add(new PVector(xx, yy));
  }


  for (int j = 0; j < agents.size(); j++) {
    PVector a = agents.get(j);
    stroke(0, 5);
    fill(rcol(), 20);
    ellipse(a.x, a.y, ss*4, ss*4);
  }


  noStroke();
  rectMode(CENTER);
  for (int j = 0; j < cc; j++) {
    for (int i = 0; i < cc; i++) {
      float xx = bb+ss*(i+0.5);
      float yy = bb+ss*(j+0.5);
      noStroke();
      fill(255, 16);
      rect(xx, yy, ss*0.06, ss*0.06);
      fill(255, 80);
      rect(xx, yy, ss*0.012, ss*0.012);

      noFill();
      stroke(255, random(60));
      rect(xx, yy, ss*0.8, ss*0.8);
      
      
    
    if(random(1) < 0.2) ellipse(xx, yy, ss*0.2, ss*0.2);
    }
  }


  fill(255, 20);
  rectMode(CENTER);
  noStroke();

  for (int i = 0; i < points.size(); i++) {
    PVector p = points.get(i);
    noStroke();
    fill(0, 30);
    rect(p.x+0.5, p.y+0.5, ss*0.8, ss*0.8);
    fill(rcol(), 200);
    rect(p.x, p.y, ss*0.8, ss*0.8);
    fill(rcol(), 200);
    rect(p.x, p.y, ss*0.2, ss*0.2);
    fill(255);
    ellipse(p.x, p.y, ss*0.02, ss*0.02);

    stroke(255, 240, 245, 40);
    strokeWeight(0.4);
    for (int j = 0; j < agents.size(); j++) {
      PVector a = agents.get(j);
      if (p.dist(a) < 220) {
        line(p.x, p.y, a.x, a.y);
      }
    }
  }




  ArrayList triangles = Triangulate.triangulate(agents);

  stroke(250, 6);
  fill(255, 40);
  beginShape(TRIANGLES);
  for (int i = 0; i < triangles.size(); i++) {
    Triangle t = (Triangle)triangles.get(i);
    fill(rcol(), random(12));
    vertex(t.p1.x, t.p1.y);
    vertex(t.p2.x, t.p2.y);
    vertex(t.p3.x, t.p3.y);
  }
  endShape();

  noStroke();
  for (int j = 0; j < agents.size(); j++) {
    PVector a = agents.get(j);
    fill(0);
    ellipse(a.x, a.y, ss*0.9, ss*0.9);
    fill(rcol());
    ellipse(a.x, a.y, ss*0.8, ss*0.8);
    fill(255);
    ellipse(a.x, a.y, ss*0.12, ss*0.12);
  }
}


void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+"-"+seed+".png");
}

int colors[] = {#B0E7FF, #143585, #5ACAA2, #ff91d0, #f9ad31};
//int colors[] = {#01EEBA, #E8E3B3, #E94E6B, #F08BB2, #41BFF9};
//int colors[] = {#000000, #eeeeee, #ffffff};
//int colors[] = {#DFAB56, #E5463E, #366A51, #2884BC};
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
