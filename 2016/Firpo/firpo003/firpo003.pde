// borrar o agregar particulas dependiendo la cantidad

import controlP5.*;
ControlP5 cp5;
ColorPicker cp;

ArrayList<Particle> particles;
float z;
PGraphics render;
//PImage img;

boolean hide = false;
int cantidad = 8000;
float detalle = 0.002;
float velocidad = 1;
float velZ = 0.01;
float alphaColor = 80;
float alphaBack = 5;

void setup() {
  size(960, 960, P2D);

  cp5 = new ControlP5(this);
  cp5.addSlider("cantidad")
    .setRange(0, 20000)
    .setValue(cantidad)
    .setPosition(20, 20)
    .setSize(100, 10);
  cp5.addSlider("detalle")
    .setRange(0, 0.02)
    .setValue(detalle)
    .setPosition(20, 40)
    .setSize(100, 10);
  cp5.addSlider("velocidad")
    .setRange(0, 10)
    .setValue(velocidad)
    .setPosition(20, 60)
    .setSize(100, 10);
  cp5.addSlider("velZ")
    .setRange(0, 0.1)
    .setValue(velZ)
    .setPosition(20, 80)
    .setSize(100, 10);
  cp5.addSlider("alphaColor")
    .setRange(0, 255)
    .setValue(alphaColor)
    .setPosition(20, 100)
    .setSize(100, 10);
  cp5.addSlider("alphaBack")
    .setRange(0, 255)
    .setValue(alphaBack)
    .setPosition(20, 120)
    .setSize(100, 10);
  //img = loadImage("https://scontent.fgru3-2.fna.fbcdn.net/v/t1.0-1/14440964_10154608520988179_5738855555904655440_n.jpg?oh=9a5fd7d1c35eb9f29f325879277a6373&oe=58A72095");
  generate();

  render = createGraphics(width, height, P2D);
  render.beginDraw();
  render.background(0);
  render.endDraw();
}

void draw() {
  //background(0);

  render.beginDraw();
  render.blendMode(BLEND);
  render.fill(0, alphaBack);
  render.noStroke();
  render.rect(0, 0, width, height);

  render.blendMode(ADD);
  z += velZ;


  render.stroke(#EA6D3B, alphaColor);
  for (int i = 0; i < particles.size(); i++) {
    Particle p = particles.get(i);
    p.update();
    p.show();
  }
  render.endDraw();

  image(render, 0, 0);

  if (!hide) {
    render.blendMode(BLEND);
    noStroke();
    fill(180, 200);
    rect(10, 10, 160, 360);
  }
}

void keyPressed() {
  if (key == 's') saveImage();
  if (key == ' ') generate();
  if (key == 'c') generateCircle();
  if (key == 'h') {
    hide = !hide;
    if (hide) cp5.hide();
    else cp5.show();
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  render.save(timestamp+".png");
}

void generate() {
  particles = new ArrayList<Particle>();
  for (int i = 0; i < cantidad; i++) {
    particles.add(new Particle(random(-100, width+100), random(-100, height+100)));
  }
}

void generateCircle() {
  particles = new ArrayList<Particle>();
  for (int i = 0; i < cantidad; i++) {
    float a = random(TWO_PI);
    float d = random(min(width, height)*0.4);
    float x = width/2+cos(a)*d;
    float y = height/2+sin(a)*d;
    particles.add(new Particle(x, y));
  }
}

class Particle {
  PVector pos;
  Particle(float x, float y) {
    pos = new PVector(x, y);
  }

  void update() {
    float vel = random(0.1, 0.5);
    float ang = noise(pos.x*detalle, pos.y*detalle, z)*TWO_PI*2;
    pos.add(new PVector(cos(ang)*vel*velocidad, sin(ang)*vel*velocidad));
  }

  void show() {
    render.strokeWeight(2);
    //stroke(img.get(int(pos.x), int(pos.y)));
    render.point(pos.x, pos.y);
    //line(pos.x, pos.y, ant.x, ant.y);
  }
}