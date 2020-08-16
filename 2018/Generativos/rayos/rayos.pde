int seed = int(random(999999));

void setup() {
  size(3250, 3250, P2D);
  smooth(2);
  pixelDensity(2);
  generate();
  strokeWeight(3);
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
    float r = s*0.5;
    fill(col);
    beginShape();
    for (int i = 0; i < 3; i++) {
      float ang = a+da*i;
      vertex(x+cos(ang)*r, y+sin(ang)*r);
    }

    for (int i = 0; i < 3; i++) {
      float ang = a-da*i;
      vertex(x+cos(ang)*r*amp, y+sin(ang)*r*amp);
    }
    endShape(CLOSE);
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