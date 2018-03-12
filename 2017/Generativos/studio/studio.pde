int seed = int(random(999999));

void setup() {
  size(960, 960);
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

color back;
void render() {

  noiseSeed(seed);
  randomSeed(seed);

  noStroke();
  back = getColor(random(colors.length));
  background(back);

  /*
  noFill();
   int cc = int(random(1000));
   boolean pol = random(1) < 0.5;
   for (int i = 0; i < cc; i++) {
   float x = random(width);
   float y = random(height);
   float s = random(140);
   if (pol) {
   strokeWeight(random(1.5, 5));
   stroke(getColor(random(colors.length)));
   poly(x, y, s, int(random(3, 10)), random(TWO_PI));
   } else {
   noStroke();
   fill(getColor(random(colors.length)));
   ellipse(x, y, s, s);
   }
   }
   */

  int cx = width/2; 
  int cy = height/2;

  ArrayList<PVector> points = new ArrayList<PVector>();
  //points.add(new PVector(cx, cy, random(220, 340)));
  int cc = int(random(100000*random(1)));
  for (int i = 0; i < cc; i++) {
    float s = random(320);
    float d = random(cx*1.5-s);
    float a = random(TWO_PI);
    float x = cx+cos(a)*d;
    float y = cy+sin(a)*d;

    boolean add = true;
    for (int j = 0; j < points.size(); j++) {
      PVector p = points.get(j); 
      if (dist(x, y, p.x, p.y) < (s+p.z)*0.5) {
        add = false; 
        break;
      }
    }

    if (add) points.add(new PVector(x, y, s));
  }


  /*
  for (int i = 1; i < points.size(); i++) {
   PVector p = points.get(i);
   strokeWeight(random(1, 4));
   stroke(getColor(random(colors.length)));
   colorLine(cx, cy, p.x, p.y, int(random(2, 8)));
   }
   */


  noStroke();
  for (int i = 0; i < points.size(); i++) {
    PVector p = points.get(i);
    //
    //ellipse(p.x, p.y, p.z, p.z);
    int seg = int(random(3, 9));
    float ang = random(TWO_PI);
    noStroke();
    fill(getColor(random(colors.length)));
    //poly(p.x, p.y, p.z, seg, ang);
    float ss = max(1, p.z*random(0.01, 0.08));
    strokeWeight(ss);
    //colorPoly(p.x, p.y, p.z, seg, ang);
    colorCircle(p.x, p.y, p.z-ss, ang, seg);
  }

  /*
     float bb = 0;//random(50);
   int cc = int(random(20, 400));
   float dd = (width-bb*2)/cc;
   int seg = int(random(100));
   strokeWeight(dd*random(0.1, 0.8));
   for (int i = 0; i < cc; i++) {
   float yy = bb+dd*i;
   colorLine(bb, yy, width-bb, yy, seg);
   }
   */

  //noisee(10);
} 

void colorLine(float x1, float y1, float x2, float y2, int cc) {
  FloatList dd = new FloatList();
  dd.append(0);
  dd.append(1);
  for (int i = 0; i < cc; i++) {
    dd.append(random(1));
  }
  dd.sort();

  float a = atan2(y2-y1, x2-x1);
  float d = dist(x1, y1, x2, y2);
  float ax = x1;
  float ay = y1;
  //strokeCap(SQUARE);
  for (int i = 1; i < cc+2; i++) {
    float nx = x1+cos(a)*d*dd.get(i);
    float ny = y1+sin(a)*d*dd.get(i);
    stroke(getColor(random(colors.length)));
    line(ax, ay, nx, ny);
    ax = nx; 
    ay = ny;
  }
}

int colors[] = {#DB7654, #893D60, #D6241E, #F2AC2A, #3D71B7, #FFEEED, #85749D, #21232E, #5FA25A, #5D8EB4};
//int colors[] = {#45171D, #F03861, #FF847C, #FECEA8};

int getColor(float v) {
  v = v%(colors.length);

  int c1 = colors[int(v%colors.length)];
  int c2 = colors[int((v+1)%colors.length)];
  float m = v%1;

  m = pow(m, 8);
  return c1;
  //return lerpColor(c1, c2, m);
}


void noisee(float v) {
  for (int j = 0; j < height*2; j++) {
    for (int i = 0; i < width*2; i++) {
      float bri = random(-v, v);
      color col = get(i, j);
      col = color(red(col)+bri, green(col)+bri, blue(col)+bri);
      set(i, j, col);
    }
  }
}

void poly(float x, float y, float s, int seg, float a) {
  float r = s*0.5;
  float da = TWO_PI/seg;

  beginShape();
  for (int i = 0; i < seg; i++) {
    vertex(x+cos(da*i+a)*r, y+sin(da*i+a)*r);
  }
  endShape(CLOSE);
}

void colorPoly(float x, float y, float s, int seg, float a) {
  float r = s*0.5;
  float da = TWO_PI/seg;
  for (int i = 0; i < seg; i++) {
    colorLine(x+cos(da*i+a-da)*r, y+sin(da*i+a-da)*r, x+cos(da*i+a)*r, y+sin(da*i+a)*r, int(random(1, 4)));
  }
}

void colorCircle(float x, float y, float s, float a, int seg) {
  FloatList dd = new FloatList();
  dd.append(0);
  dd.append(1);
  for (int i = 0; i < seg; i++) {
    dd.append(random(1));
  }
  dd.sort();
  float a1 = a;
  noFill();
  for (int i = 1; i < seg+2; i++) {
    float a2 = a+dd.get(i)*TWO_PI;
    color col = getColor(random(colors.length));
    while (col == back) col = getColor(random(colors.length));
    stroke(col);
    arc(x, y, s, s, a1, a2);
    a1 = a2;
  }
}