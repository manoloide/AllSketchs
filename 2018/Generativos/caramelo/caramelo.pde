int seed = int(random(999999));

void setup() {
  size(960, 960, P3D);
  smooth(8);
  pixelDensity(2);
  generate();
}
void draw() {
  //if (frameCount%60 == 0) generate();
  //generate();
}
void keyPressed() {
  if (key == 's') saveImage();
  else {
    seed = int(random(999999));
    generate();
  }
}

void generate() {

  randomSeed(seed);
  background(rcol());

  ortho();

  strokeWeight(1);
  noFill();
  for (int i = 0; i < 10000; i++) {
    float x = random(width);
    float y = random(height);
    float s = width*random(0.02);
    float a1 = random(TWO_PI);
    float a2 = a1+random(HALF_PI);
    stroke(rcol());
    arc(x, y, s, s, a1, a2);
  }

  translate(0, 0, 1);

  ArrayList<PVector> points = new ArrayList<PVector>();

  for (int i = 0; i < 10000; i++) {
    float x = random(width);
    float y = random(height);
    float s = width*random(0.5)*random(0.5, 1);

    boolean add = true;
    for (int j = 0; j < points.size(); j++) {
      PVector p = points.get(j);
      if (dist(p.x, p.y, x, y) < (p.z+s)*0.5f) {
        add = false;
        break;
      }
    }
    if (add) {
      points.add(new PVector(x, y, s));
    }
  }

  strokeWeight(3);
  for (int i = 0; i < points.size(); i++) {
    PVector p = points.get(i); 


    noStroke();
    int cc = int(random(-7, 5));
    for (int j = 0; j < cc; j++) {
      float a1 = random(TWO_PI);
      float a2 = a1+random(PI*1.2);
      arc2(p.x, p.y, p.z, p.z*random(1, 7), a1, a2, rcol(), 240, 0);
    }
    arc2(p.x, p.y, p.z, p.z+80, 0, TWO_PI, 0, 6, 0);
    arc2(p.x, p.y, p.z, p.z+30, 0, TWO_PI, 0, 12, 0);
    fill(0, 10);
    ellipse(p.x+1, p.y+1, p.z+2, p.z+2);
    fill(rcol());
    //stroke(rcol());
    ellipse(p.x, p.y, p.z, p.z);

    fill(255, 200);
    ellipse(p.x, p.y, p.z*0.64f, p.z*0.64f);
    fill(rcol());
    ellipse(p.x, p.y, p.z*0.6f, p.z*0.6f);

    ArrayList<PVector> pp = new ArrayList<PVector>();
    for (int k = 0; k < 1000; k++) {
      float a = random(TWO_PI);
      float s = p.z*random(0.2f);
      float dd = random(p.z-s)*random(0.3f);
      float x = p.x+cos(a)*dd;
      float y = p.y+sin(a)*dd;

      boolean add = true;
      for (int l = 0; l < pp.size(); l++) {
        PVector p2 = pp.get(l);
        if (dist(p2.x, p2.y, x, y) < (p2.z+s)*0.6f) {
          add = false;
          break;
        }
      }
      if (add) {
        pp.add(new PVector(x, y, s));
      }
    }
    noStroke();
    fill(255);
    for (int j = 0; j < pp.size(); j++) {
      PVector p2 = pp.get(j);
      //ellipse(p2.x, p2.y, p2.z, p2.z);

      noStroke();
      arc2(p2.x, p2.y, p2.z, p2.z*1.2, 0, TWO_PI, 0, 10, 0);
      fill(rcol());
      ellipse(p2.x, p2.y, p2.z, p2.z);

      fill(255, 200);
      ellipse(p2.x, p2.y, p2.z*0.64f, p2.z*0.64f);
      fill(rcol());
      ellipse(p2.x, p2.y, p2.z*0.6f, p2.z*0.6f);
    }
  }
}

void arc2(float x, float y, float s1, float s2, float a1, float a2, int col, float shd1, float shd2) {
  float r1 = s1*0.5;
  float r2 = s2*0.5;
  float amp = (a2-a1);
  float ma = map(amp, 0, TWO_PI, 0, 1);
  int cc = max(1, int(max(r1, r2)*PI*ma));
  float da = amp/cc;
  for (int i = 0; i < cc; i++) {
    float ang = a1+da*i;
    beginShape();
    fill(col, shd1);
    vertex(x+cos(ang)*r1, y+sin(ang)*r1);
    vertex(x+cos(ang+da)*r1, y+sin(ang+da)*r1);
    fill(col, shd2);
    vertex(x+cos(ang+da)*r2, y+sin(ang+da)*r2);
    vertex(x+cos(ang)*r2, y+sin(ang)*r2);
    endShape(CLOSE);
  }
}


void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

//int colors[] = {#011731, #A12677, #EE3C7A, #EE2D30, #EC4532, #FFCA2A, #3DB98A, #16A5DF};
int colors[] = {#150427, #4B3878, #327BF3, #62BCEE, #C72987, #BE0223, #E87D02, #FEC801, #EEEBF5};
int rcol() {
  return colors[int(random(colors.length))];
}

int getColor(float v) {
  v = abs(v);
  v = v%(colors.length); 
  int c1 = colors[int(v%colors.length)]; 
  int c2 = colors[int((v+1)%colors.length)]; 
  return lerpColor(c1, c2, v%1);
}