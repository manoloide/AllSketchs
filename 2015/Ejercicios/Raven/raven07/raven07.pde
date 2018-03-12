String txt[] = "te\namo\nmucho\namorcito\nlove\nlove".split("\n");

ArrayList<Word> words;
boolean invert;
color cf, cs;
float time = 0;
int word = 0;
PFont font;

void setup() {
  size(640, 640, P3D);
  font = createFont("Helvetica Neue Bold", 26);
  generate();
}

void draw() {
  time += 1./120;
  if (time > 1) {
    time = 0;
    invert = !invert;
    words.add(new Word(txt[word%txt.length]));
    word++;
    /*
    if (word > txt.length) {
      exit();
    }*/
  }
  color col = (invert)? color(0) : color(250);
  background(col);
  cs = (invert)? color(250) : color(0);
  stroke(cs);
  cf = (invert)? color(250) : color(0);
  fill(cf);
  translate(width/2, height/2, -300);
  for (int i = 0; i < words.size (); i++) {
    Word w = words.get(i);
    w.update();
    if (w.remove) words.remove(i--);
  }
/*
  if (frameCount%2 == 0) {
    saveFrame(nf(frameCount/2, 4)+".png");
  }
  */
}

void generate() {
  words = new ArrayList<Word>();
  time = 0;
}

class Particle {
  float size;
  float vel, elastic;
  PVector position, target;
  PVector velocity;
  Particle(float x, float y, float z, float s) {
    position = new PVector();
    target = new PVector(x, y, z);
    size = s;
    velocity = new PVector();
    vel = random(0.6, 0.82);
    elastic = random(0.01, 0.1);
  }
  void update() {

    PVector aux = new PVector(target.x-position.x, target.y-position.y, target.z-position.z);
    velocity.add(aux);
    velocity.mult(vel);
    position.add(velocity);
    /*
    PVector force = new PVector();
     force.x += (noise(position.x*0.008+frameCount*0.05)-0.5)*noise;
     force.y += (noise(position.y*0.008+frameCount*0.05)-0.5)*noise;
     force.z += (noise(position.z*0.008+frameCount*0.05)-0.5)*noise;
     position.add(force);*/
  }

  void show() {
    pushMatrix();
    translate(position.x, position.y, position.z);
    ellipse(0, 0, size, size);
    popMatrix();
  }
}


class Word {
  ArrayList<Particle> particles;
  boolean remove;
  PVector position;
  String txt;
  Word(String txt) {
    this.txt = txt;
    position = new PVector(0, 0, -1400);
    createParticles();
  }
  void update() {
    position.z += pow(1.2, 0.9+time*30);
    if (position.z > 800) remove = true;
    for (int i = 0; i < particles.size (); i++) {
      Particle p = particles.get(i);
      p.update();
    }
    show();
  }
  void show() {
    pushMatrix();
    translate(position.x, position.y, position.z);
    noStroke();
    fill(cf, 255-abs(map(position.z, -600, 800, 0, 255)));
    for (int i = 0; i < particles.size (); i++) {
      Particle p = particles.get(i);

      p.show();
    }
    popMatrix();
  }
  void createParticles() {
    int w = 140;
    int h = 40;
    particles = new ArrayList<Particle>();
    PGraphics gra = createGraphics(w, h);
    gra.beginDraw();
    gra.textFont(font);
    gra.background(0);
    gra.textSize(26);
    gra.textAlign(CENTER, CENTER);
    gra.text(txt, w/2, h/2-5);
    gra.endDraw();

    int sep = 1;
    int dd = 12;
    float tt = dd*sep*0.9;
    for (int j = 0; j < h; j+=sep) {
      for (int i = 0; i < w; i+=sep) {
        if (brightness(gra.get(i, j)) > 200)
          particles.add(new Particle(i*dd-(w/2)*dd, j*dd-(h/2)*dd, 0, tt));
      }
    }
  }
}

