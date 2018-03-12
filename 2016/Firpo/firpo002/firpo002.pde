ArrayList<Particle> particles;
float z;

PImage img;

void setup() {
  size(900, 900, P2D);
  //img = loadImage("https://scontent.fgru3-2.fna.fbcdn.net/v/t1.0-1/14440964_10154608520988179_5738855555904655440_n.jpg?oh=9a5fd7d1c35eb9f29f325879277a6373&oe=58A72095");
  generate();
  background(0);
  blendMode(ADD);
}

void draw() {
  //background(0);

  blendMode(BLEND);
  fill(0, 5);
  noStroke();
  rect(0, 0, width, height);

  blendMode(ADD);
  z += 0.02;

  for (int i = 0; i < particles.size(); i++) {
    Particle p = particles.get(i);
    p.update();
    p.show();
  }
}

void keyPressed() {
  if (key == 's') saveImage();
  if (key == ' ') generate();
  if (key == 'c') generateCircle();
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

void generate() {
  particles = new ArrayList<Particle>();
  for (int i = 0; i < 20000; i++) {
    particles.add(new Particle(random(-100, width+100), random(-100, height+100)));
  }
}

void generateCircle() {
  particles = new ArrayList<Particle>();
  for (int i = 0; i < 20000; i++) {
    float a = random(TWO_PI);
    float d = random(width*0.4);
    float x = width/2+cos(a)*d;
    float y = height/2+sin(a)*d;
    particles.add(new Particle(x, y));
  }
}

float det = 0.005;

class Particle {
  PVector ant, pos;
  Particle(float x, float y) {
    pos = new PVector(x, y);
  }

  void update() {
    float vel = random(0.1, 0.5);
    float ang = noise(pos.x*det, pos.y*det, z)*TWO_PI*2;
    ant = pos.copy();
    pos.add(new PVector(cos(ang)*vel, sin(ang)*vel));
  }

  void show() {
    strokeWeight(2);
    //stroke(img.get(int(pos.x), int(pos.y)));
    stroke(#EA6D3B, 80);
    point(pos.x, pos.y);
    //line(pos.x, pos.y, ant.x, ant.y);
  }
}