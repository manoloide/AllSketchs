int seed = int(random(999999));

void setup() {
  size(3250, 3250, P2D);
  smooth(2);
  pixelDensity(2);
  generate();

  saveImage();
  exit();
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

class Triangle {
  int col;
  float x, y, a, s, amp;
  Triangle(float x, float y, float a, float s) {
    this.x = x;
    this.y = y; 
    this.a = a;
    this.s = s;
    amp = random(0.7, 0.9);
    col = rcol();
  }

  void show() {
    float da = TWO_PI/3;
    float r1 = s*0.5;
    float r2 = s*0.35;
    float r3 = s*0.2;
    noStroke();
    for (int i = 0; i < 3; i++) {
      float a1 = a+da*i;
      float a2 = a1+da;

      beginShape();
      fill(0, 30);
      vertex(x+cos(a2)*r1, y+sin(a2)*r1);
      vertex(x+cos(a1)*r1, y+sin(a1)*r1);
      fill(0, 0);
      vertex(x+cos(a1)*r1*2, y+sin(a1)*r1*2);
      vertex(x+cos(a2)*r1*2, y+sin(a2)*r1*2);
      endShape(CLOSE);


      fill(col);
      beginShape();
      vertex(x+cos(a2)*r1, y+sin(a2)*r1);
      vertex(x+cos(a1)*r1, y+sin(a1)*r1);
      fill(lerpColor(col, color(0), 0.2));
      vertex(x+cos(a1)*r2, y+sin(a1)*r2);
      vertex(x+cos(a2)*r2, y+sin(a2)*r2);
      endShape(CLOSE);

      fill(col);
      beginShape();
      vertex(x+cos(a2)*r2, y+sin(a2)*r2);
      vertex(x+cos(a1)*r2, y+sin(a1)*r2);
      fill(lerpColor(col, color(0), 0.2));
      vertex(x+cos(a1)*r3, y+sin(a1)*r3);
      vertex(x+cos(a2)*r3, y+sin(a2)*r3);
      endShape(CLOSE);
    }
  }
}

void generate() {

  background(rcol());
  randomSeed(seed);

  ArrayList<Triangle> tris = new ArrayList<Triangle>();

  for (int i = 0; i < 1000; i++) {
    tris.add(new Triangle(random(width), random(height), random(TAU), width*random(0.6)*random(0.1, 1)));
  }


  for (int i = 0; i < tris.size(); i++) {
    for (int yy = -1; yy <= 1; yy++) {
      for (int xx = -1; xx <= 1; xx++) {
        pushMatrix();
        translate(xx*width, yy*height);
        tris.get(i).show();
        popMatrix();
      }
    }
  }

  int cc = int(random(3, 26));
  float ss = width*1./cc;

  rectMode(CENTER);
  for (int j = 0; j <= cc; j++) {
    for (int i = 0; i <= cc; i++) {
      float sss = max(1, int(ss*0.02));

      fill(rcol(), 40);
      rect(i*ss, j*ss, sss*3, sss*3);
      fill(rcol());
      rect(i*ss, j*ss, sss, sss);
    }
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

//int colors[] = {#0F101E, #11142B, #28398B, #323E78, #4254A3};
int colors[] = {#FFFFFF, #559BF7, #173A7B, #FF3A3D, #FFB302};
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