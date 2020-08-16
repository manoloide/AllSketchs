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

PVector des(PVector pos, float d, float s) {
  pos.x += noise(pos.x*d, pos.y*d)*s-s*0.5; 
  pos.y += noise(pos.x*d+100, pos.y*d)*s-s*0.5;
  return pos;
}

void generate() {
  seed = int(random(999999));
  noiseSeed(seed);
  randomSeed(seed);

  background(getColor(random(colors.length)));

  ArrayList<PVector> points = new ArrayList<PVector>(); 

  for (int i = 0; i < 100000; i++) {
    float x = random(width);
    float y = random(height);
    float s = width*random(0.08, 0.3);
    boolean add = true; 
    for (int j = 0; j < points.size(); j++) {
      PVector p = points.get(j);
      if (dist(x, y, p.x, p.y) < (s+p.z)*0.6) {
        add = false;
        break;
      }
    }
    if (add) points.add(new PVector(x, y, s));
  }

  float angle = random(TWO_PI);
  for (int i = 0; i < points.size(); i++) {
    float x = points.get(i).x; 
    float y = points.get(i).y; 
    float r = points.get(i).z*0.5;
    int res = 16; 
    float da = TWO_PI/res;
    float sub = 20;
    float gro = 0.7;
    float dx = cos(angle)*r*(1-gro)*0.2;
    float dy = sin(angle)*r*(1-gro)*0.2;
    noStroke();
    for (int j = 0; j < sub; j++) {
      beginShape(POLYGON);
      fill(getColor(noise(x*0.01, y*0.01)*colors.length*3+j*0.5));
      float amp = 0.3;
      for (int k = 0; k <= res; k++) {
        float ang = da*k;
        PVector n = new PVector(x+cos(ang+da)*r+dx*j, y+sin(ang+da)*r+dy*j);
        des(n, 0.2/r, r*0.8);
        PVector p = new PVector(x+cos(ang)*r+dx*j, y+sin(ang)*r+dy*j);
        des(p, 0.2/r, r*0.8);
        //if (k == 0 || k == sub) curveVertex(p.x, p.y);
        curveVertex(p.x, p.y);

        float dis = dist(p.x, p.y, n.x, n.y)*amp;
        float angg = atan2(n.y-p.y, n.x-p.x)+HALF_PI*(1-((k%2)*2));
        n.add(p).mult(0.5).add(new PVector(cos(angg)*dis, sin(angg)*dis));
        curveVertex(n.x, n.y);
      }

      beginContour();
      for (int k = 0; k <= res; k++) {
        float ang = TWO_PI-da*k;
        PVector n = new PVector(x+cos(ang-da)*r*gro+dx*j, y+sin(ang-da)*r*gro+dy*j);
        des(n, 0.2/r, r*0.8);
        PVector p = new PVector(x+cos(ang)*r*gro+dx*j, y+sin(ang)*r*gro+dy*j);
        des(p, 0.2/r, r*0.8);
        curveVertex(p.x, p.y);


        float dis = dist(p.x, p.y, n.x, n.y)*amp;
        float angg = atan2(n.y-p.y, n.x-p.x)+HALF_PI*(1-((k%2)*2));
        n.add(p).mult(0.5).add(new PVector(cos(angg)*dis, sin(angg)*dis));
        curveVertex(n.x, n.y);
      }
      endContour();
      endShape(CLOSE);
    }
  }
}

//https://coolors.co/230d51-95e03a-f9cd04-f2eded-ff82d7
int colors[] = {#050D0f, #222423, #7C5467, #977B76, #BC9BA3, #D5A7A5, #D7BFBA, #EA7900, #E2442C, #CC2148, #9D032E};
int rcol() {
  return colors[int(random(colors.length))];
}
int getColor(float v) {
  v = v%(colors.length);
  int c1 = colors[int(v%colors.length)];
  int c2 = colors[int((v+1)%colors.length)];
  float m = v%1;//pow(v%1, 0.01);

  return lerpColor(c1, c2, m);
}