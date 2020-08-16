import controlP5.*;
ControlP5 cp5;

ArrayList<Particle> particles;
float z;
PFont font;
PGraphics render, mask;
//PImage img;

boolean hide = false;

int cantidad = 8000;
float detalle = 0.002;
float velocidad = 1;
float velZ = 0.01;
float alphaColor = 80;
float alphaBack = 5;
float timeLive = 10;
int mode = 0;

String text = "FIRPO";

boolean record = false;
boolean save = false;
int frames = 60*25;
int frameSave = 0;

void setup() {
  size(1920, 1080, P2D);

  font = createFont("Chivo", 280, true);
  frameRate(50);

  cp5 = new ControlP5(this);
  cp5.addSlider("cantidad")
    .setRange(0, 40000)
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
  cp5.addSlider("timeLive")
    .setRange(0, 20)
    .setValue(timeLive)
    .setPosition(20, 140)
    .setSize(100, 10);
  //img = loadImage("https://scontent.fgru3-2.fna.fbcdn.net/v/t1.0-1/14440964_10154608520988179_5738855555904655440_n.jpg?oh=9a5fd7d1c35eb9f29f325879277a6373&oe=58A72095");

  mask = createGraphics(width, height);
  mask.beginDraw();
  mask.background(0);
  mask.textFont(font);
  mask.textAlign(CENTER, CENTER);
  mask.fill(255);
  mask.text(text, width/2, height/2);
  mask.endDraw();

  render = createGraphics(width, height, P2D);
  render.beginDraw();
  render.background(0);
  render.endDraw();

  particles = new ArrayList<Particle>();
  generate();
}

void draw() {
  //background(0);

  if (particles.size() < cantidad) {
    int cant = (cantidad-particles.size())/10;
    if (cant == 0) cant = 1;
    for (int i = 0; i < cant; i++) {
      if (mode == 0) particles.add(new Particle());
      if (mode == 1) addCircle();
      if (mode == 2) addText();
    }
  }
  if (particles.size() > cantidad) {
    int cant = (particles.size()-cantidad)/10;
    if (cant == 0) cant = 1;
    for (int i = 0; i < cant; i++) {
      particles.remove(0);
    }
  }

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
    if (p.remove) particles.remove(i--);
  }
  render.endDraw();

  image(render, 0, 0);

  if (save && frameCount%2 == 0) {
    render.save("export/"+nf(frameSave, 4)+".tif");
    frameSave++;
    //if (frameCount > frames) exit();
    fill(255);
    text(frameSave, width-100, 10);
  }

  if (!hide) {
    render.blendMode(BLEND);
    noStroke();
    fill(180, 200);
    rect(10, 10, 160, 360);
  }
}

void keyPressed() {
  if (key == 's') saveImage();
  if (key == 'r') generate();

  if (key == ' ') mode = 0;
  if (key == 'c') mode = 1;
  if (key == 't') mode = 2;

  if (key == 'p') printData();

  if (key == 'q') {
    record = !record;
    if (record) {
      frameSave = 0;
      save = true;
    } else {
      save = false;
    }
  }

  if (key == 'h') {
    hide = !hide;
    if (hide) {
      noCursor();
      cp5.hide();
    } else {
      cursor();
      cp5.show();
    }
  }
  if (key == '1') {
    cantidad = 18000;
    detalle = 0.002;
    velocidad = 8;
    velZ = 0.01;
    alphaColor = 240;
    alphaBack = 5;
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  render.save(timestamp+".png");
}

void printData() {
  println("PRESSETTT");
  println("cantidad: ", cantidad);
  println("detalle: ", detalle);
  println("velocidad: ", velocidad);
  println("velZ: ", velZ);
  println("alphaColor: ", alphaColor);
  println("alphaBack: ", alphaBack);
  println("timeLive: ", timeLive);
  println("mode: ", mode);
}

void generate() {
  particles = new ArrayList<Particle>();
  for (int i = 0; i < cantidad; i++) {
    if (mode == 0) particles.add(new Particle());
    if (mode == 1) addCircle();
    if (mode == 2) addText();
  }
}

void addCircle() {
  float a = random(TWO_PI);
  float d = random(min(width, height)*0.4);
  float x = width/2+cos(a)*d;
  float y = height/2+sin(a)*d;
  particles.add(new Particle(x, y));
}

void addText() {
  float x = random(-50, width+50); 
  float y = random(-50, height+50);
  while (brightness(mask.get(int(x), int(y))) < 220) {
    x = random(-50, width+50); 
    y = random(-50, height+50);
  }
  particles.add(new Particle(x, y));
}

class Particle {
  boolean remove;
  float bor = 50;
  int time;
  PVector pos;
  Particle() {
    pos = new PVector(random(-bor, width+bor), random(-bor, height+bor));
    init();
  }
  Particle(float x, float y) {
    pos = new PVector(x, y);
    init();
  }

  void init() {
    time = int(timeLive*50*random(1));
    if (timeLive == 0) time = -1;
  }

  void update() {
    if (time > 0) time--;
    if (time == 0) remove = true;

    float vel = random(0.1, 0.5);
    float ang = noise(pos.x*detalle, pos.y*detalle, z)*TWO_PI*2;
    pos.add(new PVector(cos(ang)*vel*velocidad, sin(ang)*vel*velocidad));
    if (pos.x < -bor) pos.x += width+bor*2;
    if (pos.x > width+bor) pos.x -= width+bor*2;
    if (pos.y < -bor) pos.y += height+bor*2;
    if (pos.y > height+bor) pos.y -= height+bor*2;
  }

  void show() {
    render.strokeWeight(2);
    //stroke(img.get(int(pos.x), int(pos.y)));
    render.point(pos.x, pos.y);
    //line(pos.x, pos.y, ant.x, ant.y);
  }
}