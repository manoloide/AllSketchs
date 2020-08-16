void setup() {
  size(1920, 1920, P3D);
  smooth(8);
  generate();
}

void draw() {
  //if (frameCount%80 == 0) generate();
}

void keyPressed() {
  if (key == 's') saveImage();
  else generate();
}

void saveImage() {
  String name = nf(day(), 2)+nf(hour(), 2)+nf(minute(), 2)+nf(second(), 2);
  saveFrame(name+".png");
}

void generate() {
  background(random(20)*random(1), random(20)*random(1), random(20));
  translate(width/2, height/2, 300);
  rotateX(random(-PI*0.1, PI*0.1));
  rotateY(random(-PI*0.1, PI*0.1));
  //rotateZ(random(-PI*0.1, PI*0.1));
  noFill();
  stroke(60);
  noStroke();

  ArrayList<Quad> quads = new ArrayList<Quad>();
  quads.add(new Quad(-width/2, -height/2, width, height));
  int cc = int(random(50));
  for (int i = 0; i < cc; i++) {
    int ind = int(random(quads.size()));
    Quad q = quads.get(ind);
    boolean hori = false;
    if (q.w < 10 || q.h < 10) continue;
    if (q.w == q.h) {
      if (random(1) < 0.5) hori = true;
    } else {
      if (q.w > q.h) hori = true;
    }

    int div = int(pow(2, int(random(1, 5))));
    if (hori) {
      float des = q.w/div;
      for (int j = 0; j < div; j++) {
        quads.add(new Quad(q.x+des*j, q.y, des, q.h));
      }
    } else {
      float des = q.h/div;
      for (int j = 0; j < div; j++) {
        quads.add(new Quad(q.x, q.y+des*j, q.w, des));
      }
    }
    quads.remove(ind);
  }

  //blendMode(ADD);
  for (int i = 0; i < quads.size(); i++) {
    Quad q = quads.get(i);
    float x = q.x;
    float y = q.y;
    float w = q.w;
    float h = q.h;
    color col = rcol();

    noStroke();
    fill(col);
    //rect(x, y, w, h);

    gridRect(x, y, w, h, 2, int(random(2, 20)));

    //grid(q.x, q.y, q.w, q.h, int(pow(2, int(random(1, 5)))));
  }
  blendMode(BLEND);
}

void gridRect(float x, float y, float w, float h, float b, int c) {
  float dx = x+b;
  float dy = y+b;

  float sw = (w-b*2)*1./c;
  float sh = (h-b*2)*1./c;

  float ss = random(0.9, 1);
  color col = g.fillColor;

  float det = random(2)*random(1);
  float rou = min(sw, sh)*random(0.3)*random(1);
  for (int j = 0; j < c; j++) { 
    for (int i = 0; i < c; i++) {
      pushMatrix();
      float n = noise(x+i*det, y+j*det);
      fill(col);
      fill(rcol(), random(256));
      rect(dx+i*sw, dy+j*sh, sw*ss, sh*ss, rou);
      fill(col, 160+n*20);
      translate(0, 0, min(sw, sh)*n*2);
      //rect(dx+i*sw, dy+j*sh, sw*ss, sh*ss, rou);
      popMatrix();
    }
  }
}

void grid(float x, float y, float w, float h, int cw, int ch) {
  float dx = w/cw;
  float dy = h/ch;

  for (int i = 0; i <= cw; i++) {
    line(x+dx*i, y, x+dx*i, y+h);
  }

  for (int i = 0; i <= ch; i++) {
    line(x, y+dy*i, x+w, y+dy*i);
  }
}

void grid(float x, float y, float w, float h, int cc) {
  grid(x, y, w, h, cc, cc);
}

int colours[] = {#5C82B5, #FF0000, #BE9CC7, #9CBA3C};
int rcol() { 
  return colours[int(random(colours.length))];
}; 

class Quad {
  float x, y, w, h;
  Quad(float x, float y, float w, float h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }
}