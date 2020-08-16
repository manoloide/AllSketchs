import themidibus.*; //Import the library

//AÑADIR OLITAS
// HACER QUE LLEGUEN LOS MENSAJE MIDIS
// ACOMODAR LOS AGUDOS
// AÑADIR UN NOISE DISPLACE GENERAL

//ARMAR FINAL
//MARDAR MAS PARAMETROS

import geomerative.*;

RShape grp;
RShape[] letters;


int seed = int(random(999999));
MidiBus myBus; // The MidiBus

ArrayList<Particle> particles;
float globalTime = 0;

void setup() {
  size(720, 720, P3D);
  pixelDensity(2);
  smooth(8);

  RG.init(this);
  grp = RG.getText("a little\nstory", "font.ttf", 36, CENTER);
  int cc = grp.countChildren();
  letters = new RShape[cc];
  for (int i = 0; i < cc; i++) {
    letters[i] = grp.children[i];
  }

  //MidiBus.list();
  //myBus = new MidiBus(this, 0, -1); // Create a new MidiBus with no input device and the default Java Sound Synthesizer as the output device.

  generate();
}

void draw() {

  if (frameCount%20 == 0) addParticle();

  globalTime = millis()*0.001;

  float fov = PI/3.0;
  float cameraZ = (height/2.0) / tan(fov/2.0);
  perspective(fov, float(width)/float(height), 
    cameraZ/100.0, cameraZ*10.0);


  background(#FFC045);
  translate(width*0.5, height*0.5);
  scale(map(cos(globalTime*0.4), -1, 1, 0.8, 5));
  //scale(0.6);
  translate(-width*0.5, -height*0.5);
  stroke(255, 40);
  for (int i = 0; i < width*2; i+=20) {
    line(-2, i, i, -2);
  }

  //calculateRep();

  translate(0, 0, 5);

  for (int i = 0; i < particles.size(); i++) {
    Particle p = particles.get(i);
    p.update();
    if (p.remove) particles.remove(i--);
  }

  noStroke();
  fill(#D6A539);
  pushMatrix();
  translate(6, 8);
  for (int i = 0; i < particles.size(); i++) {
    Particle p = particles.get(i);
    p.show();
  }
  popMatrix();

  noStroke();
  for (int i = 0; i < particles.size(); i++) {
    Particle p = particles.get(i);
    fill(p.col);
    p.show();
  }

  translate(width*0.5, height*0.5, 120);
  translate(1, 9);
  fill(110, 90, 0);
  fill(0);
  water(false);
  //fill(250, 155, 0);
  fill(#467948);
  translate(-1, -2);
  water(false);
}

void calculateRep() {
  for (int i = 0; i < particles.size(); i++) {
    Particle p = particles.get(i);
    p.rx = 0;
    p.ry = 0;
    for (int j = i+1; j < particles.size(); j++) {
      Particle r = particles.get(j);
      p.rep(r);
    }
    p.rep(mouseX, mouseY, 140);
  }
}

void keyPressed() {
  //generate();
  //addParticle();
  generate();
}

void generate() {
  seed = int(random(9999999));
  particles = new ArrayList<Particle>();
}

void noteOn(int channel, int pitch, int velocity) {
  addParticle();
}

void addParticle() {
  float ang = random(TWO_PI)+globalTime;
  float amp = random(0.2);
  float px = width*0.5+cos(ang)*width*amp;
  float py = height*0.5+sin(ang)*height*amp;
  particles.add(new Particle(px, py));
}

int colors[] = {#191919, #1442A6, #4AB5E7, #FFFFFF, #E74A21};
int rcol() {
  return colors[int(random(colors.length))];
}
int getColor(float v) {
  v = abs(v);
  v = v%(colors.length); 
  int c1 = colors[int(v%colors.length)]; 
  int c2 = colors[int((v+1)%colors.length)]; 
  return lerpColor(c1, c2, v%1);
}
