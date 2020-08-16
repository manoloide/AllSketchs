ArrayList<Particle> particles;
int seed;

void setup() {
  size(960, 540, P3D);
  pixelDensity(2);
  smooth(4);

  particles = new ArrayList<Particle>();
}

void draw() {
  background(5);
  randomSeed(seed);
  noiseSeed(seed);
  det = random(0.01);
  for (int i = 0; i < particles.size(); i++) {
    Particle p = particles.get(i);
    p.update(); 
    p.show(); 
    if (p.remove) particles.remove(i--);
  }
}

void mouseMoved() {
  particles.add(new Particle(mouseX, mouseY, 0));
}

void keyPressed() {
  seed = int(random(99999999));
}

float det = 0.005;

class Particle {
  boolean remove;
  float x, y, z;
  float time, maxTime;
  float ic, vc;
  Particle(float x, float y, float z) {
    this.x = x;
    this.y = y;
    this.z = z;
    time = maxTime = random(6, 12)*0.6;
    remove = false;
    ic = random(colors.length);
    vc = random(0.1)*random(0.2, 1);
  }
  void update() {
    float a1 = noise(x*det, y*det, z*det)*TAU;
    float a2 = noise(x*det, y*det, z*det)*TAU;

    x += sin(a1)*sin(a2);
    y += sin(a1)*cos(a2);
    z += cos(a2);

    time -= 1./60;
    if (time < 0) remove = true;

    ic += vc;
  }
  void show() {
    pushMatrix();
    translate(x, y, z);
    float ss = map(time, 0, maxTime, 0, 20);
    fill(getColor(ic));
    box(ss);
    popMatrix();
  }
}

int colors[] = {#FF4B00, #FFC500, #00DEB5, #3030D0, #FF97D6};
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