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
  background(rcol());

  noStroke();
  for (int i = 0; i < 1000; i++) {
    float x = random(width); 
    float y = random(height);
    float s = width*random(0.4);

    arc2(x, y, 0, s, 0, TWO_PI, rcol(), random(250), 0);
  }

  /*
  ArrayList<PVector> circles = new ArrayList<PVector>();
   
   for (int i = 0; i < 10000; i++) {
   float x = random(width);
   float y = random(height);
   float s = width*random(0.01, 0.5);
   
   boolean add = true; 
   for (int j = 0; j < circles.size(); j++) {
   PVector c = circles.get(j);
   if (dist(x, y, c.x, c.y) <= (s+c.z)*0.5) {
   add = false;
   break;
   }
   }
   if (add) circles.add(new PVector(x, y, s));
   }
   
   for (int j = 0; j < circles.size(); j++) {
   PVector c = circles.get(j);
   noStroke();
   float ss = c.z;
   float cx = c.x; 
   float cy = c.y; 
   
   arc2(cx, cy, ss, ss*1.4, 0, TWO_PI, 0, 30, 0);
   
   fill(rcol());
   ellipse(cx, cy, ss, ss);
   
   float r = ss*random(0.35, 0.45);
   float det = random(0.01);
   int cc = int(PI*r*r*2);
   noiseDetail(1);
   for (int i = 0; i < cc; i++) {
   float rr = sqrt(random(r*r));
   float a = random(TWO_PI);
   float x = cx+cos(a)*rr;
   float y = cy+sin(a)*rr;
   float n = noise(x*det, y*det);
   fill(getColor(n*colors.length*10), 200);
   ellipse(x, y, 2, 2);
   }
   }
   */
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

int colors[] = {#121435, #FAF9F0, #EDEBCA, #FF5722};
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