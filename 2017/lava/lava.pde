ArrayList<Part> particles;
float time;
PImage text;

void setup() {
  size(640, 640, P2D);
  pixelDensity(2);
  smooth(8);
  imageMode(CENTER);
  createTexture();
  generate();
}

void draw() {
  time = millis()/1000.;
  background(0);
  blendMode(ADD);

  for (int j = 0; j < particles.size(); j++) {
    Part act = particles.get(j);
    for (int i = j+1; i < particles.size(); i++) {
      Part other = particles.get(i);
      act.calculateForce(other);
    }
  }

  for (int i = 0; i < particles.size(); i++) {
    Part p = particles.get(i);
    p.update();
    p.show();
  }
}

void keyPressed() {
  generate();
}


void createTexture() {
  int w = 64, h = 64;
  text = createImage(w, h, ARGB);
  text.loadPixels();
  for (int j = 0; j < h; j++) {
    for (int i = 0; i < w; i++) {
      float d = w/2.-dist(i, j, w*0.5, h*0.5);
      float a = 255*pow(d/28, 3);
      text.set(i, j, color(255, a));
    }
  }
  text.updatePixels();
}

void mousePressed() {
  particles.add(new Part(mouseX, mouseY));
}

void generate() {
  particles = new ArrayList<Part>();
  int cc = 0;//int(random(160));
  for (int i = 0; i < cc; i++) {
    particles.add(new Part(random(width), random(height)));
  }
}

class Part {
  float s, s1, s2, lfo; 
  int col;
  PVector pos, mov;
  Part(float x, float y) {
    pos = new PVector(x, y); 
    s2 = random(3, 200);
    s1 = s2*random(0.2, 0.6);
    lfo = random(1, 40)*random(1);
    mov = new PVector();
    col = rcol();
  }
  void update() {
    s = map(cos(lfo*time), -1, 1, s1, s2);
    pos.add(mov);
    mov = new PVector(0, 0);
  }
  void show() {
    //noStroke();
    //fill(200, 256, 240);

    float r = sqrt(s/PI)*50;
    tint(col);
    image(text, pos.x, pos.y, r, r);
    image(text, pos.x, pos.y, r*0.5, r*0.5);
    //stroke(200);
    //noFill();
    //ellipse(pos.x, pos.y, s, s);
  }

  void calculateForce(Part other) {
    float d = pos.dist(other.pos);
    float a = atan2(other.pos.y-pos.y, other.pos.x-pos.x);

    float m1 = 140-s;
    float v1 = m1-d;
    v1 = (1-abs(constrain(v1/m1, -1, 1)))*((v1 > 0)? 1 : -1);
    //v1 *= other.s/s;

    float m2 = 140-other.s;
    float v2 = m2-d;
    v2 = (1-abs(constrain(v2/m2, -1, 1)))*((v2 > 0)? 1 : -1);
    //v2 *= s/other.s;

    float vel = 0.9;
    mov.add(new PVector(cos(a)*v1*vel, sin(a)*v1*vel));
    other.mov.add(new PVector(cos(a)*v2*vel, sin(a)*v2*vel));
  }
}

int colors[] = {#FBAA7A, #FB7A7A, #44A87E, #268594, #1C588C};//#EFF2EF, #9BCDD5, #65C0CB, #308AA5, #308AA5, #85A33C, #F4E300, #E8DBD1, #CE5367, #202219};
int rcol() {
  return colors[int(random(colors.length))] ;
}