int seed = int(random(999999));

void setup() {
  size(960, 960, P2D);
  smooth(8);
  pixelDensity(2);

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

void generate() {
  background(80);

  float des = random(10000);
  float det = random(0.01)*random(1);
  noiseDetail(1);//int(random(1, 5)));

  ArrayList<PVector> cells = new ArrayList<PVector>();

  for (int k = 0; k < 30000; k++) {
    float cx = width*random(-0.1, 1.1);
    float cy = height*random(-0.1, 1.1);
    float ss = width*random(0.02, 0.6);

    boolean addc = true;
    for (int i = 0; i < cells.size(); i++) {
      PVector c = cells.get(i);
      if (dist(cx, cy, c.x, c.y) < (ss+c.z)*0.5) {
        addc = false;
        break;
      }
    }

    if (addc) cells.add(new PVector(cx, cy, ss));
    else continue;

    ArrayList<PVector> points = new ArrayList<PVector>();
    for (int i = 0; i < 100000; i++) {
      float x = cx+random(ss)-ss*0.5;
      float y = cy+random(ss)-ss*0.5;
      float s = random(ss)*random(0.8)*random(0.5, 1);
      if (dist(cx, cy, x, y) > ss*0.5 || s < 0.5) continue;
      boolean add = true;
      for (int j = 0; j < points.size(); j++) {
        PVector p = points.get(j); 
        if (dist(x, y, p.x, p.y) < (s+p.z)*0.52) {
          add = false;
          break;
        }
      }
      if (add) points.add(new PVector(x, y, s));
    }

    for (int i = 0; i < points.size(); i++) {
      PVector p = points.get(i);
      float r = p.z*0.5;
      int res = int(max(8, PI*r));
      float da = TWO_PI/res;
      fill(rcol());
      noStroke();
      beginShape();
      for (int j = 0; j < res; j++) {
        PVector v = new PVector(p.x+cos(da*j)*r, p.y+sin(da*j)*r);
        v = displace(v, des, det);
        vertex(v.x, v.y);
      }
      endShape(CLOSE);
    }
  }
} 

PVector displace(PVector v, float des, float det) {
  float a = noise(des+v.x*det, des+v.y*det)*TWO_PI;
  float d = noise(1000+des+v.x*det, 1000+des+v.y*det)*300;
  return new PVector(v.x+cos(a)*d, v.y+sin(a)*d);
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2); 
  saveFrame(timestamp+".png");
}

//int colors[] = {#DF2601, #7A04C4, #1DCCBB, #F4F4F4, #FFD71D};
int colors[] = {#EA554F, #FAC745, #2760AB, #369952, #1E2326, #FFF7F3}; 
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