float time, initTime;
int seed = int(random(99999999));

ArrayList<Quad> quads;
float rx, ry, rz;

void setup() {
  size(960, 960, P3D);
  smooth(8);

  generate();
}


void draw() {
  //time = (millis()-initTime)/1000.;

  //if (frameCount%30 == 0) generate();

  background(0, 2, 10);
  randomSeed(seed);
  noiseSeed(seed);

  translate(width/2, height/2, 0);
  rotateX(rx);
  rotateY(ry);
  rotateZ(rz);
  for (int i = 0; i < quads.size(); i++) {
    Quad q = quads.get(i);
    q.show();
  }
}

void keyPressed() {
  if (key == 's') saveFrame();
  else generate();
}

void generate() {
  initTime = millis();
  seed = int(random(99999999));
  rx = random(-0.2, 0.2);
  ry = random(-0.2, 0.2);
  rz = random(-0.2, 0.2);

  quads = new ArrayList<Quad>();
  quads.add(new Quad(-width/2.-300, -height/2.-300, width+600, height+600));
  for (int i = 0; i < 30; i++) {
    int ind = int(random(quads.size()*random(1)));
    Quad q = quads.get(ind);
    float mw = q.w*0.5;
    float mh = q.h*0.5;
    quads.add(new Quad(q.x, q.y, mw, mh));
    quads.add(new Quad(q.x+mw, q.y, mw, mh));
    quads.add(new Quad(q.x+mw, q.y+mh, mw, mh));
    quads.add(new Quad(q.x, q.y+mh, mw, mh));
    quads.remove(ind);
  }
}

int colors[] = {color(255), color(255), color(80), color(240, 80, 0)};
int rcol() {
  return colors[int(random(colors.length))];
}

class Quad {
  boolean vertical;
  float x, y, w, h;  
  float b = 2;
  float ss;
  int seg;
  int ix[];
  Quad(float x, float y, float w, float h) {
    this.x = x; 
    this.y = y;
    this.w = w;
    this.h = h;
    vertical = random(1) < 0.5;
    seg = int(random(1, 80));
    ss = (h-b)/seg;
    if (vertical) {
      ss = (w-b)/seg;
    }
    ix = new int[seg];
  }

  void show() {
    rectMode(CORNERS);
    noStroke();
    //rect(x+b, y+b, x+w-b, y+h-b);
    if (vertical) {
      for (int j = 0; j < seg; j++) {
        float dy = time*random(-180, 180);
        float x1 = x+b+ss*j; 
        float x2 = x+ss*j+ss; 
        float yy = y;
        int dd = 0;
        while (yy < y+h) {
          fill(rcol());
          float s = ss*(int(1+noise(x, y+dd, j)*6));
          float y1 = constrain(yy+dy, y+b, y+h-b); 
          float y2 = constrain(yy+s+dy, y+b, y+h-b);
          rect(x1, y1, x2, y2);
          yy += s+b;
          dd++;
        }
      }
    } else {
      for (int j = 0; j < seg; j++) {
        float dx = time*random(-180, 180);
        float y1 = y+b+ss*j; 
        float y2 = y+ss*j+ss; 
        float xx = x;
        while (xx < x+w) {
          fill(rcol());
          float s = ss*int(random(1, 6));
          float x1 = constrain(xx+dx, x+b, x+w-b); 
          float x2 = constrain(xx+s+dx, x+b, x+w-b);
          rect(x1, y1, x2, y2);
          xx += s+b;
        }
      }
    }
  }
}