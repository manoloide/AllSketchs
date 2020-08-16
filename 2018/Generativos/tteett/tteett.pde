int seed = int(random(999999));

void setup() {
  size(960, 960, P2D);
  smooth(8);
  pixelDensity(2);
  generate();
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

      float s1 = 0;
      float s2 = 0.2;

      beginShape();
      fill(0, 20);
      vertex(x+cos(a2)*r1, y+sin(a2)*r1);
      vertex(x+cos(a1)*r1, y+sin(a1)*r1);
      fill(0, 0);
      vertex(x+cos(a1)*r1*2, y+sin(a1)*r1*2);
      vertex(x+cos(a2)*r1*2, y+sin(a2)*r1*2);
      endShape(CLOSE);

      beginShape();
      fill(lerpColor(col, color(0), s1));
      vertex(x+cos(a2)*r1, y+sin(a2)*r1);
      vertex(x+cos(a1)*r1, y+sin(a1)*r1);
      fill(lerpColor(col, color(0), s2));
      vertex(x+cos(a1)*r2, y+sin(a1)*r2);
      vertex(x+cos(a2)*r2, y+sin(a2)*r2);
      endShape(CLOSE);

      beginShape();
      fill(lerpColor(col, color(0), s1));
      vertex(x+cos(a2)*r2, y+sin(a2)*r2);
      vertex(x+cos(a1)*r2, y+sin(a1)*r2);
      fill(lerpColor(col, color(0), s2));
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
  tris.add(new Triangle(width*0.5, height*0.5, random(TAU), width*random(2.4, 3.8)));

  int sub = int(random(80));
  for (int i = 0; i < sub; i++) {
    Triangle t = tris.get(i);
    tris.add(new Triangle(t.x, t.y, t.a+PI, t.s*0.5));
    tris.add(new Triangle(t.x+cos(t.a)*t.s*0.25, t.y+sin(t.a)*t.s*0.25, t.a, t.s*0.5));
    tris.add(new Triangle(t.x+cos(t.a+TAU/3)*t.s*0.25, t.y+sin(t.a+TAU/3)*t.s*0.25, t.a, t.s*0.5));
    tris.add(new Triangle(t.x+cos(t.a-TAU/3)*t.s*0.25, t.y+sin(t.a-TAU/3)*t.s*0.25, t.a, t.s*0.5));
    tris.remove(t);
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
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

//int colors[] = {#0F101E, #11142B, #28398B, #323E78, #4254A3};
int colors[] = {#FEFEFE, #FDCB0A, #06B2C4, #0B2240, #EA048B};
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