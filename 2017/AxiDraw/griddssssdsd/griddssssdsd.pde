int seed = int(random(999999));

void setup() {
  size(960, 960, P2D);
  smooth(8);
  pixelDensity(2);
  generate();
}

void draw() {
  //if (frameCount%40 == 0) generate();

  //render();
}

void keyPressed() {
  if (key == 's') saveImage();
  else generate();
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

void generate() {
  seed = int(random(999999));

  render();
}

void render() {

  //lights();
  noiseSeed(seed);
  randomSeed(seed);

  background(getColor(random(8)));

  translate(width/2, height/2);


  for (int k = 0; k < 6; k++) {
    float ss = width*random(0.4, 0.75);
    PVector p1 = new PVector(random(-ss, 0), random(-ss, 0));
    PVector p2 = new PVector(random(0, ss), random(-ss, 0));
    PVector p3 = new PVector(random(0, ss), random(0, ss));
    PVector p4 = new PVector(random(-ss, 0), random(0, ss));
    Quad quad = new Quad(p1, p2, p3, p4);

    ArrayList<Quad> quads = new ArrayList<Quad>();
    quads.add(quad);

    for (int i = 0; i < 6; i++) {
      int ind = int(random(quads.size()));
      quads.addAll(quads.get(ind).sub(random(0.1, 0.9), random(0.1, 0.9)));
      quads.remove(ind);
    }

    for (int i = 0; i < quads.size(); i++) {
      Quad q = quads.get(i);
      noStroke();
      fill(rcol());
      q.show();
    }
  }
} 

class Quad {
  Quad parent; 
  PVector p1, p2, p3, p4;
  Quad(PVector p1, PVector p2, PVector p3, PVector p4) {
    this.p1 = p1; 
    this.p2 = p2; 
    this.p3 = p3; 
    this.p4 = p4;
    parent = null;
  } 
  Quad(Quad parent, PVector p1, PVector p2, PVector p3, PVector p4) {
    this.p1 = p1; 
    this.p2 = p2; 
    this.p3 = p3; 
    this.p4 = p4;
    this.parent = parent;
  }
  ArrayList<Quad> sub(float sw, float sh) {
    ArrayList<Quad> aux = new ArrayList<Quad>();
    if (random(1) < 0.8) aux.add(new Quad(getPoint(0, 0), getPoint(sw, 0), getPoint(sw, sh), getPoint(0, sh)));
    if (random(1) < 0.8) aux.add(new Quad(getPoint(sw, sh), getPoint(1, sh), getPoint(1, 1), getPoint(sw, 1)));
    if (random(1) < 0.8) aux.add(new Quad(getPoint(0, sh), getPoint(sw, sh), getPoint(sw, 1), getPoint(0, 1)));
    if (random(1) < 0.8) aux.add(new Quad(getPoint(sw, 0), getPoint(1, 0), getPoint(1, sh), getPoint(sw, sh)));
    return aux;
  }
  PVector getPoint(float sw, float sh) {
    float x1 = lerp(p1.x, p2.x, sw);
    float x2 = lerp(p4.x, p3.x, sw);
    float x = lerp(x1, x2, sh);
    float y1 = lerp(p1.y, p2.y, sw);
    float y2 = lerp(p4.y, p3.y, sw);
    float y = lerp(y1, y2, sh);
    return new PVector(x, y);
  }
  void show() {
    /*
    pushStyle();
     fill(0, 10);
     pushMatrix();
     translate(random(-20, 20), random(-20, 20));
     beginShape();
     vertex(p1.x, p1.y);
     vertex(p2.x, p2.y);
     vertex(p3.x, p3.y);
     vertex(p4.x, p4.y);
     endShape(CLOSE);
     popMatrix();
     popStyle();
     */
    boolean rndcol = random(1) < 0.0;

    /*
    beginShape();
     if (rndcol) fill(rcol());
     vertex(p1.x, p1.y);
     if (rndcol) fill(rcol());
     vertex(p2.x, p2.y);
     if (rndcol) fill(rcol());
     vertex(p3.x, p3.y);
     if (rndcol) fill(rcol());
     vertex(p4.x, p4.y);
     endShape(CLOSE);
     */


    strokeWeight(random(3));
    stroke(rcol());
    int sub = int(random(2, 10)); 

    if (random(1) < 0.4) {
      for (int j = 0; j <= sub; j++) {
        for (int i = 0; i <= sub; i++) {
          PVector p = getPoint(i*1./sub, j*1./sub);
          point(p.x, p.y);
        }
      }
    } else {
      boolean str = random(1) < 0.8;
      if (str) noFill();
      else {
        fill(rcol());
        noStroke();
      }
      int mc = int(random(2));
      for (int j = 0; j < sub; j++) {
        for (int i = 0; i < sub; i++) {
          PVector p1 = getPoint(i*1./sub, j*1./sub);
          PVector p2 = getPoint((i+1)*1./sub, j*1./sub);
          PVector p3 = getPoint((i+1)*1./sub, (j+1)*1./sub);
          PVector p4 = getPoint(i*1./sub, (j+1)*1./sub);
          if ((i+j)%2 == mc || str) quad(p1.x, p1.y, p2.x, p2.y, p3.x, p3.y, p4.x, p4.y);
        }
      }
    }
  }
}

int colors[] = {#F05638, #F5C748, #3FD189, #FFB9DB, #AF8AB4, #6FC4EA, #FFFFFF, #412A50};
//int colors[] = {#45171D, #F03861, #FF847C, #FECEA8};
int rcol() {
  return colors[int(random(colors.length))];
}
int getColor(float v) {
  v = v%(colors.length);

  int c1 = colors[int(v%colors.length)];
  int c2 = colors[int((v+1)%colors.length)];
  float m = v%1;

  //m = pow(m, 4);
  //return c1;
  return lerpColor(c1, c2, m);
}