int seed = int(random(999999));

void setup() {
  size(960, 960, P2D);
  smooth(8);
  strokeWeight(2);
  pixelDensity(2);
  generate();

  //saveImage();
  //exit();
}

void draw() {
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
  background(#FBFBFB);
  randomSeed(seed);

  float det = random(0.01);
  float des = random(10000);

  ArrayList<PVector> circles = new ArrayList<PVector>();
  float max = width*random(0.0625, 0.1875);
  float min = max*random(0.01, 0.2);
  float pwr = random(0.5, 1.2);
  int cc = 200000;
  float sep = random(1.2, 2.4);
  for (int i = 0; i < cc; i++) {
    float x = random(width);
    float y = random(height);
    float n = noise(des+x*det, des+y*det);
    float s = map(pow(n, pwr), 0, 1, min, max);

    if (i > cc/2) s *= map(i, cc/2, cc, 1, 0.1);

    boolean add = true;
    for (int j = 0; j < circles.size(); j++) {
      PVector c = circles.get(j);
      if (dist(x, y, c.x, c.y) < (c.z+s)*sep*0.5) {
        add = false;
        break;
      }
    }

    if (add) {
      circles.add(new PVector(x, y, s));
    }
  }

  noStroke();
  for (int i = 0; i < circles.size(); i++) {
    PVector c = circles.get(i);

    fill(rcol());
    ellipse(c.x, c.y, c.z, c.z);

    if (random(1) < 0.05) {
      fill(#FBFBFB);
      ellipse(c.x, c.y, c.z*0.4, c.z*0.4);
    }

    if (random(1) < 0.1) {

      noFill();
      stroke(0);
      poly(c.x, c.y, c.z-2, random(TAU), int(random(3, 7)));
      noStroke();
    }


    if (random(1) < 0.2) {
      noFill();
      stroke(0);
      ellipse(c.x, c.y, c.z*sep, c.z*sep);
      noStroke();
    }

    if (random(1) < 20.2) {
      arc2(c.x, c.y, c.z, c.z*0.5, 0, TAU, rcol(), 14, 0);
    }
  }

  stroke(0);
  for (int i = 0; i < circles.size()*10; i++) {
    PVector c1 = circles.get(int(random(circles.size())));
    PVector c2 = circles.get(int(random(circles.size())));

    if (dist(c1.x, c1.y, c2.x, c2.y) < (c1.z+c2.z)*sep*0.7) {
      line(c1.x, c1.y, c2.x, c2.y);
      fill(0);
      ellipse(c1.x, c1.y, c1.z*0.1, c1.z*0.1);
      ellipse(c2.x, c2.y, c2.z*0.1, c2.z*0.1);
    }
  }
}

void poly(float x, float y, float s, float a, int seg) {
  float r = s*0.5;
  float da = TAU/seg; 
  beginShape();
  for (int i = 0; i < seg; i++) {
    float ang = a+da*i;
    vertex(x+cos(ang)*r, y+sin(ang)*r);
  }
  endShape(CLOSE);
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

//int colors[] = {#0F101E, #11142B, #28398B, #323E78, #4254A3};
int colors[] = {#313CCB, #4E99ED, #27B360, #FF603A, #FFDE55, #FF9EE3};
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