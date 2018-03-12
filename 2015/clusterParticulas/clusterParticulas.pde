float distance = 8;

ArrayList<Particle> particles;
Cluster cluster;
PGraphics mask;

void setup() {
  size(640, 640);
  cluster = new Cluster();
  particles = new ArrayList<Particle>();
  for (int i = 0; i < 8000; i++) {
    particles.add(new Particle(width*random(1), height*random(1)));
  }

  mask = createGraphics(width, height);
  mask.beginDraw();
  mask.background(0);
  mask.noStroke();
  mask.fill(255);
  mask.ellipse(width/2, height/2, 280, 280);
  int ss = 60;
  /*
  for (int j = 0; j < height; j+=ss) {
   for (int i = 0; i < width; i+=ss) {
   if ((i/ss+j/ss)%2 == 0) {
   mask.rect(i, j, ss, ss);
   }
   }
   }*/
  mask.endDraw();
}

void draw() {
  background(246);
  //image(mask, 0, 0);
  cluster.update();
  for (int i = 0; i < particles.size (); i++) {
    Particle p = particles.get(i);
    p.movement();
  }
  for (int i = 0; i < particles.size (); i++) {
    Particle p = particles.get(i);
    p.update();
    if (p.remove) particles.remove(i--);
  }
  fill(255, 0, 0);
  text("particles num: "+particles.size()+"\nFPS: "+frameRate, 20, 20);
}

void mousePressed() {
  particles.add(new Particle(mouseX, mouseY));
}

void mouseDragged() {
  particles.add(new Particle(mouseX, mouseY));
}

