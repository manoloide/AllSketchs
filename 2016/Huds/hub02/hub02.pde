 ColorRamp cr;

boolean rever; 
int seed = int(random(99999999));
float time = 0;

PShader post;

void setup() {
  size(640, 640, P3D);
  smooth(8);
  cr = new ColorRamp();
  cr.addColor(#FF3636, 0.5, true);
  cr.addColor(#6791FF, 0.6, true);

  post = loadShader("post.glsl");
  post.set("resolution", float(width), float(height));

  generate();
}

void draw() {

  post.set("time", millis()/1000.);

  if (rever) {
    time -= 1./30;
    if (time <= 0) {
      rever = false;
      generate();
    }
  } else time += 1./60;
  background(#06060D);
  //blendMode(ADD);
  translate(width/2, height/2, 0);
  rotateY(sin(frameCount*0.004)*0.6);
  stroke(255, 9);
  strokeWeight(0.5);
  grid(-width/2-400, -height/2-400, width+800, height+800, 32, 32);
  randomSeed(seed);
  for (int i = 0; i < int (random (8, 110)); i++) {
    float tt = (time-i*0.02)*random(0.8, 2);
    float rnd = random(2);
    float z = random(100);
    float d = random(random(40, 120), 400);
    if (rnd < 0.1) {
      arcSeg(0, 0, z, d, int(random(4, 12))*2, tt);
    } else if (rnd < 1) circle(0, 0, z, d, tt);
    else if (rnd < 1.3) circleLine2(0, 0, z, d*random(random(0.9, 0.97), 1), d, int(random(2, 12)), int(random(2, 8)), tt);
    else if (rnd < 1.4) circleLine(0, 0, z, d*random(random(0.9, 0.97), 1), d, int(random(8, 64)), tt);
    else circleCircle(0, 0, z, d, random(5), int(random(6, 52)), tt);
  }

  //filter(post);
}

void keyPressed() {
  if (key == 's') saveImage();
  else {
    time = 1;
    rever = true;
  }
}

void generate() {
  time = 0;
  seed++;
}

void grid(float x, float y, float w, float h, int cw, int ch) {
  float dx = w*1./cw;
  float dy = h*1./ch;
  float pos;
  for (int i = 0; i <= cw; i++) {
    pos = x+i*dx;
    line(pos, y, pos, y+h);
  }
  for (int i = 0; i <= ch; i++) {
    pos = y+i*dy;
    line(x, pos, x+w, pos);
  }
}

void arc1(float x, float y, float z, float d, float a1, float a2, float t) {
  t = constrain(t, 0, 1);
  float ts = sin(t*HALF_PI);
  pushMatrix();
  translate(0, 0, z*ts);
  float dd = d*ts;
  float at = map(t, 0, 1, a1, a2);
  noFill();
  stroke(cr.getColor(random(1)));
  strokeWeight(random(1, 12)*t);
  arc(x, y, dd, dd, a1, at);
  popMatrix();
}

void arcForm(float x, float y, float d1, float d2, float a1, float a2) {
  float r1 = d1*0.5;
  float r2 = d2*0.5;
  float amp = a2-a1;
  int res = int(r2*amp/10)+1;
  float da = amp/res;
  beginShape();
  float a;
  for (int i = 0; i <= res; i++) {
    a = a1+i*da;
    vertex(x+cos(a)*r1, y+sin(a)*r1);
  }
  for (int i = 0; i <= res; i++) {
    a = a2-i*da;
    vertex(x+cos(a)*r2, y+sin  (a)*r2);
  }
  endShape(CLOSE);
}

void arcSeg(float x, float y, float z, float d, int c, float t) {
  t = constrain(t, 0, 1);
  float ts = sin(t*HALF_PI);
  boolean sep = (random(1) < 0.4)? true : false;
  float amp = (TWO_PI*ts)/c;
  float dd = amp*random(0.02, random(0.07, 0.45));
  float d2 = (d*random(0.65, 0.9))*ts;
  d *= ts;
  if (random(1) < 0.6) {
    noStroke();
    fill(cr.getColor(random(1)));
  } else {
    noFill();
    dd = amp*random(0.02, 0.1);
    strokeWeight(random(0.5, 2));
    stroke(cr.getColor(random(1)));
  }
  pushMatrix();
  translate(0, 0, z*ts);
  color col = cr.getColor(random(1));
  for (int j = 0; j < c; j++) {
    arcForm(x, y, d2, d, amp*j+dd-HALF_PI, amp*(j+1)-dd-HALF_PI);
  }
  popMatrix();
}

void circle(float x, float y, float z, float d, float t) {
  t = constrain(t, 0, 1);
  float ts = sin(t*HALF_PI);
  pushMatrix();
  translate(0, 0, z*ts);
  float dd = d*ts;
  noFill();
  stroke(cr.getColor(random(1)));
  strokeWeight(random(0.5, 5)*t);
  ellipse(x, y, dd, dd);
  popMatrix();
}

void circleCircle(float x, float y, float z, float d, float s, int c, float t) {
  t = constrain(t, 0, 1);
  float ts = sin(t*HALF_PI);
  float r = d*0.5;
  float dd = d*ts;
  float v = random(-0.012, 0.012);
  pushMatrix();
  translate(0, 0, z*ts);
  noStroke();
  fill(cr.getColor(random(1)));
  float da = TWO_PI/c;
  float ss = s*ts;
  float a;
  for (int i = 0; i < c; i++) {
    a = da*i+frameCount*v;
    ellipse(x+cos(a)*r, y+sin(a)*r, ss, ss);
  }
  popMatrix();
}

void circleLine(float x, float y, float z, float d1, float d2, int c, float t) {
  t = constrain(t, 0, 1);
  float ts = sin(t*HALF_PI);
  float r1 = d1*0.5*ts;
  float r2 = d2*0.5*ts;
  float v = random(-0.012, 0.012);
  pushMatrix();
  translate(0, 0, z*ts);
  stroke(cr.getColor(random(1)));
  strokeWeight(random(0.5, 2));
  float da = TWO_PI/c;
  float a;
  for (int i = 0; i < c; i++) {
    a = da*i+frameCount*v;
    line(x+cos(a)*r1, y+sin(a)*r1, x+cos(a)*r2, y+sin(a)*r2);
  }
  popMatrix();
}

void circleLine2(float x, float y, float z, float d1, float d2, int c, int s, float t) {
  t = constrain(t, 0, 1);
  float ts = sin(t*HALF_PI);
  float r1 = d1*0.5*ts;
  float r2 = d2*0.5*ts;
  float r3 = (r2+(r2-r1)*random(0.5, 2.5));
  float v = random(-0.012, 0.012);
  pushMatrix();
  translate(0, 0, z*ts);
  stroke(cr.getColor(random(1)));
  strokeWeight(random(0.5, 2));
  float da = TWO_PI/(c*s);
  float a, rr;
  for (int i = 0; i < c*s; i++) {
    a = da*i+frameCount*v;
    rr = (i%s == 0)? r3 : r2;
    line(x+cos(a)*r1, y+sin(a)*r1, x+cos(a)*rr, y+sin(a)*rr);
  }
  popMatrix();
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

class Color {
  color col;
  float pos;
  boolean solid;
  Color (int col, float pos, boolean solid) {
    this.col = color(col);
    this.pos = pos;
    this.solid = solid;
  }
  Color (int col, float pos) {
    this(col, pos, false);
  }
}

class ColorRamp {
  ArrayList<Color> colors;
  ColorRamp () {
    colors = new ArrayList<Color>();
  }

  void addColor(int c, float p, boolean s) {
    p = constrain(p, 0, 1);
    int ind = 0;
    for (int i = 0; i < colors.size (); i++) {
      ind = i;
      if (p >= colors.get(i).pos) {
        break;
      }
    }
    colors.add(ind, new Color(c, p, s));
  }

  void addColor(int c, float p) {
    addColor(c, p, false);
  }

  color getColor(float p) {
    p = constrain(p, 0, 1);
    color col = color(0);

    if (colors.size() > 0) {
      col = colors.get(colors.size()-1).col;
    } 


    for (int i = 1; i < colors.size (); i++) {
      if (p >= colors.get(i).pos) {
        Color ant = colors.get(i-1);
        Color act = colors.get(i);
        if (ant.solid) col = ant.col;
        else col = lerpColor(ant.col, act.col, map(p, ant.pos, act.pos, 0, 1));
        break;
      }
    }
    return col;
  }

  void show(float x, float y, float w, float h) {
    for (int i = 0; i < w; i++) {
      stroke(getColor(i*1./w));
      line(x+i, y, x+i, y+h);
    }
  }
}

